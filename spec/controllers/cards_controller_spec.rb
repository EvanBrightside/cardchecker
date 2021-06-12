require 'rails_helper'

RSpec.describe CardsController do

  describe '#new' do
    subject do
      get :new
      response
    end

    it { is_expected.to be_success }
    it { is_expected.to render_template :new }
    it { is_expected.to have_http_status(200) }
  end

  describe '#create' do
    subject do
      post :create, card: card_params
      response
    end

    context 'when valid' do
      let(:card_params) { { number: '4276015510856302' } }

      it { is_expected.to render_template :show }

      it 'assigns @card' do
        subject
        expect(assigns(:card)).to be_kind_of Card
      end

      it 'assigns @card_valid' do
        subject
        expect(assigns(:card_valid)).not_to be_nil
      end

      it 'assigns @card_type' do
        subject
        expect(assigns(:card_type)).not_to be_nil
      end

      it { expect { subject }.to change(Card, :count).by(1) }
    end

    context 'when invalid' do
      let(:card_params) { { number: '42760abcd0856' } }

      it { is_expected.to render_template :new }
      it { expect { subject }.not_to change(Card, :count) }
    end
  end
end
