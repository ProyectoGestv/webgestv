class Composite
  include ActiveAttr::Model

  attribute :paracomp
  attribute :atrcomp
  attribute :hst_id

  attr_accessible :paracomp, :atrcomp
  validates_presence_of :paracomp
  validates_presence_of :atrcomp
end