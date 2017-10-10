class Board
  attr_accessor :cups, :current_player, :name1, :name2

  def initialize(name1, name2)
    @name1, @name2 = name1, name2
    @cups = Array.new(14){Array.new([])}
    (0..13).each do |pocket|
      @cups[pocket].concat([:stone, :stone, :stone, :stone]) unless pocket == 6 || pocket == 13
    end
    @current_player = name1
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' unless (1..14).to_a.include?(start_pos)
  end

  def make_move(start_pos, current_player_name)

    stones = @cups[start_pos]
    @cups[start_pos] = []

    # distributes stones
    cup_idx = start_pos
    until stones.length == 0
      cup_idx += 1
      cup_idx = 0 if cup_idx > 13
      # places stones in the correct current player's cups
      if cup_idx == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif cup_idx == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else
        @cups[cup_idx] << stones.pop
      end
    end

    render
    next_turn(cup_idx)
  #   hand_stones = @cups[start_pos].length
  #   @cups[start_pos]=[]
  #   current_pos = start_pos
  #
  #   if current_player_name == @name1
  #     until hand_stones == 0
  #       current_pos += 1
  #       if current_pos == 13
  #         current_pos = 0
  #       end
  #       hand_stones -= 1
  #       @cups[current_pos] << :stone
  #     end
  #   end
  #
  #   if current_player_name == @name2
  #     until hand_stones == 0
  #       current_pos += 1
  #       if current_pos == 6
  #         current_pos = 7
  #       end
  #       if current_pos == 13
  #         @cups[current_pos] << :stone
  #         hand_stones -= 1
  #         current_pos = -1
  #       else
  #
  #       hand_stones -= 1
  #       @cups[current_pos] << :stone
  #
  #     end
  #
  #   end
  #
  # end

  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
   if ending_cup_idx == 6 || ending_cup_idx == 13
     # ended on store -- get to choose where to start again
     :prompt
   elsif @cups[ending_cup_idx].count == 1
     # ended on empty cup -- switches players' turns
     :switch
   else
     # ended on cup with stones in it -- automatically starts there
     ending_cup_idx
   end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if @cups[0..5].any? do |cup| cup.empty? end
    return true if @cups[7..12].any? do |cup| cup.empty? end
    return false
  end

  def winner
    case @cups[6] <=> @cups[13]
    when 1
      return @name1
    when 0
      return :draw
    when -1
      return @name2
    end


  end

end
