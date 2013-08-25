#encoding: utf-8
class Entry
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	field :url, type: String
	field :author, type: String
	field :summary, type: String
	field :content, type: String
	field :published_at, type: Time
	field :categories, type: Array

	index published_at: 1
	index url: 1

	validates_presence_of :title, :url

	belongs_to :feed

end