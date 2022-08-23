# lib/main.rb
# frozen_string_literal: false

require_relative 'grid'
require_relative 'player'
require 'colorize'

grid = Grid.new
turn = false
player1 = Player.new('First Player', '◉'.green)
player2 = Player.new('Second Player', '◉'.blue)
winner = nil

while winner.nil?
  grid.show
  puts '0 1 2 3 4 5 6'
  current_player = turn ? player1 : player2
  turn = !turn
  puts "'#{current_player.name}': Enter your number"
  position = gets.chomp
  grid.drop_object(current_player, position.to_i)
  winner = grid.find_pattern
  system 'clear'
end

grid.show
puts "The winner is: '#{winner.name}'!"
