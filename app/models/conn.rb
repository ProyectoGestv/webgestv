# -*- encoding : utf-8 -*-
require 'socket'
require 'timeout'
class Conn
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  include Mongoid::Document
  validates_presence_of :ip, message: 'Dirección IP no puede estar vacía'
  validates_numericality_of :port, :only_integer => true, :allow_nil => false,
                            :greater_than_or_equal_to => 1,
                            :message => "Puerto debe ser un número entero mayor a 0."
  validates_presence_of :port, message: 'Puerto no puede estar vacío'
  validates :ip, format: { with: @ip_regex, message: 'Dirección IP solo acepta el formato: xxx.xxx.xxx.xxx' }
  field :ip, type: String
  field :port, type: Integer
  embedded_in :man_rsc
  accepts_nested_attributes_for :man_rsc
  attr_accessible :man_rsc, :ip, :port

end
