class ManRsc
  include Mongoid::Document
  field :name, type: String
  field :desc, type: String
  embeds_one :conn
  has_many :childs, :class_name => 'ManRsc'
  belongs_to :mother, :class_name => 'ManRsc'

end
