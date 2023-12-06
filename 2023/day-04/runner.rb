def load(is_test = true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

def process_part1(input)
  cards = []
  input.each { |line| cards << Card.new(line) }
  puts cards.map { |c| c.points }.reduce(&:+)
end

def process_part2(input)
  cards = []
  won_card = []
  input.each { |line| cards << Card.new(line) }
  (0..cards.size - 1).each { |i| won_card[i] = 1 }
  cards.each_with_index do |card, i|
    next if card.win_cards == 0

    (i+1..i+1+card.win_cards).each { |j| won_card[j] = won_card[j] + won_card[i] }
  end
  puts won_card.to_s  # .reduce(&:+)
end

def process
  input = load(true)
  process_part2(input)
end

class Card
  attr_accessor :id, :winning_numbers, :held_numbers, :points, :win_cards

  def initialize(line)
    @points = 0
    @id = line.split(':')[0].sub('Card ', '').to_i
    numbers = line.split(':')[1].split('|')
    @winning_numbers = numbers[0].split(' ').map(&:to_i)
    @held_numbers = numbers[1].split(' ').map(&:to_i)
    @win_cards = @winning_numbers.intersection(@held_numbers).size
    set_points
  end

  def set_points
    @points = 0
    @held_numbers.each do |held_number|
      if @winning_numbers.include?(held_number)
        @points = @points == 0 ? @points = 1 : @points * 2
      end
    end
  end

  
end
