class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
      system("clear")
    end

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence

    unless @game_over == true
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |el|
      puts el
      sleep(1)
      system("clear")
      sleep(1)
    end
  end

  def require_sequence

    @seq.each_with_index do |color,index|
      puts "what is the #{index+1} color?"
      attempt = gets.chomp
      if color != attempt
        @game_over = true
        break
      end
    end
    sleep 1
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    "correct, here is the next sequence"
  end

  def game_over_message
    puts "game over!"
    sleep(10)
    reset_game
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
