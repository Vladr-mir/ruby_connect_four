# frozen_string_literal: false

# spec/grid_spec.rb

require 'spec_helper'
require './lib/grid'

RSpec.describe Grid do
  describe '#set_grid' do
    it 'create a new empty grid' do
      expect(subject.grid).to eql(Array.new(6) { Array.new(7) })
    end
  end

  describe '#drop_object' do
    it 'place a piece following the rules of connect-four game' do
      subject.drop_object('o', 3)
      subject.drop_object('x', 3)
      expect(subject.grid[-1][3]).to eql('o')
      expect(subject.grid[-2][3]).to eql('x')
    end
  end

  describe '#find_pattern' do
    it 'returns the nil if there is no pattern' do
      expect(subject.find_pattern).to be_nil
    end

    it 'returns the repeating value if there\'s a row repeating pattern' do
      1.upto(5).each { |column| subject.drop_object('o', column) }
      expect(subject.find_pattern).to eql('o')
    end

    it 'returns the repeating value if there\'s a column repeating pattern' do
      0.upto(4).each { subject.drop_object('o', 3) }
      expect(subject.find_pattern).to eql('o')
    end

    it 'return the repeating value if there\'s a diagonal repeating pattern' do
      subject.grid = [
        [nil, nil, nil, nil],
        [nil, nil, nil, 'x'],
        [nil, nil, 'x', nil],
        [nil, 'x', nil, nil],
        ['x', nil, nil, nil]
      ]
      expect(subject.find_pattern).to eql('x')
    end
  end
end
