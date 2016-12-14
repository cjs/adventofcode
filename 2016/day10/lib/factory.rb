class Output
  attr_reader :slot
  def initialize
    @slot = nil
  end

  def id
    'output slot'
  end

  def assign(i)
    @slot = i
  end
end

class Bot
  attr_reader :slots
  attr_accessor :instructions, :id, :compares

  def initialize(id)
   @slots = Array.new
   raise if id.nil?
   @id = id
  end

  def assign(i)
    raise 'Slots are full' if @slots.compact.size == 2
    @slots << i
    if @slots.compact.size == 2
      self.compares = @slots.sort
      tmp = @slots.sort
      @slots.clear
      tmp.each_with_index do |s, index|
        begin
          @instructions[index].assign(s)
        end
      end
    end
  end
end
