require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(length)
    @start_idx = nil 
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # O(1)
  def []=(index, val)
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

  # O(1) ammortized
  def push(val)
    resize! if length == capacity 
    store[length] = val 
    @length += 1
  end

  # O(1)
  def shift
    check_index(0)
    val = store[0]
    1.upto(length - 1) do |idx|
      store[idx - 1] = store[idx]
    end
    @length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == capacity 
    (length).downto(1) do |idx|
      store[idx] = store[idx - 1]
    end
    store[0] = val;
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless store[index] 
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(capacity)
    0.upto(length) {|idx| new_store[idx] = store[idx]}
    @store = new_store
  end
end
