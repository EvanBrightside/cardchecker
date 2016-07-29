class MyValidator < ActiveModel::Validator
  def type(s)
    case s.gsub(/\D/,'')
    when /^(?=34).{15}$/; "AMEX"
    when /^(?=37).{15}$/; "AMEX"
    when /^(?=6011).{16}$/; "Discover"
    when /^(?=5[1-5]).{16}$/; "MasterCard"
    when /^(?=4).{13}(...)?$/; "Visa"
    else ; "Unknown"
    end
  end

  def validate(s)
    s.scan(/\d/).inject([0,0]){|(a,b),c|[b+c.to_i,
    a+c.to_i*2%9+(c=='9' ? 9 : 0)]}[0]%10 == 0
  end

  s = ARGV.join
end


#  s = ARGV.join
#  puts "#{type(s)} #{validate(s)?'V':'Inv'}alid"
