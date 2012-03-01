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
  end
  
  def buy_drinks
    puts "Please Select drinks"
    @drinks.each_with_index do |item,index|
      puts "[#{index}] : #{item.get_name} : #{item.get_price} "
    end
    num = gets.chomp 
    puts "you select #{@drinks[num].get_name}"
  end
  
  def show_money
    puts "money is #{@money}"
  end
  
  def show_drinks 
    puts @drinks
  end
    
  
end

hoge = Vending_machine.new

show_drinks = Proc.new do |machine|
  machine.show_drinks
end

add_money = Proc.new do |machine|
  puts "please decide in money"
  machine.add_money gets.chomp
end

show_drinks.call hoge
add_money.call hoge
hoge.show_money
