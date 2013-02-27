class NetEle < ManRsc
  has_many :children, :class_name => 'NetEle', inverse_of: :mother
  has_many :children, :class_name => 'Serv', inverse_of: :mother
  belongs_to :mother, :class_name => 'NetEle', inverse_of: :children
  attr_accessible :mother, :children
end
