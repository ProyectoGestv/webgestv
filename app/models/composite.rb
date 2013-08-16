class Composite
  include ActiveAttr::Model

  attribute :paracomp
  attribute :atrcomp
  attribute :datostabla

  attr_accessible :paracomp, :atrcomp
  validates_presence_of :paracomp
  validates_presence_of :atrcomp
end