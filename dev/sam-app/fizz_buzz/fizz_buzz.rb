# frozen_string_literal: true

class FizzBuzz
  def self.generate(number)
    value = number

    if (value % 3).zero?
      'Fizz'
    end
  end
end