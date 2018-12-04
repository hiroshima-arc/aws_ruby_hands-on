# frozen_string_literal: true

require 'httparty'
require 'json'
require_relative 'fizz_buzz'

def generate(event:, context:)
  data = nil
  number = 0
  unless event['queryStringParameters'].nil?
    unless event['queryStringParameters']['number'].nil?
      number = event['queryStringParameters']['number']
    end
  end

  begin
    data = FizzBuzz.generate(number.to_i)
  rescue HTTParty::Error => error
    puts "Application error occurred: #{error.inspect}"
    create_response(500, error.inspect)
  end

  puts "Application execute with params: #{number}"
  create_response(200, data)
end

def iterate(event:, context:)
  data = nil
  params = { Item: JSON.parse(event['body']) }
  begin
    count = params[:Item]['count']
    data = FizzBuzz.iterate(count.to_i)
  rescue HTTParty::Error => error
    puts "Application error occurred: #{error.inspect}"
    create_response(500, error.inspect)
  end

  puts "Application execute with params: #{params[:Item]}"
  create_response(200, data)
end

private

def create_response(status_code, data)
  {
      statusCode: status_code,
      headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
      },
      body: data
  }
end
