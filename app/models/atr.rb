# -*- encoding : utf-8 -*-
class Atr
  include Mongoid::Document
  validates_presence_of :name, message: 'Nombre no puede estar vacío'
  validates_uniqueness_of :name, scope: :mcr_atr, message: 'Ya existe un atributo con el mismo Nombre'
  validates_presence_of :type, message: 'Tipo no puede estar vacío'
  field :name, type: String
  field :desc, type: String
  field :ref_prot, type: String
  field :type, type: String, default:'Integer'
  field :value, type: String
  field :rdbl, type: Boolean, default: true
  field :wtbl, type: Boolean, default: false
  belongs_to :mcr_atr
  attr_accessible :name, :desc, :ref_prot, :type, :rdbl, :wtbl, :value, :mcr_atr
end
