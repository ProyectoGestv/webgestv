# -*- encoding : utf-8 -*-
class Atr
  include Mongoid::Document
  validates_presence_of :name, message: 'Nombre no puede estar vacío'
  validates_uniqueness_of :name, scope: :mcr_atr, message: 'Ya existe un atributo con el mismo Nombre'
  validates_presence_of :tipo
  field :name, type: String
  field :desc, type: String
  field :ref_prot, type: String
  field :tipo, type: String, default: 'Integer'
  field :value, type: String
  field :rdbl, type: Boolean, default: true
  field :wtbl, type: Boolean, default: false
  belongs_to :mcr_atr
  embeds_one :alr_mntr
  accepts_nested_attributes_for :alr_mntr
  attr_accessible :name, :desc, :ref_prot, :tipo, :rdbl, :wtbl, :value, :mcr_atr, :alr_mntr_attributes
end
