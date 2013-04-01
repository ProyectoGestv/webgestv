# -*- encoding : utf-8 -*-
class McrAtr
  include Mongoid::Document
  validates_presence_of :name, message: 'Nombre no puede estar vacío'
  validates_uniqueness_of :name, scope: :man_rsc, message: 'Ya existe un Grupo de atributos con el mismo Nombre'
  field :name, type: String
  field :desc, type: String
  field :ref_prot, type: String
  field :type, type: String, default: 'simple'
  belongs_to :man_rsc
  has_many :atrs
  accepts_nested_attributes_for :atrs
  before_destroy :delete_atrs
  attr_accessible :name, :desc, :ref_prot, :atrs_attributes
  private
  def delete_atrs
    self.atrs.each do |atr|
      atr.destroy
    end
  end
end
