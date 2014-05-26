#There are 3 doors, behind which are two goats and a car
#You pick a door (call it door A). You’re hoping for the car of course
#Monty Hall, the game show host, examines the other doors (B & C) and 
#always opens one of them with a goat (Both doors might have goats; he’ll 
#randomly pick one to open)
#
#Here’s the game: Do you stick with door A (original guess) or switch to 
#the other unopened door? Does it matter?
#
#Surprisingly, the odds aren’t 50-50. If you switch doors you’ll win 2/3 of the time!
#
class Show
  attr_reader :games

  def initialize
    @games = []
  end

  def first_pick(door)
    @current_game = Game.new(door)
    @current_game.first_pick(door)
  end

  def second_pick(door)
    @current_game.second_pick(door, false)
    @games << @current_game
  end

  def simulate(number_of_games)
    number_of_games.times do
      door = "A" + rand(3).chr
      first_pick door 
      second_pick door
    end
    number_of_games.times do
      door = "A" + rand(3).chr
      eliminated = first_pick door
      other_door = (['A', 'B', 'C'] - [eliminated, door]).first
      second_pick other_door
    end
    score
  end

  def number_of_games_played
    @games.size
  end

  def games_won
    @games.select {|g| g.won? }
  end

  def number_of_games_won
    games_won.size
  end

  def games_played_with_change
    @games.select {|g| g.changed?}
  end

  def number_of_games_played_with_change
    games_played_with_change.size
  end

  def games_won_with_change
    @games.select {|g| g.won? && g.changed?}
  end

  def number_of_games_won_with_change
    games_won_with_change.size
  end

  def games_played_without_change
    @games.select {|g| !g.changed?}
  end

  def number_of_games_played_without_change
    games_played_without_change.size
  end

  def games_won_without_change
    @games.select {|g| g.won? && !g.changed?}
  end

  def number_of_games_won_without_change
    games_won_without_change.size
  end

  def score
    puts "total: #{number_of_games_won}/#{number_of_games_played} #{number_of_games_won.to_f/number_of_games_played}"
    puts "change: #{number_of_games_won_with_change}/#{number_of_games_played_with_change} #{number_of_games_won_with_change.to_f/number_of_games_played_with_change}"
    puts "no change: #{number_of_games_won_without_change}/#{number_of_games_played_without_change} #{number_of_games_won_without_change.to_f/number_of_games_played_without_change}"
  end

end

class Game

  def initialize(door)
    @winning_door = pick_winning_door_randomly
    if door == @winning_door
      @g
    end
  end

  def won?
    @won
  end

  def changed?
    @changed
  end

  def first_pick(door)
    @first_door = door
    candidates_for_elimination = ['A', 'B', 'C'] - [door, @winning_door]
    candidates_for_elimination[rand(candidates_for_elimination.size)]
  end

  def pick_winning_door_randomly
    "A" + rand(3).chr
  end

  def second_pick(second_door, verbose=true)
    @changed = (@first_door != second_door)
    @won = @winning_door == second_door
    return @won unless verbose
    if @won
      puts "The winning door is #{@winning_door}. Congrats, you won!"
    else
      puts "The winning door is #{@winning_door}. Sorry, try again."
    end
    @won
  end

end

Show.new.simulate ARGV[0].to_i
