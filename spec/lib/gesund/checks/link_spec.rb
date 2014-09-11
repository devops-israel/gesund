require "spec_helper"

describe Gesund::Checks::Link do
  it "sets success to false when arg is not a symlink" do
    expect(File).to receive(:symlink?) { false }
    chk = described_class.new("somelink-xxx")
    expect(chk.success).to equal(false)
    expect(chk.message).to match "Symbolic link somelink-xxx is not a symlink"
  end
  it "sets success to true when arg is a symlink" do
    expect(File).to receive(:symlink?) { true }
    chk = described_class.new("somelink-xxx")
    expect(chk.success).to equal(true)
    expect(chk.message).to match "Symbolic link somelink-xxx is a symlink"
  end
  it "sets success to false when arg does not target target" do
    expect(File).to receive(:symlink?) { true }
    expect(File).to receive(:readlink) { "wrongtarget" }
    chk = described_class.new("somelink-xxx", "xxx")
    expect(chk.success).to equal(false)
    expect(chk.message).to match "Symbolic link somelink-xxx is not targetting xxx"
  end
  it "sets success to true when arg targets target" do
    expect(File).to receive(:symlink?) { true }
    expect(File).to receive(:readlink) { "xxx" }
    chk = described_class.new("somelink-xxx", "xxx")
    expect(chk.success).to equal(true)
    expect(chk.message).to match "Symbolic link somelink-xxx is targetting xxx"
  end
end
