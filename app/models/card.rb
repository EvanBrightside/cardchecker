class Card < ActiveRecord::Base
  validates :number,  presence: true, length: { minimum: 13 }, numericality: { only_integer: true }

  def type(num)
    case num.gsub(/\D/,'')
    when /^(?=34).{15}$/; "AMEX"
    when /^(?=37).{15}$/; "AMEX"
    when /^(?=6011).{16}$/; "Discover"
    when /^(?=5[1-5]).{16}$/; "MasterCard"
    when /^(?=4).{13}(...)?$/; "Visa"
    else ; "Unknown"
    end
  end

  def algorithm(num)
    parity = num.length % 2
    sum = 0
    num.split('').each_with_index do |c, i|
      digit = c.to_i
      digit = (digit * 2) % 9 if i % 2 == parity
      sum += digit
    end
    return (sum % 10) == 0
  end
end
