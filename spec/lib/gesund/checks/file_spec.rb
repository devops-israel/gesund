require "spec_helper"

describe Gesund::Checks::File do
  subject { Gesund::Checks::File.new('somefile') }
  it "sets success as true when file is a file" do
    expect(File).to receive(:file?) { true }
    expect(subject.success).to equal(true)
    expect(subject.message).to match "File somefile is a file"
  end
  it "sets success to false when file is not a file" do
    expect(File).to receive(:file?) { false }
    expect(subject.success).to equal(false)
    expect(subject.message).to match "File somefile is not a file"
  end
end
