require 'spec_helper'
describe PlayLab::FileLog do
  describe "initialize" do
    it "without param path" do
      expect{PlayLab::FileLog.new}.to raise_error ArgumentError
    end

    context "with param path" do
      it "param is nil" do
        expect{PlayLab::FileLog.new nil}.to raise_error Error::ParamEmptyError
      end

      it "param is string empty" do
        expect{PlayLab::FileLog.new ""}.to raise_error Error::ParamEmptyError
      end

      it "param is number" do
        expect(PlayLab::FileLog.new 122).to be_an_instance_of PlayLab::FileLog
      end

      context "param is path" do
        it "path correct" do
          expect(PlayLab::FileLog.new "data/sample.log").to be_an_instance_of PlayLab::FileLog
        end

        it "path not correct" do
          expect(PlayLab::FileLog.new "data/sample_1.log").to be_an_instance_of PlayLab::FileLog
        end
      end

    end
  end
end