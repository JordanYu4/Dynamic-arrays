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
  end

  def enqueue(val)
    self.store.unshift(val)
    self.vals[val] += 1
  end

  def dequeue
    self.vals[self.store.pop] -= 1
    p vals
  end

  def max
    vals.keys[-1]
  end

  def length
    store.length
  end

  protected 

  attr_accessor :vals

end
