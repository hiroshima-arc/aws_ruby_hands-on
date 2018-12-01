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
    assert_equal('100', FizzBuzz.generate(100))
  end
end