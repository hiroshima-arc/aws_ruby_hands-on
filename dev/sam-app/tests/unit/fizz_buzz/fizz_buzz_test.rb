require 'test/unit'
require 'simplecov'
SimpleCov.start
require_relative '../../../fizz_buzz/fizz_buzz'

class FizzBuzzTest < Test::Unit::TestCase
  test '3ならFizzを返す' do
    assert_equal('Fizz', '3')
  end
end