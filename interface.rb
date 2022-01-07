class Interface
  attr_accessor :game, :gamer_name

  def registration
    puts "BLACKJACK GAME"
    puts "#" * 80
    print "What's your name: "
    @gamer_name = gets.strip
    @game = Game.new(gamer_name)
  end

  def choose_action
    puts "Choose action: "
    puts "1 - Pass"
    puts "2 - Take card"
    puts "3 - Open cards"
  end

  def play_again
    puts 'Play again? (input: Y/N)'
    input = gets.strip.downcase
    if input == 'y' 
      game.set_initial_values
      game.make_a_bet
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
    system "clear" #|| system "cls"
    game.open_cards("end")
    game.counting_results
    #game.play_list()
    play_again
  end

  def start
    registration
    loop do 
      game.open_cards
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
        puts "Error number"
      end
    end
  end
end