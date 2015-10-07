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

      it "multiple params" do
        expect{PlayLab::FileLog.new 122, 1223}.to raise_error ArgumentError
      end

      context "param is path" do
        it "path not correct" do
          expect(PlayLab::FileLog.new "data/fake.log").to be_an_instance_of PlayLab::FileLog
        end
        context "path correct" do
          let(:path) {"data/sample.log"}
          let(:file_log) {PlayLab::FileLog.new path}

          it "to be instance of PlayLab::FileLog" do
            expect(file_log).to be_an_instance_of PlayLab::FileLog
          end
          it "params eq attr path" do
            expect(file_log.path).to eq path
          end
        end
      end
    end
  end

  describe "read" do
    context 'path correct' do
      let(:file_log) { PlayLab::FileLog.new "data/sample.log" }

      it "return not nil" do
        expect(file_log.read).to_not be_nil
      end
      it "return string" do
        expect(file_log.read).to be_an_instance_of String
      end
    end

    context 'path not correct' do
      let(:file_log) { PlayLab::FileLog.new "data/fake.log" }
      it 'railse exception' do
        begin
          file_log.read
        rescue SystemExit => e
          expect(e.status).to eq 1
        end
      end
    end
  end
end