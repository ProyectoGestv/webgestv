# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  (1..2).each do |t|
    a6=Atr.find_by(:id => '5268024ad1b39c002900006e')
    h1 = AtrHst.create(value: t+20 , tstamp: Chronic.parse('15 hours ago').to_i)
    a6.atr_hsts << h1

    a7=Atr.find_by(:id => '5268024bd1b39c00290000d3')
    h2 = AtrHst.create(value: t+20 , tstamp: Chronic.parse('15 hours ago').to_i)
    a7.atr_hsts << h2

    a8=Atr.find_by(:id => '5268024bd1b39c0029000138')
    h3 = AtrHst.create(value: t+20 , tstamp: Chronic.parse('15 hours ago').to_i)
    a8.atr_hsts << h3

    a9=Atr.find_by(:id => '52680249d1b39c0029000009')
    h4 = AtrHst.create(value: t+20 , tstamp: Chronic.parse('15 hours ago').to_i)
    a9.atr_hsts << h4
  end
