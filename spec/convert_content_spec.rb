require 'spec_helper'

describe ConvertContent do
  context "new without param" do
    it "raise error Argument" do
      expect{ConvertContent.new}.to raise_error ArgumentError
    end
  end

  context "new with param" do
    context "param invalid" do
      it "param is string nil"
      it "param is number"
    end

    context "param valid" do
      before :each do
        file = ReadFile.new "data/sample.log"
        @file_content = file.read_file
        @convert = ConvertContent.new @file_content
      end

      it "to be a ConvertContent" do
        expect(@convert).to be_an_instance_of ConvertContent
      end

      it "content attr eq with param" do
        expect(@convert.content).to eq @file_content
      end

      describe "split content" do

        before :each do
          @content_split = @convert.send(:split_content)
        end

        it "result to be_a Array" do
          expect(@content_split).to be_a(Array)
        end

        it "result to_not be_nil" do
          expect(@content_split).to_not be_nil
        end
      end

      describe "convert to hash" do

        before :each do
          @hash_result = @convert.convert_to_hash
        end

        it "result to be_a Hash" do
          expect(@hash_result).to be_a(Hash)
        end

        it "hash result has 6 key" do
          expect(@hash_result.keys.count).to eq 6
        end

        it "each hash result value is array" do
          @hash_result.each do |k, v|
            expect(v).to be_a(Array)
          end
        end
      end
    end
  end
end