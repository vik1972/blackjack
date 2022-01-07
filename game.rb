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
    remain_cards
    player.bank -= BET
    dealer.bank -= BET
    box.bank = 2 * BET
    2.times { take_card(player) }
    2.times { take_card(dealer) }
  end

  def remain_cards
    #puts"There are still cards left in the deck: #{deck.cards.size}"
    if deck.cards.size < MIN_CARD_OF_DECK 
      puts "There are less than 1/3 cards left in the deck"
      puts "A new deck of cards will be opened"
      @deck = Deck.new 
    end
  end

  def take_card(gamer)
    return if deck.cards.empty?
    if gamer.cards.size < 3
      gamer.cards <<  deck.cards.pop 
    end
  end

  def add_card_dealer
    take_card(dealer) if dealer.score < 17
  end 

  def open_cards(*args)
    if args[0].nil?
      puts "Cards of dealer: #{" * " * dealer.cards.size} "
      puts "Number of points: * "
    else
      puts "Cards of dealer:"
      dealer.cards.each { |card| print "#{card.rank}#{card.suit}  "}
      puts "\nNumber of points: #{dealer.score}"
    end
    puts "Cards of gamer:"
    player.cards.each { |card| print "#{card.rank}#{card.suit}  "}
    puts "\nNumber of points: #{player.score}"
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
    play_list(winner)
  end

  def play_list(winner=nil)
    if winner
      puts "Winner #{winner.name.capitalize}" 
    else
      puts "The game is a draw" 
    end
    puts "Dealer's amount of money: #{dealer.bank}"
    puts "#{player.name.capitalize}'s amount of money: #{player.bank}" 
  end

  def set_initial_values
    dealer.cards.clear
    player.cards.clear
  end
end