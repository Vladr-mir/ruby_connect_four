# frozen_string_literal: false

# Player class
class Player
  attr_reader :name

  def initialize(name, value)
    @name = name
    @value = value
  end

  def to_s
    @value
  end
end
