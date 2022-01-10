# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANK.each { |rank, value| @cards << Card.new(suit, rank, value) }
    end
    @cards.shuffle!
  end
end
