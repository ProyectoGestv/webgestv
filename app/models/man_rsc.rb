# -*- encoding : utf-8 -*-

class ManRsc
  include Mongoid::Document
  validates_presence_of :name, message: 'Nombre no puede estar vacío'
  validates_uniqueness_of :name, case_sensitive: false, message: 'Ya existe un elemento con el mismo Nombre'
  field :name, type: String
  field :desc, type: String
  field :mngbl, type:Boolean, default: false
  field :alrtbl, type:Boolean, default:false
  field :ref_prot, type: String
  embeds_one :conn
  has_many :mcr_atrs
  attr_accessible :name, :desc
  accepts_nested_attributes_for :conn
end
