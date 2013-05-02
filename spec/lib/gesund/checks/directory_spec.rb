require "spec_helper"

describe Gesund::Checks::Directory do
  it "sets success to false when arg is not a directory" do
    File.stub(:directory?).and_return false
    chk = described_class.new("somedir")
    chk.success.should be_false
    chk.message.should match "Directory somedir is not a directory"
  end
  it "sets success to true when arg is a directory" do
    File.stub(:directory?).and_return true
    chk = described_class.new("somedir")
    chk.success.should be_true
    chk.message.should match "Directory somedir is a directory"
  end
end
