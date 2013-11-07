require 'minitest/autorun'
require_relative '../queue'

# needs to be circular
# edge cases...
# fixed size

describe "Queue" do
  describe "#enqueue" do
    it "adds an object to the queue" do
      queue = Queue.new
      queue.enqueue("heyo")
      queue.queue.must_include 'heyo'
    end

    it "raises an error if you enqueue and the queue is full" do
      queue = Queue.new(10)
      10.times do
        #queue.enqueue 'getting full...'
      end
      #proc {queue.enqueue 'should raise'}.must_raise QueueFullException
    end
  end

  describe "#dequeue" do
    it "returns an item from the queue" do
      queue = Queue.new
      queue.enqueue('hello')
      queue.enqueue('friend')
      queue.dequeue.must_equal 'hello'
    end

    it "always returns the oldest item from the queue" do
      queue = Queue.new
      queue.enqueue('hello')
      queue.enqueue('friend')
      queue.dequeue
      queue.dequeue.must_equal 'friend'
    end
  end

  describe "#queue_full?" do
    describe "the queue is empty" do
      it "returns false" do
        Queue.new.queue_full?.must_equal false
      end
    end

    describe "adding enough things to fill it up" do
      it "is full" do
        queue = Queue.new(3)
        queue.enqueue 'heyo'
        queue.enqueue 'heyo'
        queue.enqueue 'heyo'
        queue.queue_full?.must_equal true
      end
    end
  end

  describe "it is a circular queue" do
    describe "head goes back to zero once it gets to the end of the queue" do
      it "can use a small queue to enqueue/dequeue many times" do
        queue = Queue.new(3)
        3.times do |i|
          #queue.enqueue "hello_#{i}"
        end
        3.times do |i|
          queue.dequeue
        end
        queue.enqueue "hello"
        #queue.dequeue.must_equal 'hello'
      end
    end
  end
end
