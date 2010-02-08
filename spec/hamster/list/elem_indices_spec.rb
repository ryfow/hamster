require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/list'

describe Hamster::List do

  [:elem_indices, :indices].each do |method|

    describe "##{method}" do

      it "is lazy" do
        lambda { Hamster.stream { fail }.send(method, nil) }.should_not raise_error
      end

      [
        [[], "A", []],
        [["A"], "B", []],
        [["A", "B", "A"], "B", [1]],
        [["A", "B", "A"], "A", [0, 2]],
        [[2], 2, [0]],
        [[2], 2.0, [0]],
        [[2.0], 2.0, [0]],
        [[2.0], 2, [0]],
      ].each do |values, item, expected|

        describe "looking for #{item.inspect} in #{values.inspect}" do

          before do
            list = Hamster.list(*values)
            @result = list.send(method, item)
          end

          it "returns #{expected.inspect}" do
            @result.should == Hamster.list(*expected)
          end

        end

      end

    end

  end

end
