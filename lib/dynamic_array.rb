require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 4
    @length = 0 
    @store = StaticArray.new(@capacity)
    @start = nil
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end
  
  # O(1)
  def []=(index, value)
    check_index(index)
    store[index] = value
    length += 1
    start = start || 0
  end

  # O(1)
  def pop
    check_index(0)
    val = store[length - 1]
    store[length - 1] = nil 
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity 
    store[length] = val 
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(0)
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :store, :start 
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless store[index] 
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
