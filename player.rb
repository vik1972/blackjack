# frozen_string_literal: true

class Player < Gamer
  attr_accessor :name, :bank

  def initialize(name)
    @name = name
    super
  end
end
