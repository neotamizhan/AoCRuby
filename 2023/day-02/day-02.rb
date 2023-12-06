def load(is_test = true)
  file_path = File.expand_path("../day-02#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

def process_part1(input)
  bag = { blue: 14, red: 12, green: 13 }
  games = input.map { |line| Game.new(line) }
  # puts games.filter { |g| g.possible?(bag) }.map { |g| g.id }.reduce(&:+)
  puts games.map { |g| g.power }.reduce(&:+)
end

def process_part2(input); end

def process
  input = load(false)

  process_part1(input)
end

class Game
  attr_accessor :id, :bag, :sets, :power

  def initialize(line)
    @sets = []
    # @max_balls = {:blue => 0, :green => 0, :red => 0}
    load(line)
  end

  def load(line)
    # puts line
    @sets = { blue: [], red: [], green: [] }
    ideal_bag = { blue: 0, red: 0, green: 0 }
    @id = line.split(':')[0].gsub('Game ', '').to_i
    setdata = line.split(':')[1].split(';')
    setdata.each do |s|
      set = {}
      s.split(',').each { |b| x = b.split(' '); @sets[x[1].to_sym] << x[0].to_i }
    end

    ideal_bag.each_key { |color| ideal_bag[color] = @sets[color].max }
    @power = ideal_bag.values.reduce(&:*)
  end

  def possible?(bag)
    bag.each do |color, qty|
      return false if @sets[color].max > qty
    end
    #   @sets.each do |s|
    #     next if s[color].nil?
    #     return false if s[color] > qty
    #   end
    true
  end

  def to_s
    "Game #{@id}: #{@totals}"
  end
end
