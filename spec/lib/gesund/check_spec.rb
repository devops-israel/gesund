require "spec_helper"

describe "Gesund::Check module" do
  let(:dummy_check) { Class.new.extend Gesund::Check }
  let(:headers) {  {"Content-Type" => "text/plain"}  }
  it "has an accessor named success" do
    dummy_check.should respond_to :call
  end
  it "has an accessor named message" do
    dummy_check.should respond_to :message
  end
  it "returns status 200 on healthy checks" do
    dummy_check.success = true
    dummy_check.message = "something is healthy"
    dummy_check.call.should == [200, headers, ["something is healthy"]]
  end
  it "returns status 500 on sick checks" do
    dummy_check.success = false
    dummy_check.message = "something is sick"
    dummy_check.call.should == [500, headers, ["something is sick"]]
  end
  it "returns status 500 on empty messages" do
    dummy_check.success = true
    dummy_check.call.should == [500, headers, ["Class is broken!"]]
  end
  it "fails when fail is called" do
    dummy_check.fail("booo!")
    dummy_check.call.should == [500, headers, ["booo!"]]
  end
  it "passes when pass is called" do
    dummy_check.pass("yey!")
    dummy_check.call.should == [200, headers, ["yey!"]]
  end
end
