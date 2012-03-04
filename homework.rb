#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

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
    lemon_tea = Drink.new("レモンティー",110)
    cocoa = Drink.new("ココア",120)
    coffie = Drink.new("コーヒー",100)
    cha = Drink.new("お茶",140)
    cola = Drink.new("コーラ",150)

    @drinks = [lemon_tea,cocoa,coffie,cha,cola]
    @money = 0
  end

  def add_money
    puts "いくら入れますか？"
    money = gets.chomp.to_i
    if money <= 0
      puts "ちゃんとしたお金を入れてください"
    else
      @money += money
      puts "#{money} 円入れました"
    end
  end

  def buy_drink
    puts "買いたい飲み物を選んでください"
    @drinks.each_with_index do |item,index|
      puts "[#{index}] : #{item.get_name} : #{item.get_price} "
    end
    num = gets.chomp.to_i
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
    if drink == nil
      puts "ちゃんと飲み物を選んでください"
    else
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
end

class Command

  @message
  @proc

  def initialize mes,p
    @message = mes
    @proc = p
  end

  def get_message
    @message
  end

  def get_proc
    @proc
  end
end
require 'pp'

machine = Vending_machine.new
commands = []

commands.push Command.new("商品を見る" , Proc.new { |machine| machine.show_drinks })
commands.push Command.new("お金を入れる" , Proc.new { |machine| machine.add_money })
commands.push Command.new("お金を確認する",Proc.new { |machine| machine.show_money })
commands.push Command.new("飲み物を買う",Proc.new { |machine| machine.buy_drink })
commands.push Command.new("終わる",Proc.new { exit })

while true 
  
  puts ""
  puts "何をしますか？"
  commands.each_with_index do |command,index|
    puts "#{index} : #{command.get_message}"
  end

  num = gets.chomp.to_i
  puts ""

  if commands.length  > num
    commands[num].get_proc.call machine
  else
    puts "存在するものを指定してください"
  end

end
