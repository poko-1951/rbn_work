# お金クラス
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
  --------------
  合計金額：#{total_money}
  紙幣の枚数：#{bill_number}
  硬貨の枚数：#{coin_number}
  対象外の枚数:#{exclude_money.count}
  --------------
  EOS
end

# 入力のバリデーション
def check_input_money(input_data)
  if input_data[0] !~ /^[0-9]+$/
    puts "エラー：正しい金額を入力してください"
    return true
  end
  if input_data[2] != "true" and input_data[2] != "false"
    puts "エラー：傷の有無には「true」か「false」を入力してください"
    return true
  end
end

# お金の入力
def input_money
  money_data = []
  exclude_money = []

  loop do
    puts <<~EOS
    金額,単位,傷の有無（有り：ture or 無し：false）を半角カンマを空けて入力してください
    入力が完了している場合には OK と入力してください
    EOS
    input_data = gets.split(",").map(&:strip)
    break if input_data == ["OK"]
    next if check_input_money(input_data)
    # TODO:integerでないとかの判定式を入れる

    money = Money.new(amount:input_data[0].to_i, money_unit:input_data[1], is_scratched:input_data[2])
    if money.money_unit == "円" and money.is_scratched == "false"
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
end

# 実行
input_money