# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Serv.delete_all
#NetEle.delete_all
#LaynetEle.delete_all
#McrAtr.delete_all
#Atr.delete_all
#Alrt.delete_all
#Hst.delete_all

a1=Atr.create(name:"a62", desc: "attribute5", tipo: "integer")


i = 12

  conn0= Conn.new(ip: "1.1.0.#{i}", port: i)
  laynetele = LaynetEle.create(name: "nle#{i}", domain:'SNMPServerIntegration', desc: "network layer element #{i}")
  laynetele.conn=conn0
  conn1= Conn.new(ip: "1.1.1.#{i}", port: i)
  netele = NetEle.create(name: "n#{i}", domain:'SNMPServerIntegration', desc: "network element #{i}")
  netele.conn=conn1
  conn2=Conn.new(ip: "1.1.1.#{i}", port: 100+i)
  serv=Serv.create(name:"s#{i}",  domain: netele.name, desc: "service #{i}", mother: netele._id)
  serv.conn=conn2
  #ma=McrAtr.create(name:"ma#{i}", desc: "macro attribute #{i}", tipo: "simple")
  ma=McrAtr.find_by(:name=> 'ma12')
  serv.mcr_atrs << ma
  ma.atrs << a1

  h1 = Hst.create(valuee: 10+i , tstamp: Chronic.parse('today').to_i)
  a1.hsts << h1

  h2 = Hst.create(valuee: 1+i , tstamp: Chronic.parse('tomorrow').to_i)
  a1.hsts << h2

  h3 = Hst.create(valuee: 1+i , tstamp: Chronic.parse('this second').to_i)
  a1.hsts << h3

  h4 = Hst.create(valuee: 1+i , tstamp: Chronic.parse('this morning').to_i)
  a1.hsts << h4

  h5 = Hst.create(valuee: 1+i , tstamp: Chronic.parse('last week').to_i)
  a1.hsts << h5

  h6 = Hst.create(valuee: 1+i , tstamp: Chronic.parse('last month').to_i)
  a1.hsts << h6

  al1=Alrt.create(title:"notif #{i}", msg:"alerta de notificacion #{i}", tipo:'notif')
  a1.alrts << al1
  al2=Alrt.create(title:"anmly #{i}", msg:"alerta de anomalia #{i}", tipo:'anmly')
  a1.alrts << al2
  al3=Alrt.create(title:"alarm #{i}", msg:"alerta de alarma #{i}", tipo:'alarm')
  a1.alrts << al3


 
  