require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(capacity = 8)
    self.capacity = capacity
    self.length = 0 
    self.store = StaticArray.new(capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end
  
  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index > length
    store[index] = value
  end

  # O(1)
  def pop
    check_index(0)
    val = self[length - 1]
    self[length - 1] = nil 
    self.length -= 1
    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity 
    self[length] = val 
    self.length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(0)
    val = self[0]
    1.upto(length - 1) do |idx|
      self[idx - 1] = self[idx]
    end
    self.length -= 1
    val
  end
  
  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity 
    (length).downto(1) do |idx|
      self[idx] = self[idx - 1]
    end
    self[0] = val;
    self.length += 1
  end

  protected
  attr_accessor :capacity, :store 
  attr_writer :length

  def check_index(index)
    unless length > 0 && index.between?(0, length - 1)
      raise "index out of bounds" 
    end  
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    self.capacity *= 2
    new_store = StaticArray.new(capacity)
    0.upto(length - 1) {|idx| new_store[idx] = self[idx]}
    self.store = new_store
  end
end
