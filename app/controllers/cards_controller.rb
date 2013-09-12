class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  # GET /cards.json
  def index
    @card = Card.new
    @cards = Card.all(:conditions => "parent_id is null")
    sort_cards_by_position(@cards)
  end

  def show
    @cards = @card.children
    sort_cards_by_position(@cards)
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to cards_url, notice: 'Card was successfully created.' }
        format.json { render json: @card, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to cards_url, notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:title, :description, :card_type, :position, :parent_id)
    end

    def sort_cards_by_position(cards)
      @cards_sorted_by_position = []

      for i in 1..10
        card_hash = Hash.new
        cards.each do |c|
          if c.position == i
            card_hash[c.card_type] = c
          end
        end
        @cards_sorted_by_position << card_hash
      end
    end

end
