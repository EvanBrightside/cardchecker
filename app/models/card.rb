class Card < ActiveRecord::Base
  validates :number, presence: true, length: { minimum: 13 },
                     format: { with: /[\d+\s]/, message: 'can only contain numbers.' }

  def type(card_pan)
    case card_pan.gsub(/\D/, '')
    when /^(?=34).{15}$/, /^(?=37).{15}$/
      'AMEX'
    when /^(?=6011).{16}$/
      'Discover'
    when /^(?=5[1-5]).{16}$/
      'MasterCard'
    when /^(?=4).{13}(...)?$/
      'Visa'
    else
      'Unknown'
    end
  end

  def algorithm(card_pan)
    parity = card_pan.length % 2
    sum = 0
    card_pan.split('').each_with_index do |c, i|
      digit = c.to_i
      digit = (digit * 2) % 9 if i % 2 == parity
      sum += digit
    end
    (sum % 10).zero?
  end
end
