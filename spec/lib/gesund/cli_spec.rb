require "spec_helper"
require "gesund/cli" # not usually required when requiring gesund

describe Gesund::CLI do
  let(:gesundfile) { File.expand_path('Gesundfile') }

  describe "#check" do
    it "evaluates the supplied gesundfile" do
      expect(Gesund::Dsl).to receive(:evaluate).with(gesundfile) { ['checks-text'] }
      expect(Gesund::Output::Text).to receive(:new).with(['checks-text'])
      subject.check
    end
  end
  context "#http" do
    it "should raise an error when the Gesundfile is not readable" do
      expect(File).to receive(:readable?).with(gesundfile) { false }
      expect { subject.http }.to raise_error(Errno::EACCES, /Can't read file #{gesundfile}/)
    end
    describe "gesund file is readable" do
      before do
        expect(File).to receive(:readable?).with(gesundfile) { true }
      end
      it "evaluates a supplied gesundfile" do
        expect(Gesund::Dsl).to receive(:evaluate).with(gesundfile) { ['checks-http'] }
        expect(Gesund::Output::Rack).to receive(:start).with(['checks-http'], {})
        subject.http
      end
    end
  end
end
