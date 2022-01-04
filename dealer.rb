class Dealer < Gamer
  attr_accessor :name

  def initialize(name = "Dealer")
    @name = name
    super
  end
end