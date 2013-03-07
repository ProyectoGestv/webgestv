# -*- encoding : utf-8 -*-
class Serv < ManRsc
  belongs_to :mother, :class_name => 'NetEle', inverse_of: :children
  attr_accessible :mother
  validates_presence_of :mother, message: 'Debe seleccionar un repositorio'
end
