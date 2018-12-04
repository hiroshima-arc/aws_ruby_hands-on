# frozen_string_literal: true

require 'json'
require 'test/unit'
require 'mocha/test_unit'
require 'simplecov'
SimpleCov.start
require_relative '../../../fizz_buzz/app'

class FizzBuzzTest < Test::Unit::TestCase
  sub_test_case '#generate' do
    def test_3ならばFizzを返す
      @mock_response = {
          statusCode: 200,
          body: 'Fizz'
      }
      @event = {
          queryStringParameters: { number: '3' },
      }
      expects(:generate).with(event: @event, context: '').returns(@mock_response)

      response = generate(event: @event, context: '')
      result = response[:body]

      assert_equal(200, response[:statusCode])
      assert_equal('Fizz', result)
    end
  end

  sub_test_case '#iterate' do
    def test_5ならば配列を返す
      @mock_response = {
          statusCode: 200,
          'body': ['1', '2', 'Fizz', '4', 'Buzz']
      }
      @event = {
          "body" => "{\"count\": \"5\"}"
      }
      expects(:iterate).with(event: @event, context: '').returns(@mock_response)

      response = iterate(event: @event, context: '')
      result = response[:body]

      assert_equal(200, response[:statusCode])
      assert_equal(%w[1 2 Fizz 4 Buzz], result)
    end
  end
end
