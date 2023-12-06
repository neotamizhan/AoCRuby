
class Monkey
  attr_accessor :id, :items, :operation, :tester, :when_true, :when_false, :inspected

  def loader(lines)
    lines.each do |line|      
      type, text = line.split(':')

      case type.strip
        when /^Monkey/
          @id = type.split(' ')[1].to_i
        when /^Starting/
          @items = text.chomp.split(",").map {|i| i.to_i}
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
  
  def initialize (lines)  
    @inspected = 0
    loader(lines)
  end

  def process(monkeys)  
    @items.each do |item|
      @inspected = @inspected + 1
      worry = (@operation.call(item)/3).round 
      @items = @items.drop(1)
      @tester.call(worry) ? monkeys[@when_true].items << item : monkeys[@when_false].items << item
    end
  end

  def catch_item(item)
    @items << item
  end
  
  def get_operation(operation)
    new, eq, old, operator, operand = operation.chomp.split(' ')
    oper = lambda do |val|       
      eval("#{val} #{operator} #{operand == 'old' ? val : operand}")
    end

    oper
  end

  def get_tester(test)
    num = test.split(' ')[2].to_i
    lambda {|val| eval("#{val}%#{num} == 0")}
  end
end

def load (is_test: true)      
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  lines = File.read(file_path).split("\n\n").map {|l| l.split("\n")}

  monkeys = []
  lines.map{|line| monkeys << Monkey.new(line)}

  #monkeys.each {|m| puts m.items.to_s}
  20.times {monkeys.each {|m| m.process(monkeys)}}
  monkeys.each {|m| puts m.inspected}
end


def process_part1
  load(is_test: false)
end


def process_part2  
  load(is_test: false)
end

def process
  process_part1
end