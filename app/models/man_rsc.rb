# -*- encoding : utf-8 -*-

class ManRsc
  include Mongoid::Document
  validates_presence_of :name, message: 'Nombre no puede estar vacío'
  validates_uniqueness_of :name, case_sensitive: false, message: 'Ya existe un elemento con el mismo Nombre'
  field :name, type: String
  field :domain, type: String
  field :desc, type: String
  field :mngbl, type:Boolean, default: false
  field :alrtbl, type:Boolean, default:false
  field :ref_prot, type: String
  field :on, type:Boolean, default: false
  embeds_one :conn
  has_many :mcr_atrs
  accepts_nested_attributes_for :conn
  accepts_nested_attributes_for :mcr_atrs
  attr_accessible :name, :desc, :domain, :mcr_atrs_attributes, :mngbl
  before_destroy :delete_mcr_atrs, :delete_links

  private
  def delete_mcr_atrs
    puts 'borrando mcr_atrs'
    self.mcr_atrs.each do |mcratr|
      mcratr.destroy
    end
  end

  def delete_links
    puts 'borrando conexiones'
    Link.all.each do |link|
      if link.link_a==self.name || link.link_b==self.name
        link.destroy
      end
    end
  end
end
