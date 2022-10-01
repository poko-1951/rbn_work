# お金クラス
class Money
  attr_accessor :amount, :money_unit, :is_scratched

  def initialize(**params)
    @amount = params[:amount]             # 金額
    @money_unit = params[:money_unit]     # 単位
    @is_scratched = params[:is_scratched] # 傷の有無
  end
end

BILL_INDEX = [1000, 2000, 5000, 10000] # 日本紙幣
COIN_INDEX = [1, 5, 10, 50, 100, 500]  # 日本硬貨

# 計算処理
def calculate_money(money_data, exclude_money_data)
  total_money = 0
  bill_number = 0
  coin_number = 0

  money_data.each do |money|
    total_money += money.amount
    case money.amount
    when *BILL_INDEX then
      bill_number += 1
    when *COIN_INDEX then
      coin_number += 1
    end
  end
  puts <<~EOS
  --------------
  合計金額：#{total_money}
  紙幣の枚数：#{bill_number}
  硬貨の枚数：#{coin_number}
  対象外の枚数:#{exclude_money_data.count}
  --------------
  EOS
end

# 入力のバリデーション
def check_input_money(money)
  if money.amount == 0 # 文字列の場合には0になる
    puts "エラー：正しい金額を入力してください"
    return true
  elsif money.is_scratched != "true" && money.is_scratched != "false"
    puts "エラー：傷の有無には「true」か「false」を入力してください"
    return true
  elsif money.money_unit == "円"
    unless (BILL_INDEX + COIN_INDEX).include?(money.amount)
      puts "エラー：この金額は日本円の紙幣または硬貨に該当しません"
      return true
    end
  end
end

# お金の入力
def input_money
  money_data = []
  exclude_money_data = []

  loop do
    puts <<~EOS
    金額,単位,傷の有無（有り：ture or 無し：false）を半角カンマ区切りで入力してください
    入力が完了している場合には OK と入力してください
    EOS
    input_data = gets.split(",").map(&:strip)
    break if input_data == ["OK"]

    money = Money.new(amount:input_data[0].to_i, money_unit:input_data[1], is_scratched:input_data[2])
    next if check_input_money(money)

    if money.money_unit == "円" and money.is_scratched == "false"
      money_data << money
    else
      exclude_money_data << money
    end
    puts <<~EOS
    --------------
    金額：#{money.amount}
    単位：#{money.money_unit}
    傷の有無：#{money.is_scratched}
    --------------

    EOS
  end
  calculate_money(money_data, exclude_money_data)
end

# 実行
input_money