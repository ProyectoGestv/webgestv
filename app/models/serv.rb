# -*- encoding : utf-8 -*-
class Serv < ManRsc
  field :active, type:Boolean, default: false
  field :on, type:Boolean, default: false
  belongs_to :mother, :class_name => 'NetEle', inverse_of: :children
  attr_accessible :mother, :on, :active
  validates_presence_of :mother, message: 'Debe seleccionar un repositorio'
end
