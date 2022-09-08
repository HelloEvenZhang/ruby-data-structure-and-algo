# frozen_string_literal: true

require 'forwardable'

# 1.大小固定的有序数组
# 2.数组中的数据类型是Integer
# 3.支持动态增删改查
# 4.支持两个有序数组合并为一个有序数组
#
# Author: Even
# Date: 2022-09-05
class SortedArray
  extend Forwardable
  include Enumerable

  attr_reader :size, :data

  def_delegators :@data, :each

  def initialize(size, *default, &block)
    @size = size
    @data = Array.new(size, *default, &block).flatten.compact
    raise TypeError, 'only integers allowed in SortedArray' if @data.find { |i| !i.is_a? Integer }

    @data.sort!
  end

  def [](index)
    raise IndexError, "index #{index} outside of array bounds: #{-@size}...#{@size}" unless (-@size...@size).include?(index)

    @data[index]
  end

  def insert(value)
    raise TypeError, 'only integers allowed in SortedArray' unless value.is_a? Integer
    raise IndexError, 'SortedArray is out of Bounds' if @size < @data.size + 1

    index = @data.find_index { |i| i > value } || @data.size
    @data.insert(index, value)
  end

  def delete(value)
    index = @data.find_index { |i| i == value } || @data.size
    @data.delete_at(index)
  end

  def merge(new_array)
    raise TypeError, 'must merge an Array' unless new_array.is_a? Array
    raise TypeError, 'only integers allowed in SortedArray' if new_array.find { |i| !i.is_a? Integer }
    raise IndexError, 'SortedArray is out of Bounds' if @size < @data.size + new_array.size

    @data.concat(new_array)
    @data.sort!
  end

  def print_all
    p @data
  end
end

arr = SortedArray.new(20)
arr.merge([8,4,3,2,6,1,5,7,9]) # [1,2,3,4,5,6,7,8,9]
arr.insert(5) # [1,2,3,4,5,5,6,7,8,9]
arr.delete(5) # [1,2,3,4,5,6,7,8,9]
arr.merge([10,11,13,15,17,18,19,12,14,16,20]) # [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
# 省略各种Enumerable方法


