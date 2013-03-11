# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Serv.delete_all
NetEle.delete_all
LaynetEle.delete_all
(1..5).each do |i|
  conn0= Conn.new(ip: "1.1.0.#{i}", port: i)
  laynetele = LaynetEle.create(name: "nle#{i}", desc: "network layer element #{i}")
  laynetele.conn=conn0
  conn1= Conn.new(ip: "1.1.1.#{i}", port: i)
  netele = NetEle.create(name: "n#{i}", desc: "network element #{i}")
  netele.conn=conn1
  conn2=Conn.new(ip: "1.1.1.#{i}", port: 100+i)
  serv=Serv.create(name:"s#{i}", desc: "service #{i}", mother: netele._id)
  serv.conn=conn2
end

