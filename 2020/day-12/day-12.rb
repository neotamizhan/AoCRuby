def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.readlines(file_path)
  
  #format input
  lines.map {|x|[x[0], x[1..].to_i]}
end

def turn (dir, turn, degree)
  turn_sheet = {"ER90" => 'S',"ER180" => 'W',"ER270" => 'N',"EL90" => 'N',"EL180" => 'W',"EL270" => 'S',"WR90" => 'N',"WR180" => 'E',"WR270" => 'S',"WL90" => 'S',"WL180" => 'E',"WL270" => 'N',"NR90" => 'E',"NR180" => 'S',"NR270" => 'W',"NL90" => 'W',"NL180" => 'S',"NL270" => 'E',"SR90" => 'W',"SR180" => 'N',"SR270" => 'E',"SL90" => 'E',"SL180" => 'N',"SL270" => 'W'}

  turn_sheet["#{dir}#{turn}#{degree}"]
end

def move (pos, dir, ins, steps)
  cmd = (ins == 'F') ? dir : ins
  case cmd
  when 'E'
    pos['EW'] += steps
  when 'W'
    pos['EW'] -= steps
  when 'N'
    pos['NS'] += steps
  when 'S'
    pos['NS'] -= steps    
  end

  pos
end

def process_part1
  instructions = load(day: "12", is_test: false)

  pos = {"EW" => 0, "NS" => 0}  
  dir = 'E'

  instructions.each do |ins|
    case ins[0]
    when /[LR]/
      dir = turn(dir, ins[0], ins[1])
    when /[FEWNS]/
      pos = move(pos, dir, ins[0], ins[1])
    end

    puts pos    
  end

  puts pos["EW"].abs + pos["NS"].abs
end


def process_part2
  instructions = load(day: "12", is_test: true)

  wp = {"EW" => 10, "NS" => 1}  
  ship = {"EW" => 0, "NS" => 0}    
  dir = 'E'

  instructions.each do |ins|
    case ins[0]
    when /[LR]/
      dir = turn(dir, ins[0], ins[1])
    when /[EWNS]/
      wp = move(wp, dir, ins[0], ins[1])
    when 'F'
      ship["EW"] += wp["EW"]*ins[1]
      ship["NS"] += wp["NS"]*ins[1]
    end
    puts ins
    puts wp
    puts ship    
    puts
  end

  puts ship["EW"].abs + ship["NS"].abs
end

def process
  process_part2
end