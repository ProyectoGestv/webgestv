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
  has_many :alrts
  has_many :atr_hsts
  has_one :monitor_atr_composite
  embeds_one :qos_mon, :class_name => 'AlrMntr'
  embeds_one :alr_mon, :class_name => 'AlrMntr'
  accepts_nested_attributes_for :qos_mon, :alr_mon
  attr_accessible :name, :desc, :ref_prot, :tipo, :rdbl, :wtbl, :value, :mcr_atr, :alrts
  before_destroy :delete_atr_hsts, :delete_alrts

  private

  def delete_atr_hsts
    puts 'borrando atr_hsts'
    self.atr_hsts.each do |hst|
      hst.destroy
    end
  end

  def delete_alrts
    puts 'borrando atr alrts'
    self.alrts.each do |alrt|
      alrt.destroy
    end
  end

end
