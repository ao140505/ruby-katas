class Queue
  attr_reader :queue, :max_size
  attr_accessor :head, :tail, :current_size

  def initialize(max_size=100)
    @max_size = max_size
    @current_size = 0
    @queue = []
    @head = 0
    @tail = 0
  end

  def enqueue(obj)
    if queue_full?
      raise QueueFullException.new 'queue is currently full'
    else
      self.queue << obj
      self.tail = next_tail_position
      self.current_size += 1
    end
  end

  def dequeue
    queue.shift
    self.current_size -= 1
  end

  def queue_full?
    if queue.empty?
      false
    else
      self.current_size == max_size
    end
  end

  private

  def next_head_position
    if head == max_size
      0
    elsif head == tail
      0
    else
      head + 1
    end
  end

  def next_tail_position
    tail + 1
  end
end

class QueueFullException < StandardError; end

#[.........................]
#   h->            t
