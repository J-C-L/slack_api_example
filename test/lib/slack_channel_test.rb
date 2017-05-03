require 'test_helper'

describe SlackChannel do
  describe 'initialize' do
    it "Takes a name" do
      name = "test channel"
      sc = SlackChannel.new(name)
      sc.name.must_equal name
    end
  end
end
