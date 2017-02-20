module Enumerable
  def my_each
    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    index = 0
    self.my_each { |x| 
      yield(x, index)
      index += 1 }
  end

  def my_select
    array = []
    self.my_each { |x| array << x if  yield(x) }
    array
  end

  def my_all?
    array = []
    if block_given?
      self.my_each { |x| array << 0 if yield(x) != true }
    else
      self.my_each { |x| array << 0 if x != true }
    end
    array.empty? ? true : false
  end

  def my_any?
    array = []
    if block_given?
      self.my_each { |x| array << 1 if yield(x) }
    else
      self.my_each { |x| array << 1 if x }
    end
    array.empty? ? false : true
  end

  def my_none?
    array = []
    if block_given?
      self.my_each { |x| array << 1 if yield(x) }
    else
      self.my_each { |x| array << 1 if x }
    end
    array.empty? ? true : false
  end

  def my_count(arg = nil)
    if block_given?
      array = []
      self.my_each { |x| array << x if yield(x) }
      array.length
    elsif arg != nil
      count = 0
      self.my_each { |x| count += 1 if x == arg}
      count
    else
      self.length
    end
  end

  def my_map(arg = nil)
    maped_array = []
    self.my_each { |x| maped_array << (block_given? ? yield(x) : arg.call(x)) } 
    maped_array
  end

  def my_inject(arg = 0)
    accumulator = arg
    self.my_each { |i| accumulator = yield(accumulator, i) }
    accumulator
  end
end

def multiply_els(array)
  array.my_inject(1) { |product, i| product * i }
end