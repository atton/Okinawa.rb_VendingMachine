#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'pp'

class Drink
  def initialize name,price
    @name = name
    @price = price
  end

  def get_name
    @name
  end

  def get_price
    @price
  end
end


class Vending_machine

  def initialize
    lemon_tea = Drink.new("lemon_tea",110)
    cocoa = Drink.new("cocoa",120)
    coffie = Drink.new("coffie",100)

    @drinks = [lemon_tea,cocoa,coffie]
    @money = 0
  end

  def add_money money
    @money += money.to_i
    puts "#{money} 円入れました"
  end

  def buy_drinks
    puts "買いたい飲み物を選んでください"
    @drinks.each_with_index do |item,index|
      puts "[#{index}] : #{item.get_name} : #{item.get_price} "
    end
    num = gets.chomp 
    buy_calc @drinks[num]
  end

  def show_money
    puts "自動販売機の中には #{@money} 円入っています"
  end

  def show_drinks 
    puts "今販売しているのは"

    @drinks.each_with_index do |item,num|
      puts "#{num} : #{item.get_name} : 値段 #{item.get_price}"
    end
    puts "です。"
  end

  private

  def buy_calc drink
    puts "#{drink.get_name} を買います"
    if drink.get_price > @money
      puts "お金が足りません"
      puts "買いませんでした"
    else
      puts "#{drink.get_name} を買いました"
      @money -= drink.get_price
      show_money
    end
  end

end

machine = Vending_machine.new

show_drinks = Proc.new do |machine|
  machine.show_drinks
end

add_money = Proc.new do |machine|
  puts "いくら入れますか？"
  machine.add_money gets.chomp
end

show_money = Proc.new do |machine|
  machine.show_money
end

finish = Proc.new {exit}

commands = [show_drinks,add_money,show_money,finish]

while true 
  puts ""
  puts "何をしますか？"
  puts "0 : 商品を見る"
  puts "1 : お金を入れる"
  puts "2 : お金を確認する"
  puts "3 : 終わる"

  command = gets.chomp.to_i
  puts ""

  if commands.length  > command
    commands[command].call machine
  else
    puts "存在するものを指定してください"
  end

end