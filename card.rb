# frozen_string_literal: true

class Card
  attr_accessor :suit, :rank, :value

  SUITS = ["\u2660", "\u2665", "\u2663", "\u2666"].freeze
  RANK = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'В' => 10,
    'Д' => 10,
    'К' => 10,
    'Т' => 11
  }.freeze

  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
  end
end
