require 'minitest/autorun'
require './work.rb'

class Test < Minitest::Test
  def setup
    @test_amount_money = Money.new(amount:0, money_unit:"円", is_scratched:"false")
    @test_is_scratched_money = Money.new(amount:100, money_unit:"円", is_scratched:"error_data")
    @test_bill_and_coin_money = Money.new(amount:2, money_unit:"円", is_scratched:"false")
    @money_data = [Money.new(amount:1000, money_unit:"円", is_scratched:false),
                   Money.new(amount:100, money_unit:"円", is_scratched:false),
                  ]
    @exclude_money_data = [Money.new(amount:100, money_unit:"円", is_scratched:true),
                           Money.new(amount:100, money_unit:"円", is_scratched:true),
                           Money.new(amount:100, money_unit:"円", is_scratched:true),
                          ]
  end

  # 入力された金額が正しいか
  def test_amount_validation
    assert_equal true, check_input_money(@test_amount_money)
  end

  # 入力された傷の有無が正しいか
  def test_is_scratched_validation
    assert_equal true, check_input_money(@test_is_scratched_money)
  end

  # 入力金額が日本円の紙幣または硬貨に該当するか
  def test_bill_and_coin_validation
    assert_equal true, check_input_money(@test_bill_and_coin_money)
  end

  # 正しく合計金額、紙幣および硬貨の枚数、対象外の枚数が計算されるか
  def test_calculate_money
    assert_output("--------------\n合計金額：1100\n紙幣の枚数：1\n硬貨の枚数：1\n対象外の枚数:3\n--------------\n") do
      calculate_money(@money_data, @exclude_money_data)
    end
  end
end