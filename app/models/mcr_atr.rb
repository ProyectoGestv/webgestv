# -*- encoding : utf-8 -*-
class McrAtr
  include Mongoid::Document
  validates_presence_of :name, message: 'Nombre no puede estar vacío'
  validates_uniqueness_of :name, scope: :man_rsc, message: 'Ya existe un Grupo de atributos con el mismo Nombre'
  validates_presence_of :tipo, message: 'Tipo no puede estar vacío'
  field :name, type: String
  field :desc, type: String
  field :ref_prot, type: String
  field :tipo, type: String
  belongs_to :man_rsc
  has_many :alrts
  has_many :atrs
  embeds_one :alr_mon, :class_name => 'AlrMntr'
  accepts_nested_attributes_for :atrs, :alr_mon
  before_destroy :delete_atrs, :delete_alrts
  attr_accessible :name, :desc, :ref_prot, :tipo, :atrs_attributes, :alrts

  private

  def delete_atrs
    puts 'borrando atrs'
    self.atrs.each do |atr|
      atr.destroy
    end
  end

  def delete_alrts
    puts 'borrando mcratr alrts'
    self.alrts.each do |alrt|
      alrt.destroy
    end
  end

end
