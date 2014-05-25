require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Node Model" do
  it 'can construct a new instance' do
    @node = Node.new
    refute_nil @node
  end
end
