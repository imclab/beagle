#encoding: utf-8
require 'digest'
class Feed
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	field :url, type: String
	field :description, type: String
	field :slug, type: String
	field :refreshed_at, type: DateTime

	index slug: 1
	index refreshed_at: 1

	validates_presence_of :title, :url, :slug

	has_many :entries

	before_create :generate_slug


	private
	def generate_slug
		self.slug = Digest::MD5.hexdigest self.url
	end

end