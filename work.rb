class Money
  attr_accessor :amount, :money_unit, :is_scratched
  def initialize(**params)
    @amount = params[:amount]
    @money_unit = params[:money_unit]
    @is_scratched = params[:is_scratched]
  end
end

# 入力が完了するまで入力処理を繰り返し実行する
money_data = []

loop do
  puts "金額,単位,傷の有無（有：1,無：2）を半角スペースを空けて入力してください"
  puts "入力が完了している場合には OK と入力してください"
  
  input_data = gets.chomp.split(" ")
  # TODO:integerでないとかの判定式を入れる
  break if input_data == ["OK"]

  money = Money.new(amount:input_data[0].to_i, money_unit:input_data[1], is_scratched:input_data[2].to_i)
  money_data << money
  puts <<~EOS
  --------------
  金額：#{money.amount}
  単位：#{money.money_unit}
  傷の有無：#{money.is_scratched}
  --------------

  EOS
end

p money_data

money_data.each do |money|
  p money.amount
end