require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize(capacity = 8)
    self.capacity = capacity
    self.length = 0
    self.store = StaticArray.new(length)
    self.start_idx = nil 
  end

  # O(1)
  def [](index)
    check_index(index)
    store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index > length
    store[(start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    check_index(0)
    val = self[length - 1]
    self[length - 1] = nil 
    self.length -= 1
    val
  end

  # O(1) amortized
  def push(val)
    self.start_idx ||= 0
    resize! if length == capacity 
    self[length] = val 
    self.length += 1
  end

  # O(1)
  def shift
    check_index(0)
    val = self[0]
    self[0] = nil 
    self.start_idx = (start_idx + 1) % capacity
    @length -= 1
    val
  end

  # O(1) amortized
  def unshift(val)
    @start_idx ||= 0 
    resize! if length == capacity 
    self[capacity - 1] = val;
    self.start_idx = length;
    self.length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    unless length > 0 && index.between?(0, length - 1)
      raise "index out of bounds" 
    end
  end

  def resize!
    self.capacity *= 2
    new_store = StaticArray.new(capacity)
    0.upto(length - 1) {|idx| new_store[idx] = self[idx]}
    self.store = new_store
  end
end
