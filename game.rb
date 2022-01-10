# frozen_string_literal: true

class Game
  attr_accessor :deck, :box, :player, :dealer

  BET = 10
  MIN_CARD_OF_DECK = 14 # 1/3 deck

  def initialize(gamer_name)
    @player = Player.new(gamer_name)
    @dealer = Dealer.new
    @box = Box.new
    @deck = Deck.new
    @player.cards = []
    @dealer.cards = []
    make_a_bet
  end

  def make_a_bet
    new_deck = remain_cards
    player.bank -= BET
    dealer.bank -= BET
    box.bank = 2 * BET
    2.times { take_card(player) }
    2.times { take_card(dealer) }
    new_deck
  end

  def remain_cards
    if deck.cards.size < MIN_CARD_OF_DECK
      @deck = Deck.new
      true
    end
  end

  def take_card(gamer)
    return if deck.cards.empty?

    gamer.cards << deck.cards.pop if gamer.cards.size < 3
  end

  def add_card_dealer
    take_card(dealer) if dealer.score < 17
  end

  def define_winner
    return if player.score == dealer.score
    return if player.score > 21 && dealer.score > 21
    return player if dealer.score > 21
    return dealer if player.score > 21

    player.score > dealer.score ? player : dealer
  end

  def counting_results
    winner = define_winner
    if winner
      winner.bank += box.bank
    else
      player.bank += box.bank / 2
      dealer.bank += box.bank / 2
    end
    box.bank = 0
    winner
  end

  def set_initial_values
    dealer.cards.clear
    player.cards.clear
  end
end
