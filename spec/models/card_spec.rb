require 'rails_helper'

RSpec.describe Card, type: :model do
  describe '#type' do
    let(:card) { Card.new }

    context 'when pass card number 4276015510856302' do
      it 'returns visa' do
        expect(card.type('4276015510856302')).to eq 'Visa'
      end

      it 'returns MasterCard' do
        expect(card.type('5276015510856302')).to eq 'MasterCard'
      end

      it 'returns Discover' do
        expect(card.type('6011015510856302')).to eq 'Discover'
      end

      it 'returns AMEX' do
        expect(card.type('377601551085630')).to eq 'AMEX'
        expect(card.type('347601551085630')).to eq 'AMEX'
      end
    end

    context 'when pass card number 1212121212121212' do
      it 'returns unknown' do
        expect(card.type('1212121212121212')).to eq 'Unknown'
      end
    end
  end

  describe '#algorithm' do
    let(:card) { Card.new }

    context 'when pass card number 4276015510856302' do
      it 'returns true' do
        expect(card.algorithm('4276015510856302')).to eq true
      end
    end

    context 'when pass card number 4276015510856306' do
      it 'returns false' do
        expect(card.algorithm('4276015510856306')).to eq false
      end
    end
  end
end
