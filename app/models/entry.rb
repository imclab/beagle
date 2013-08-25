#encoding: utf-8
class Entry
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	field :url, type: String
	field :description, type: String
	field :content, type: String

	index url: 1

	validates_presence_of :title, :url

	belongs_to :feed

end