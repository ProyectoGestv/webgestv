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
McrAtr.delete_all
Atr.delete_all
Alrt.delete_all
User.delete_all

=begin

macomposite=McrAtr.create(name:"ma12", desc: "macro attribute composite", tipo: "composite")

(1..2).each do |i|
  conn0= Conn.new(ip: "1.1.0.#{i}", port: i)
  laynetele = LaynetEle.create(name: "nle#{i}", domain:'SNMPServerIntegration', desc: "network layer element #{i}")
  laynetele.conn=conn0
  conn1= Conn.new(ip: "1.1.1.#{i}", port: i)
  netele = NetEle.create(name: "n#{i}", domain:'SNMPServerIntegration', desc: "network element #{i}")
  netele.conn=conn1
  conn2=Conn.new(ip: "1.1.1.#{i}", port: 100+i)
  serv=Serv.create(name:"s#{i}",  domain: netele.name, desc: "service #{i}", mother: netele._id)
  serv.conn=conn2
  ma=McrAtr.create(name:"ma#{i}", desc: "macro attribute #{i}", tipo: "simple")

  serv.mcr_atrs << ma
  serv.mcr_atrs << macomposite
  (10..20).each do |t|
    a5=Atr.create(name:"a#{t+20+i}", desc: "attribute #{t+20+i}", tipo: "integer")
    macomposite.atrs << a5
    (1..100).each do |n|
      h1 = AtrHst.create(value: 1+i+n , tstamp: Chronic.parse('today').to_i)
      a5.atr_hsts << h1
    end

  end
  (21..22).each do |t|
    a6=Atr.create(name:"a#{t+20+i}", desc: "attribute #{t+20+i}", tipo: "string")
    macomposite.atrs << a6

    h1 = AtrHst.create(value: t+10+i , tstamp: Chronic.parse('today').to_i)
    a6.atr_hsts << h1

  end
  a1=Atr.create(name:"a#{i}", desc: "attribute #{i}", tipo: "integer")
  a2=Atr.create(name:"a#{i+20}", desc: "attribute #{i+20}", tipo: "integer")
  ma.atrs << a1

  tsini=Time.now.to_i+i
  al1=Alrt.create(tipo: 'alarm', title:'GENERAL_TEST_ERROR', msg:"alerta de notificacion #{i}", tstamp_ini: tsini, tstamp_last: tsini, count: 1, state: 'noAtt')
  al2=Alrt.create(tipo: 'anmly', title:'THRESHOLD_VALUE_EXCEEDED', msg:"warning de notificacion #{i}", tstamp_ini: tsini, tstamp_last: tsini, count: 1, state: 'noAtt')
  al3=Alrt.create(tipo: 'notif', title:'RESOURCE_ALIVE', msg:"info de notificacion #{i}", tstamp_ini: tsini, tstamp_last: tsini, count: 1, state: 'noAtt')
  a1.alrts << al1
  al2=Alrt.create(title:"anmly #{i}", msg:"alerta de anomalia #{i}", tipo:'anmly')
  a1.alrts << al2
  al3=Alrt.create(title:"alarm #{i}", msg:"alerta de alarma #{i}", tipo:'alarm')
  a1.alrts << al3

  h1 = AtrHst.create(value: 10+i , tstamp: Chronic.parse('today').to_i)
  a1.atr_hsts << h1
  h2 = AtrHst.create(value: 1+i , tstamp: Chronic.parse('tomorrow').to_i)
  a1.atr_hsts << h2
  h3 = AtrHst.create(value: 1+i , tstamp: Chronic.parse('this second').to_i)
  a1.atr_hsts << h3
  h4 = AtrHst.create(value: 1+i , tstamp: Chronic.parse('this morning').to_i)
  a1.atr_hsts << h4
  h5 = AtrHst.create(value: 1+i , tstamp: Chronic.parse('last week').to_i)
  a1.atr_hsts << h5
  h6 = AtrHst.create(value: 1+i , tstamp: Chronic.parse('last month').to_i)
  a1.atr_hsts << h6
end

conn1= Conn.new(ip: "192.168.119.163", port: 1)
netele = NetEle.create(name: "broadcaster", domain:'SNMPServerIntegration', desc: "broadcaster")
netele.conn=conn1

conn2=Conn.new(ip: "192.168.119.163", port: 10000)
serv=Serv.create(name:"Parrilla",  domain: netele.name, desc: "parrilla", mother: netele._id)
serv.conn=conn2
conn3=Conn.new(ip: "192.168.119.163", port: 10001)
serv=Serv.create(name:"Webservices",  domain: netele.name, desc: "webservices", mother: netele._id)
serv.conn=conn3

=end

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'admin', :role => 'admin', :email => 'admin@example.com', :password => 'admin123', :password_confirmation => 'admin123'
puts 'New user created: ' << user.name
user2 = User.create! :name => 'operario', :role => 'oper', :email => 'operario@example.com', :password => 'operario123', :password_confirmation => 'operario123'
puts 'New user created: ' << user2.name