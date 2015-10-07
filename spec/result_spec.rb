require 'spec_helper'
describe PlayLab::Result do
  describe "initialize" do
    it "without param path" do
      expect{PlayLab::Result.new}.to raise_error ArgumentError
    end

    context "with param path" do
      it "param is nil" do
        expect{PlayLab::Result.new nil}.to raise_error Error::ParamTypeError
      end

      it "param is string" do
        expect{PlayLab::Result.new "String"}.to raise_error Error::ParamTypeError
      end

      it "param is string empty" do
        expect{PlayLab::Result.new ""}.to raise_error Error::ParamTypeError
      end

      it "param is Array" do
        expect{PlayLab::Result.new ["a", "b", "c"]}.to raise_error Error::ParamTypeError
      end

      it "param is number" do
        expect{PlayLab::Result.new 122}.to raise_error Error::ParamTypeError
      end

      it "multiple params" do
        expect{PlayLab::Result.new 122, 1223}.to raise_error ArgumentError
      end

      context "param is Hash" do
        context "path correct" do
          let(:param) {{a_key: "a_value", b_key: "b_value"}}
          let(:result) {PlayLab::Result.new param}

          it "to be instance of PlayLab::Result" do
            expect(result).to be_an_instance_of PlayLab::Result
          end
          it "params eq attr data" do
            expect(result.data).to eq param
          end
        end
      end
    end
  end

  describe "average time" do
    let(:param) {{a_key: "a_value", b_key: "b_value"}}
    let(:result) {PlayLab::Result.new param}

    context "params invalid" do
      it "empty with param" do
        expect{result.send(:average_time)}.to raise_error ArgumentError
      end

      it "is a string" do
        expect{result.send(:average_time, "String")}.to raise_error Error::ParamTypeError
      end

      it "is a Hash" do
        expect{result.send(:average_time, {a: "1", b: "2"})}.to raise_error Error::ParamTypeError
      end

      it "is a number" do
        expect{result.send(:average_time, 1)}.to raise_error Error::ParamTypeError
      end

      it "multiple params" do
        expect{result.send(:average_time, "String", 2)}.to raise_error ArgumentError
      end
    end

    context "params is a Array" do
      let(:average_time) {result.send(:average_time, [1,2,3])}

      it "not be nil" do
        expect(average_time).to_not be_nil
      end

      it "be a String" do
        expect(average_time).to be_a(String)
      end
    end
  end

  describe "max dyno" do
    let(:param) {{a_key: "a_value", b_key: "b_value"}}
    let(:result) {PlayLab::Result.new param}

    context "params invalid" do
      it "empty with param" do
        expect{result.send(:max_dyno)}.to raise_error ArgumentError
      end

      it "is a string" do
        expect{result.send(:max_dyno, "String")}.to raise_error Error::ParamTypeError
      end

      it "is a Array" do
        expect{result.send(:max_dyno, [1,2,3])}.to raise_error Error::ParamTypeError
      end

      it "is a number" do
        expect{result.send(:max_dyno, 1)}.to raise_error Error::ParamTypeError
      end

      it "multiple params" do
        expect{result.send(:max_dyno, "String", 2)}.to raise_error ArgumentError
      end
    end

    context "params is a Hash" do
      let(:max_dyno) {result.send(:max_dyno, {key_1: "value 1", key_2: "value 2"})}

      it "not be nil" do
        expect(max_dyno).to_not be_nil
      end

      it "be a String" do
        expect(max_dyno).to be_a(String)
      end
    end
  end

  describe "add_one_result_to_text_plain" do
    let(:param) {{a_key: "a_value", b_key: "b_value"}}
    let(:result) {PlayLab::Result.new param}

    it "with 1 param" do
      expect(result.send(:add_one_result_to_text_plain, "abc")).to be_a(String)
    end

    it "with 2 param" do
      expect(result.send(:add_one_result_to_text_plain, "abc", 1)).to be_a(String)
    end

    it "with 3 param" do
      expect(result.send(:add_one_result_to_text_plain, "abc", 1, 2)).to be_a(String)
    end

    it "with 4 param" do
      expect{result.send(:add_one_result_to_text_plain, "abc", 1, 2, 3, "dyno1")}.to raise_error ArgumentError
    end
  end

  describe "result sucessfully" do
    let(:file_log) { PlayLab::FileLog.new "data/sample.log" }
    let(:content_log) { PlayLab::ContentLog.new file_log }
    let(:hash_data) {content_log.convert_to_hash}
    let(:result) {PlayLab::Result.new hash_data}

    context "calculator" do
      context "invalid param" do
        it "without params" do
          expect{result.send(:calculator)}.to raise_error ArgumentError
        end

        it "with 1 params" do
          expect{result.send(:calculator, "params 1")}.to raise_error ArgumentError
        end

        it "with 2 params, params 2 is string" do
          expect{result.send(:calculator, "params 1", "params 2")}.to raise_error Error::ParamTypeError
        end

        it "with 2 params, params 2 is number" do
          expect{result.send(:calculator, "params 1", 2)}.to raise_error Error::ParamTypeError
        end

        it "with 2 params, params 2 is hash" do
          expect{result.send(:calculator, "params 1", {key_1: "key_1", key_2: "key_2"})}.to raise_error Error::ParamTypeError
        end

        it "with 3 params" do
          expect{result.send(:calculator, "params 1", "params 2", "params 3")}.to raise_error ArgumentError
        end
      end

      it "valid param" do
        expect(result.send(:calculator, "params 1", hash_data.values[0])).to be_a(String)
      end

      it "write_file" do
        expect(result.send(:write_to_file)).to eq 0
      end

      it "add result to text palin" do
        expect(result.add_result_to_text_palin).to be_a(String)
      end

      it  "write_file_and_show_terminal" do
        expect(result.write_file_and_show_terminal).to be_nil
      end
    end
  end
end