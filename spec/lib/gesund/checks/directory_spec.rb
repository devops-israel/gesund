require "spec_helper"

describe Gesund::Checks::Directory do
  it "sets success to false when arg is not a directory" do
    expect(File).to receive(:directory?) { false }
    chk = described_class.new("somedir")
    expect(chk.success).to equal(false)
    expect(chk.message).to match "Directory somedir is not a directory"
  end
  it "sets success to true when arg is a directory" do
    expect(File).to receive(:directory?) { true }
    chk = described_class.new("somedir")
    expect(chk.success).to equal(true)
    expect(chk.message).to match "Directory somedir is a directory"
  end
end
