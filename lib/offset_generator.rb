require 'date'

class OffsetGenerator
  attr_reader :date

  def initialize(date = default)
    @date = date
  end

  def default
    default = Date.today
    default.strftime("%m%d%y")
  end

  def last_four_digits
    last_four = stringify.split("").last(4)
    last_four.map {|digit| digit.to_i}
  end

  def stringify
    square_date.to_s
  end

  def square_date
    date_to_integer ** 2
  end

  def date_to_integer
    @date.to_i
  end

  def offset_assignment
    {"A" => last_four_digits[0],
     "B" => last_four_digits[1],
     "C" => last_four_digits[2],
     "D" => last_four_digits[3]}
  end

end
