require 'spec_helper'

describe Calculator do
  describe "initialize" do
    context "new without param" do
      it "raise error Argument" do
        expect{Calculator.new}.to raise_error ArgumentError
      end
    end

    context "new with param" do
      context "param invalid" do
        it "param is string"
        it "param is hash nil"
        it "param is number"
      end

      context "param valid hash" do
        before :each do
          file = ReadFile.new "data/sample.log"
          file_content = file.read_file
          convert = ConvertContent.new lines
          @hash_data = convert.convert_to_hash

          @calcu = Calculator.new @hash_data
        end

        it "to be a Calculator" do
          expect(@calcu).to be_an_instance_of Calculator
        end

        it "content attr eq with param" do
          expect(@calcu.data).to eq @hash_data
        end

        describe "calculator" do
          context "calculator without param" do
            it "raise error Argument"
          end

          context "calculator with param" do
            context "invalid param" do

            end

            context "valid param" do
            end
          end
        end
      end
    end
  end

  
end