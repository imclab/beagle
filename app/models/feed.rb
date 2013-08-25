#encoding: utf-8
require 'digest'
class Feed
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	field :url, type: String
	field :description, type: String
	field :etag, type: String
	field :last_modified, type: Time
	field :refreshed_at, type: Time

	index etag: 1
	index refreshed_at: 1

	validates_presence_of :url
	validates_format_of :url, :with => URI::regexp(%w(http https))

	has_many :entries

	after_create :load_and_refresh

	def load!
		feed = Feedzirra::Feed.fetch_and_parse(self.url)
		self.title = feed.title
		self.etag = feed.etag || Digest::MD5.hexdigest(self.url)
		self.save!
	end

	def refresh!
		if self.entries.count == 0 
			feed = Feedzirra::Feed.fetch_and_parse(url)
			new_entries = feed.entries
		else
			 f = Feedzirra::Parser::RSS.new
			 f.feed_url = self.url
			 f.etag = self.etag
			 f.last_modified = self.last_modified

			 last_entry = Feedzirra::Parser::RSSEntry.new
			 last_entry.url = self.entries.last.url
			 
			 f.entries << last_entry

			 updated_feed = Feedzirra::Feed.update f
			 new_entries = []
			 new_entries = updated_feed.new_entries if updated_feed.updated?
		end

		new_entries.each do |entry|
			self.entries.create!(title: entry.title, url: entry.url, author: entry.author, summary: entry.summary, content: entry.content, published_at: entry.published || Time.now, categories: entry.categories)
		end
		new_entries.count
		self.refreshed_at = Time.now
		self.save!
	end

	private
	def load_and_refresh
		self.delay.load!
		self.delay.refresh!
	end
	

end