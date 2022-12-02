@score = {
            "r" => {"r" => 3, "p" => 0, "s" => 6},
            "p" => {"p" => 3, "s" => 0, "r" => 6},
            "s" => {"s" => 3, "r" => 0, "p" => 6},
         }

@points = {"r" => 1, "p" => 2, "s" =>3}

def play(line)
  sym = {"A" => "r", "B" => "p", "C" => "s", "X" => "r", "Y" => "p", "Z" => "s"}
  opp,me = line.split(' ').map{|p| sym[p]}
 
  points = @points[me]
  score = @score[me][opp]
  
  points + score
end

def play_2(line)
  sym = {"A" => "r", "B" => "p", "C" => "s","X" => "L", "Y" => "D", "Z" => "W"}
  choice = {
            "L" => {"r" => "C", "p" => "A", "s" => "B"},
            "D" => {"r" => "A", "p" => "B", "s" => "C"},
            "W" => {"r" => "B", "p" => "C", "s" => "A"},
         }

  opp, me = line.split(' ')
   
  opp + " " + choice[sym[me]][sym[opp]]
end

def load (is_test = true)    
  file_path =  File.expand_path("../day-02#{is_test ? '-sample' : ''}.txt", __FILE__) 
  rounds = File.readlines(file_path)  
end

def process_part1  
  rounds = load(false)
  rounds.map{|r| play(r)}.reduce(&:+)
end


def process_part2  
  rounds = load(false)
  rounds.map{|a| play_2(a)}.map{|r| play(r)}.reduce(&:+)
end

def process  
  puts process_part2
end