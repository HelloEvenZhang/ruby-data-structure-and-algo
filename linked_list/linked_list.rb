# frozen_string_literal: true

require_relative 'list_node'

class LinkedList
  attr_reader :head

  # 1 => 2 => 3 => 4
  #
  def self.reverse(head)
    prev_node = nil
    curr_node = head
    while curr_node
      next_node = curr_node.next
      curr_node.next = prev_node
      prev_node = curr_node
      curr_node = next_node
    end
    prev_node
  end

  def initialize(container)
    raise ArgumentError, 'container must respond to :each and :size' unless container.respond_to?(:each) && container.respond_to?(:size)

    @head = ListNode.new
    head = @head
    container.each.with_index do |val, index|
      head.val = val
      head.next = ListNode.new unless index == container.size - 1
      head = head.next
    end
  end

  def find(value)
    node = @head
    while node
      if node.val == value
        return node
      end
      node = node.next
    end
  end

  def insert(value)
    new_node = ListNode.new(value)
    new_node.next = @head
    @head = new_node
    data
  end

  def delete(value)
    prev_node = nil
    node = @head
    while node
      if node.val == value
        prev_node.next = node.next
        return value
      end
      prev_node = node
      node = node.next
    end
  end

  def find_at(index)
    node = @head
    if index.negative?
      node = LinkedList.reverse(node)
      index = -(index + 1)
    end
    (0...index).each do
      node = node.next
      return if node.nil?
    end
    node
  end

  def insert_at(index, value)
    new_node = ListNode.new(value)
    node = @head
    if index.zero?
      new_node.next = node
      @head = new_node
    else
      (0...index - 1).each do
        node = node.next
      end
      new_node.next = node.next
      node.next = new_node
    end
    data
  end

  def delete_at(index)
    node = @head
    (0...index).each do
      node = node.next
    end
    value = node.val
    node.val = node.next.val
    node.next = node.next.next
    value
  end

  def data
    node = @head
    output = []
    while node
      output << node.val
      node = node.next
    end
    output
  end

  def print_all
    p data.join(" => ")
  end
end

linked_list = LinkedList.new(0..5)
p linked_list.find_at(6)




