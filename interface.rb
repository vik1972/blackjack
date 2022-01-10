# frozen_string_literal: true

class Interface
  attr_accessor :game, :gamer_name

  def registration
    puts 'BLACKJACK GAME'
    puts '#' * 80
    print "What's your name: "
    @gamer_name = gets.strip
    @game = Game.new(gamer_name)
  end

  def choose_action
    puts 'Choose action: '
    puts '1 - Pass'
    puts '2 - Take card'
    puts '3 - Open cards'
  end

  def play_again
    puts 'Play again? (input: Y/N)'
    input = gets.strip.downcase
    if input == 'y'
      game.set_initial_values
      if game.make_a_bet
        puts 'There are less than 1/3 cards left in the deck'
        puts 'A new deck of cards will be opened'
      end
    else
      abort
    end
  end

  def end_of_game
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
      system('cls')
    else
      system('clear')
    end
    system 'clear' # || system "cls"
    open_cards('end')
    winner = game.counting_results
    play_list(winner)
    play_again
  end

  def open_cards(*args)
    if args[0].nil?
      puts "Cards of dealer: #{' * ' * game.dealer.cards.size} "
      puts 'Number of points: * '
    else
      puts 'Cards of dealer:'
      game.dealer.cards.each { |card| print "#{card.rank}#{card.suit}  " }
      puts "\nNumber of points: #{game.dealer.score}"
    end
    puts 'Cards of gamer:'
    game.player.cards.each { |card| print "#{card.rank}#{card.suit}  " }
    puts "\nNumber of points: #{game.player.score}"
  end

  def play_list(winner = nil)
    if winner
      puts "Winner #{winner.name.capitalize}"
    else
      puts 'The game is a draw'
    end
    puts "Dealer's amount of money: #{game.dealer.bank}"
    puts "#{game.player.name.capitalize}'s amount of money: #{game.player.bank}"
  end

  def start
    registration
    loop do
      open_cards
      choose_action
      act = gets.chomp.to_i
      case act
      when 1
        game.add_card_dealer
        end_of_game
      when 2
        game.take_card(game.player)
        game.add_card_dealer
        end_of_game
      when 3
        end_of_game
      else
        puts 'Error number'
      end
    end
  end
end
