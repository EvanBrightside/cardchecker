class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      flash[:notice] = 'Your card number is valid'
      redirect_to :new_card
    else
      flash[:notice] = 'Your card number is not valid'
    render :new
    end
  end

  private
    def card_params
      params.require(:card).permit(:number)
    end
end
