# -*- encoding : utf-8 -*-
class Serv < ManRsc
  field :active, type:Boolean, default: false
  field :on, type:Boolean, default: false
  belongs_to :mother, :class_name => 'NetEle', inverse_of: :children
  attr_accessible :mother, :on, :active
  validates_presence_of :mother, message: 'Debe seleccionar un repositorio'
  validate :repovalid, :conn
  after_create :create_link

  private

  def create_link
    linka=self.name
    linkb=self.mother.name
    link=Link.new(desc: "Cx #{linka}-#{linkb}", link_a: linka, link_b: linkb)
    link.save!
  end

  def repovalid
    self.conn.errors.messages.delete(:ip) if self.conn.ip == ''
  end

end
