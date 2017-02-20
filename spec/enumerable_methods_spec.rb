require "enumerable_methods"

describe Enumerable do

  let(:mixed_array) { ["one","two",3,5,10] }
  let(:mixed_array2) { [3,5,10, "string"] }
  let(:mixed_array3) { [nil, true, 99] }
  let(:integer_array) { [3,5,10] }
  let(:integer_array2) { [1, 2, 4, 2] }
  let(:string_array) { %w[ant bear cat] }
  let(:proc) { Proc.new { |x| x**3 } }

  describe "#my_map" do
    it "Returns an array" do
      expect((1..4).my_map{ |i| i*i }).to be_instance_of Array
      expect((1..4).my_map(proc)).to be_instance_of Array
    end

    it "Takes a proc as input" do
      expect((1..4).my_map(proc)).to eql([1, 8, 27, 64])
    end

    it "Takes block a block as input" do
      expect((1..4).my_map{ "cat" }).to eql(["cat", "cat", "cat", "cat"])
    end
  end

  describe "#my_any?" do
    it "Adds an implicit block of { |obj| obj }, if no block is given" do
      expect([mixed_array3].my_any?).to be_truthy
    end

    it "Return true if at least one of the collection members is not false or nil." do
      expect([nil, "string", nil, nil, nil, nil].my_any?).to be_truthy
    end

    it "Passes each element of the collection to the given block" do
      expect(string_array.my_any?{ |x| x.length >= 3 }).to be_truthy
    end

    it "Returns false when all evaluations returs false" do
      expect(integer_array.my_any?{ |x| x.kind_of? String }).to be_falsy
    end
  end

  describe "#my_all?" do
    it "Passes each element of the collection to the given block" do
      expect(string_array.my_all? { |x| x.length >= 3 }).to be_truthy
    end

    it "Returns true if the block never returns false or nil" do
      expect(integer_array.my_all?{ |x| x.kind_of? Integer }).to be_truthy
    end

    it "Adds an implicit block of { |obj| obj }, if no block is given" do
      expect(mixed_array3.my_all?).to be_falsy
    end

    it "Returns false when at least one elemnt is false" do
      expect(mixed_array2.my_all?{ |x| x.kind_of? Integer }).to be_falsy
    end
  end

  describe "#my_none?" do
    it "Passes each element of the collection to the given block" do
      expect(string_array.my_none? { |x| x.length >= 4 }).to be_falsy
    end

    it "Returns true if the block returns false for all elements" do
      expect(integer_array.my_none? { |x| x.kind_of? String }).to be_truthy
    end

    it "Adds an implicit block of { |obj| obj }, if no block is given" do
      expect([nil, false, true].my_none?).to be_falsy
    end

    it "Returns true for empty array" do
      expect([].my_none?).to be_truthy
    end

    it "Raturn true if all elements are nil or false" do
      expect([nil, false, nil, false].my_none?).to be_truthy
    end
  end

  describe "#my_count" do
    it "Returns the number of items" do
      expect(integer_array2.my_count).to eql(4)
    end

    it "Count number of items equal to argument, if its given." do
      expect(integer_array2.my_count(2)).to eql(2)
    end

    it "Counts the number of elements yielding a true value, if block given" do
      expect(integer_array2.my_count{ |x| x%2==0  }).to eql(3)
    end
  end

  describe "#my_select" do
    it "Returns an array" do
      expect(integer_array.my_select { |x| x.even? }).to be_instance_of Array
    end

    it "Returns an array of elements for which given block returns true" do
      expect(mixed_array.my_select { |x| x.kind_of? String }).to eql(["one", "two"])
    end
  end
end