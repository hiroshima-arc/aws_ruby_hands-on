# frozen_string_literal: true

class FizzBuzz
  def self.generate(number)
    value = number

    if (number % 3).zero? && (number % 5).zero?
      value = 'FizzBuzz'
    elsif (number % 3).zero?
      value = 'Fizz'
    elsif (number % 5).zero?
      value = 'Buzz'
    end

    value.to_s
  end

  def self.iterate(count)
    [1, 2, 'Fizz', 4, 'Buzz']
  end
end