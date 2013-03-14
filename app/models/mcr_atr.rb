class McrAtr
  include Mongoid::Document
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :man_rsc
  field :name, type: String
  field :desc, type: String
  field :ref_prot, type: String
  belongs_to :man_rsc
  has_many :atrs
end
