# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store 

  def initialize
    self.store = RingBuffer.new
    @vals = Hash.new(0)
    @max_val = nil 
  end

  def enqueue(val)
    self.store.unshift(val)
    self.vals[val] += 1
    self.max_val ||= val
    self.max_val = val if val > max_val
  end

  def dequeue
    ejected = self.store.pop
    self.vals[ejected] -= 1
    self.vals.delete(ejected) if vals[ejected] == 0
    if ejected == max_val
      self.max_val = vals.keys.max
    end
  end

  def max
    max_val
  end

  def length
    store.length
  end

  protected 

  attr_accessor :max_val, :vals

end
