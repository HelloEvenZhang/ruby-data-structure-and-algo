# frozen_string_literal: true

class ListNode
  attr_accessor :val, :next

  def initialize(val = nil, _next = nil)
    @val = val
    @next = _next
  end
end
