# -*- encoding : utf-8 -*-
require 'socket'
require 'timeout'
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

  def is_port_open?(ip, port)
    begin
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new(ip, port)
          s.close
          puts "it works"
          puts "//////////////////////////////////////"
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          puts "dont work"
          puts "//////////////////////////////////////"
          return false
        end
      end
    rescue Timeout::Error
    end

    return false
  end
end

#alert("works "+document.getElementById(\'conn_ip\').value)
#= f.submit "Test me!", :type => 'button', :onclick => @conn.is_port_open?("#{document.getElementById('conn_ip').value}",'3000')
#    = link_to "Get remote sauce", {:action => "sauce"}, :remote => true, :class => "button-link"