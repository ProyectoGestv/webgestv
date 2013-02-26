class ManRsc
  include Mongoid::Document
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  field :name, type: String
  field :desc, type: String
  embeds_one :conn
  attr_accessible :name, :desc
end
