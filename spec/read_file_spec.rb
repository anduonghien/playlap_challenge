require 'spec_helper'

describe ReadFile do
  describe "initialize" do
    context "new without param path" do
      it "new without param path" do
        expect{ReadFile.new}.to raise_error ArgumentError
      end
    end

    context "new with param path" do
      context "param invalid" do
        it "path is string nil"
        it "path is number"
      end

      context "param valid" do
        before :each do
          @file = ReadFile.new "data/sample.log"
        end

        it "init sucess" do
          expect(@file).to be_an_instance_of ReadFile
        end

        it "param eq with attr" do
          expect(@file.path).to eq "data/sample.log"
        end
      end
    end
  end

  describe "read file" do
    context "path invalid" do
      it "path string but not real" do
        file = ReadFile.new "fake_path.log"
        begin
          file.read_file
        rescue SystemExit => e
          expect(e.status).to eq 1
        end
      end
    end

    context "path valid" do
      before :each do
        @file = ReadFile.new "data/sample.log"
      end
      it "return not nil" do
        expect(@file.read_file).to_not be_nil
      end
      it "return string" do
        expect(@file.read_file).to be_an_instance_of String
      end
    end
  end
end