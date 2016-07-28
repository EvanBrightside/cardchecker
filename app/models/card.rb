class Card < ActiveRecord::Base
  validates :number,  presence: true, length: { minimum: 15 }, format: { with: /\d/ }
end
