class ManRsc
  include Mongoid::Document
  field :name, type: String
  field :desc, type: String
  embeds_one :conn
end
