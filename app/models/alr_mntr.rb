# -*- encoding : utf-8 -*-
class AlrMntr
  include Mongoid::Document
  field :descr, type: String
  field :ctgry, type: String
  field :state, type: String
  field :impact, type: String
end
