class Rucksack
  @@item_priorities = ('a'..'z').to_a + ('A'..'Z').to_a
  
  def initialize (line)
    #puts line.split[0..line.size/2-1]
    @compart1 = line.slice(0,line.size/2).split(//)
    @compart2 = line.slice(line.size/2,line.size/2).split(//)
  end

  def get_common
    common = @compart1.intersection(@compart2)[0]
    @@item_priorities.index(common) + 1
  end
end

def load (is_test = true)      
  
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  rucksacks = File.readlines(file_path).map {|l| Rucksack.new (l)}
end

def load_2 (is_test = true)
  item_priorities = ('a'..'z').to_a + ('A'..'Z').to_a
  badges = []
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  rucksacks = File.readlines(file_path)
  rucksacks.reject {|r| r.empty?}.each_slice(3) do |a,b,c| badges << item_priorities.index(a.split(//).intersection(b.split(//)).intersection(c.split(//))[0])+1
  end

  badges.reduce(&:+)
end

def process_part1
  rucksacks = load(false)
  puts rucksacks.map {|r| r.get_common}.reduce(&:+)
end


def process_part2  
  puts load_2 (false)
end

def process
  process_part2
end