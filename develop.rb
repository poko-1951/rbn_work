# 入力金額
class Money
  attr_accessor :amount, :money_unit, :is_scratched

  def initialize(**params)
    @amount = params[:amount]             # 金額
    @money_unit = params[:money_unit]     # 単位
    @is_scratched = params[:is_scratched] # 傷の有無
  end
end

# 計算処理
def calculate_money(money_data, exclude_money)
  total_money = 0
  bill_number = 0
  coin_number = 0

  money_data.each do |money|
    total_money += money.amount
    case money.amount
    when 1000, 2000, 5000, 10000 then
      bill_number += 1
    when 1,5,50,100,500 then
      coin_number += 1
    end
  end
  puts <<~EOS
  合計金額：#{total_money}
  紙幣の枚数：#{bill_number}
  硬貨の枚数：#{coin_number}
  対象外の枚数:#{exclude_money.count}
  EOS
end

# 入力が完了するまで入力処理を繰り返し実行する
money_data = []
exclude_money = []

loop do
  puts <<~EOS
  金額,単位,傷の有無（有：1,無：2）を半角スペースを空けて入力してください
  入力が完了している場合には OK と入力してください
  EOS
  input_data = gets.chomp.split(" ")
  # TODO:integerでないとかの判定式を入れる
  break if input_data == ["OK"]

  money = Money.new(amount:input_data[0].to_i, money_unit:input_data[1], is_scratched:input_data[2].to_i)
  if money.money_unit == "円" and money.is_scratched == 2
    money_data << money
  else
    exclude_money << money
  end
  puts <<~EOS
  --------------
  金額：#{money.amount}
  単位：#{money.money_unit}
  傷の有無：#{money.is_scratched}
  --------------

  EOS
end

calculate_money(money_data, exclude_money)