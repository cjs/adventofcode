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
    p "Bot #{self.id} slots are full (#{@self.slots}), was assigned #{i}" if @slots.compact.size == 2
    raise 'Slots are full' if @slots.compact.size == 2
    p "Assigning #{i} to Bot #{self.id}"
    @slots << i
    if @slots.compact.size == 2
      p "Bot #{self.id} slots are #{@slots.sort}"
      self.compares = @slots.sort
      tmp = @slots.sort
      @slots.clear
      tmp.each_with_index do |s, index|
        begin
          @instructions[index].assign(s)
          p "Bot #{self.id} assigning #{s} to #{@instructions[index].id}"
        end
      end
      p "Bot #{self.id} slots are cleared "
    end
  end
end
