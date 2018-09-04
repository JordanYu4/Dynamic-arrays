require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0 
    @store = StaticArray.new(@capacity)
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
    @length += 1
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
    val = store[0]
    1.upto(length - 1) do |idx|
      store[idx - 1] = store[idx]
    end
    @length -= 1
    val
  end
  
  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity 
    (length).downto(1) do |idx|
      store[idx] = store[idx - 1]
    end
    store[0] = val;
    @length += 1
  end

  protected
  attr_accessor :capacity, :store 
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless store[index] 
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(capacity)
    0.upto(length) {|idx| new_store[idx] = store[idx]}
    @store = new_store
  end
end
