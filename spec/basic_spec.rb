EXPECTED_OUTPUT = <<-OUTPUT
  one
  two
OUTPUT

describe Formatador do
  describe "::display_line" do
    it "should display lines with some indentation" do
      results = capture(:stdout) do
        Formatador.display_line('Formatador')
      end
      expect(results).to eq "  Formatador\n"
    end
  end

  describe "::display_lines" do
    it "should present an array of strings as a sequence of lines" do
      results = capture(:stdout) do
        Formatador.display_lines(['one', 'two'])
      end
      expect(results).to eq EXPECTED_OUTPUT
    end
  end

  describe "::indent" do
    it "should indent calls to Formatador functions from within the proc passed to indent" do
      results = capture(:stdout) do
        Formatador.indent do
          Formatador.display_line('Formatador')
        end
      end
      expect(results).to eq "    Formatador\n"
    end
  end
end
