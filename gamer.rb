class Gamer
  attr_accessor :bank, :cards

  START_MONEY = 100

  def initialize(*name)
    @bank = START_MONEY
    @cards = []
  end

  def score
    total = cards.map(&:value).reduce(:+)
    count_ace = 0
    cards.each { |rank| count_ace += 1 if rank == "Т" }
    if total > 21
      if count_ace == 2
        total = 21
      elsif count_ace == 1
        total -= 10
      end
    end
    total
  end
end