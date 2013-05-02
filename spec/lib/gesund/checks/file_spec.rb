require "spec_helper"

describe Gesund::Checks::File do
  subject { Gesund::Checks::File.new('somefile') }
  it "sets success as true when file is a file" do
    File.stub(:file?).and_return true
    subject.success.should be_true
    subject.message.should match "File somefile is a file"
  end
  it "sets success to false when file is not a file" do
    File.stub(:file?).and_return false
    subject.success.should be_false
    subject.message.should match "File somefile is not a file"
  end
end
