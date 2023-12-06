class Monkey
  attr_accessor :items, :inspected

  def loader(lines)
    @items = []
    lines.each do |line|
      type, text = line.split(':')

      case type.strip
      when /^Monkey/
        @id = type.split(' ')[1].to_i
      when /^Starting/
        @items = text.chomp.split(',').map { |i| i.to_i }
      when /^Operation/
        @operation = get_operation(text.strip)
      when /^Test/
        @tester = get_tester(text)
      when /^If true/
        @when_true = text.split(' ')[-1].to_i
      when /^If false/
        @when_false = text.split(' ')[-1].to_i
      end
    end
  end

  def initialize(lines)
    @inspected = 0
    loader(lines)
  end

  def process1(monkeys)    
    @items.each do |item|
      @inspected += 1
      worry = (@operation.call(item) / 3).round
      @items = @items.drop(1)
      @tester.call(worry) ? monkeys[@when_true].items << worry : monkeys[@when_false].items << worry
    end
  end

  def process2(monkeys)   
    until @items.empty?
      @inspected += 1
      worry = @operation.call(@items.shift)
      @tester.call(worry) ? monkeys[@when_true].items << worry : monkeys[@when_false].items << worry
    end
  end

  def catch_item(item)
    @items << item
  end

  def get_operation(operation)
    new, eq, old, operator, operand = operation.chomp.split(' ')
    operand = (operand == 'old') ? -99 : operand.to_i
    
    case operator
      when '+'        
        oper = (operand == -99) ? lambda {|val| print '.' val + val} : lambda {|val| val + operand}  
      when '-'
        oper = (operand == -99) ? lambda {|val| val - val} : lambda {|val| val - operand} 
      when '*'
        oper = (operand == -99) ? lambda {|val| val * val} : lambda {|val| val * operand} 
      when '/'
        oper = (operand == -99) ? lambda {|val| val / val} : lambda {|val| val / operand} 
    else
      oper = lambda {|val| val}  
    end

    oper
  end

  def get_tester(test)
    num = test.split(' ')[2].to_i
    ->(val) { val%num == 0 }
  end
end

def load(is_test: true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)
  lines = File.read(file_path).split("\n\n").map { |l| l.split("\n") }

  monkeys = []
  lines.map { |line| monkeys << Monkey.new(line) }
  
  monkeys  
end

def process_part1
  monkeys = load(is_test: false)
  20.times do
    monkeys.each { |m| m.process1(monkeys) }
  end
  puts monkeys.map {|m| m.inspected}.to_s
  puts monkeys.map {|m| m.inspected}.sort[-2..-1].reduce(&:*)

  monkeys
end

def process_part2
  monkeys = load(is_test: true)

  1000.times do
    monkeys.each { |m| m.process2(monkeys) }
  end

  puts monkeys.map {|m| m.inspected}.to_s
end

def process
  process_part2
end
