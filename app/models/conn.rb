class Conn
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  include Mongoid::Document
  validates_presence_of :ip,:port
  validates :port, numericality: { only_integer: true }
  validates :ip, format: { with: @ip_regex }
  field :ip, type: String
  field :port, type: Integer
  embedded_in :man_rsc
end
