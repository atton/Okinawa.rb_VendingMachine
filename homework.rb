#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

class Item
  # 商品クラス
  # 名前と値段を持つ
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
  # 自動販売機クラス
  
  attr_reader :name

  def initialize name,items
    @name = name
    @items = items
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

  def select_item
    puts "買いたい飲み物を選んでください"
    @items.each_with_index do |item,index|
      puts "[#{index}] : #{item.get_name} : #{item.get_price} "
    end
    num = gets.chomp.to_i
    buy_item @items[num]
  end

  def show_money
    puts "自動販売機の中には #{@money} 円入っています"
  end

  def show_items 
    puts "今販売しているのは"

    @items.each_with_index do |item,num|
      puts "#{num} : #{item.get_name} : 値段 #{item.get_price}"
    end
    puts "です。"
  end

  private

  def buy_item item
    if item == nil
      puts "ちゃんと飲み物を選んでください"
    else
      puts "#{item.get_name} を買います"
      if item.get_price > @money
        puts "お金が足りません"
        puts "買いませんでした"
      else
        puts "#{item.get_name} を買いました"
        @money -= item.get_price
        show_money
      end
    end

  end
end

class Command
  # コマンドをまとめるクラス
  # 説明文と実行文(proc)を持っておく

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

class Drink_vending_machine < Vending_machine
  # 飲み物の自動販売機
  
  def initialize
    items = [ 
      Item.new("レモンティー",110),
      Item.new("ココア",120),
      Item.new("コーヒー",100),
      Item.new("お茶",140),
      Item.new("コーラ",150)
    ]
    super "飲み物の自動販売機",items
  end
end



def buy machine
  # あるマシンに対して処理するメソッド

  commands = [
    Command.new("商品を見る" , Proc.new { |machine| machine.show_items }),
    Command.new("お金を入れる" , Proc.new { |machine| machine.add_money }),
    Command.new("お金を確認する",Proc.new { |machine| machine.show_money }),
    Command.new("商品を買う",Proc.new { |machine| machine.select_item}),
    Command.new("自販機から立ちさる",Proc.new { return })
  ]

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
end

# ここからmain
machines = [
  Drink_vending_machine.new
]

while true

  puts "どの自販機を使いますか？"
  puts "範囲外を指定すると終わります"

  machines.each_with_index do |machine,index|
    puts "#{index} : #{machine.name}"
  end

  num = gets.to_i

  if num >= machines.length
    exit
  end

  buy machines[num]
end
