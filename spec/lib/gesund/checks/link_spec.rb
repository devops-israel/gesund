require "spec_helper"

describe Gesund::Checks::Link do
  it "sets success to false when arg is not a symlink" do
    File.stub(:symlink?).and_return false
    chk = described_class.new("somelink-xxx")
    chk.success.should be_false
    chk.message.should match "Symbolic link somelink-xxx is not a symlink"
  end
  it "sets success to true when arg is a symlink" do
    File.stub(:symlink?).and_return true
    chk = described_class.new("somelink-xxx")
    chk.success.should be_true
    chk.message.should match "Symbolic link somelink-xxx is a symlink"
  end
  it "sets success to false when arg does not target target" do
    File.stub(:symlink?).and_return true
    File.stub(:readlink).and_return "wrongtarget"
    chk = described_class.new("somelink-xxx", "xxx")
    chk.success.should be_false
    chk.message.should match "Symbolic link somelink-xxx is not targetting xxx"
  end
  it "sets success to true when arg targets target" do
    File.stub(:symlink?).and_return true
    File.stub(:readlink).and_return "xxx"
    chk = described_class.new("somelink-xxx", "xxx")
    chk.success.should be_true
    chk.message.should match "Symbolic link somelink-xxx is targetting xxx"
  end
end
