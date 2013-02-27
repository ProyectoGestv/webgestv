class Serv < ManRsc
  belongs_to :mother, :class_name => 'NetEle', inverse_of: :children
  attr_accessible :mother
end
