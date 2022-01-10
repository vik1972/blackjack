# frozen_string_literal: true

class Gamer
  attr_accessor :bank, :cards

  START_MONEY = 100

  def initialize(*_name)
    @bank = START_MONEY
    @cards = []
  end

  def score
    total = cards.map(&:value).reduce(:+)
    count_ace = 0
    cards.each { |rank| count_ace += 1 if rank == 'Т' }
    if total > 21
      case count_ace
      when 2
        total = 21
      when 1
        total -= 10
      end
    end
    total
  end
end
