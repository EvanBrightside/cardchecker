class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card_valid = @card.algorithm(card_params[:number])
    @card_type = @card.type(card_params[:number])
    if @card.save
      render :show
    else
      render :new
    end
  end

  private
    def card_params
      params.require(:card).permit(:number)
    end
end
