require 'spec_helper'
describe PlayLab::ContentLog do
  describe "initialize" do
    it "without param path" do
      expect{PlayLab::ContentLog.new}.to raise_error ArgumentError
    end

    context "with param path" do
      it "param is nil" do
        expect{PlayLab::ContentLog.new nil}.to raise_error Error::ParamEmptyError
      end

      it "param is string empty" do
        expect{PlayLab::ContentLog.new ""}.to raise_error Error::ParamEmptyError
      end

      it "param is number" do
        expect(PlayLab::ContentLog.new 122).to be_an_instance_of PlayLab::ContentLog
      end

      it "multiple params" do
        expect{PlayLab::ContentLog.new 122, 1223}.to raise_error ArgumentError
      end
      describe "params is string" do
        let(:param) {"this is params"}
        let(:content_log) {PlayLab::ContentLog.new param}

        it "be an instance of Playlab::ContentLog" do
          expect(content_log).to be_an_instance_of PlayLab::ContentLog
        end

        it "params eq atrr content" do
          expect(content_log.content).to eq param
        end
      end
    end
  end

  describe "split via new line" do
    let(:file_log) { PlayLab::FileLog.new "data/sample.log" }
    let(:content_log) { PlayLab::ContentLog.new file_log }
    
    it "to not be nil" do
      expect(content_log.send(:split_via_new_line)).to_not be_nil
    end

    it "to be a Array" do
      expect(content_log.send(:split_via_new_line)).to be_a(Array)
    end
  end

  describe "convert to hash" do
    let(:file_log)              { PlayLab::FileLog.new "data/sample.log" }
    let(:content_log)           { PlayLab::ContentLog.new file_log }
    let(:result_after_convert)  {content_log.convert_to_hash}
    
    it "to not be nil" do
      expect(result_after_convert).to_not be_nil
    end

    it "to be a Hash" do
      expect(result_after_convert).to be_a(Hash)
    end

    it "hash result has 6 key" do
      expect(result_after_convert.keys.count).to eq 6
    end

    it "each hash result value is array" do
     result_after_convert.each do |k, v|
        expect(v).to be_a(Array)
      end
    end
  end
end