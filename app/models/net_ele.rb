# -*- encoding : utf-8 -*-
class NetEle < ManRsc
  #has_many :children, :class_name => 'NetEle', inverse_of: :mother, dependent: :restrict
  has_many :children, :class_name => 'Serv', inverse_of: :mother, dependent: :restrict
  attr_accessible :children
end
