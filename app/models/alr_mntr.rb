# -*- encoding : utf-8 -*-
class AlrMntr
  include Mongoid::Document
  field :descr, type: String
  field :ctgry, type: String
  field :state, type: String, default: 'act'
  field :impact, type: String, default: 'bajo'
end
