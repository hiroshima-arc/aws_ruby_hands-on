require 'test/unit'
require 'simplecov'
SimpleCov.start
require_relative '../../../fizz_buzz/fizz_buzz'

class FizzBuzzTest < Test::Unit::TestCase
  test '3ならFizzを返す' do
    assert_equal('Fizz', FizzBuzz.generate(3))
    assert_not_equal('Fizz', FizzBuzz.generate(1))
  end

  test '5ならBuzzを返す' do
    assert_equal('Buzz', FizzBuzz.generate(5))
    assert_not_equal('Buzz', FizzBuzz.generate(1))
  end

  test '15ならFizzBuzzを返す' do
    assert_equal('FizzBuzz', FizzBuzz.generate(15))
    assert_not_equal('FizzBuzz', FizzBuzz.generate(1))
  end

  test '条件を満たさない場合は値を返す' do
    assert_equal('1', FizzBuzz.generate(1))
    assert_equal('101', FizzBuzz.generate(101))
  end

  test "5ならば[1, 2, 'Fizz', 4, 'Buzz']を返す" do
    assert_equal(%w[1 2 Fizz 4 Buzz], FizzBuzz.iterate(5))
  end

  test "15ならば[1, 2, 'Fizz', 4, 'Buzz', 6, 7, 8, 'Fizz', 'Buzz', 11, 'Fizz', 13, 14, 'FizzBuzz']を返す" do
    assert_equal(%w[1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz], FizzBuzz.iterate(15))
  end
end