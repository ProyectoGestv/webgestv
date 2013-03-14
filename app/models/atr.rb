class Atr
  include Mongoid::Document
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :mcr_atr
  validates_presence_of :type
  field :name, type: String
  field :desc, type: String
  field :ref_prot, type: String
  field :type, type: String
  field :value, type: String
  field :rdbl, type: Boolean, default: true
  field :wtbl, type: Boolean, default: false
  belongs_to :mcr_atr
end
