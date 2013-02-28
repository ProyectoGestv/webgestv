# -*- encoding : utf-8 -*-
class Conn
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  include Mongoid::Document
  validates_presence_of :ip, message: 'Dirección IP no puede estar vacía'
  validates_presence_of :port, message: 'Puerto no puede estar vacío'
  validates :port, numericality: { only_integer: true , message: 'Puerto solo acepta números'}
  validates :ip, format: { with: @ip_regex, message: 'Dirección IP solo acepta el formato: xxx.xxx.xxx.xxx' }
  field :ip, type: String
  field :port, type: Integer
  embedded_in :man_rsc
end
