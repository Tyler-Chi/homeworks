class Stack

  attr_accessor :ivar

  def initialize
  @ivar = []
  end

  def add(el)
    @ivar << el
    el
  end


  def remove
    el = @ivar.pop
    el
  end

  def show
    @ivar
  end
end

class Queue

  def initialize
    @queue = []
  end
  #enqueue(el), dequeue, and show
  def enqueue(el)
    @queue << el
    el
  end

  def dequeue
    el =@queue.pop
    el

  end

  def show
    @queue
  end

end

class Map

  attr_accessor :map

  def initialize
    @map = [] #this will be a nested array
  end

  # Our Map class should have the following instance methods: assign(key, value), lookup(key),
  # remove(key), show. Note that the assign method can be used to either create a new key-value pair
  # or update the value for a pre-existing key. It's up to you to check whether a key currently exists!

  def assign(key,value)
    #first check to see if the key value pair already exists
    pair_index = nil
    @map.each_with_index do |sub_array,idx|
      pair_index = idx if sub_array[0] == key
    end
    if pair_index.nil?
      @map << [key,value]
    else
      @map[pair_index]=[key,value]
    end
  end

  def lookup(key)
    @map.each {|sub_array| return sub_array[1] if sub_array[0] == key }
    return nil
  end

  def remove(key)
    @map.reject! {|sub_array| sub_array[0]==key}
    return nil
  end

  def show
    @map
  end


end
