# frozen_string_literal: true

class FizzBuzz
  def self.generate(number)
    value = number

    if (value % 3).zero? && (value % 5).zero?
      'FizzBuzz'
    elsif (value % 3).zero?
      'Fizz'
    elsif (value % 5).zero?
      'Buzz'
    end
  end
end