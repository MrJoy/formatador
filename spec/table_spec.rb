EXPECTED_TABLES=[]
EXPECTED_TABLES << <<-OUTPUT
  +---+
  | [bold]a[/] |
  +---+
  | 1 |
  +---+
  | 2 |
  +---+
OUTPUT

EXPECTED_TABLES << <<-OUTPUT
  +--------+
  | [bold]header[/] |
  +--------+
  +--------+
OUTPUT

EXPECTED_TABLES << <<-OUTPUT
  +--------+
  | [bold]header[/] |
  +--------+
  |        |
  +--------+
OUTPUT

EXPECTED_TABLES << <<-OUTPUT
  +---+------------+
  | [bold]a[/] | [bold]nested.key[/] |
  +---+------------+
  | 1 | value      |
  +---+------------+
OUTPUT

EXPECTED_TABLES << <<-OUTPUT
  +---+-----------------+
  | [bold]a[/] | [bold]nested[/]          |
  +---+-----------------+
  | 1 | {:key=>"value"} |
  +---+-----------------+
OUTPUT
EXPECTED_TABLES << <<-OUTPUT
  +---+--------------+
  | [bold]a[/] | [bold]just.pointed[/] |
  +---+--------------+
  | 1 | value        |
  +---+--------------+
OUTPUT
# This will make sure that our output has escape codes put in...
EXPECTED_TABLES.map! { |str| Formatador.parse(str) }

describe Formatador do
  describe "::display_table" do
    context "when called with: [{:a => 1}, {:a => 2}]" do
      it "should display all rows, with dividers in between and bolded headers" do
        results = capture(:stdout) do
          Formatador.display_table([{:a => 1}, {:a => 2}])
        end
        expect(results).to eq EXPECTED_TABLES[0]
      end
    end

    context "when called with: [], [:header]" do
      it "should show a table with the specified columns, and no rows" do
        results = capture(:stdout) do
          Formatador.display_table([], [:header])
        end
        expect(results).to eq EXPECTED_TABLES[1]
      end
    end

    context "when called with: [{:a => 1}], [:header]" do
      it "should show a table with just the specified columns, and one row (with an empty column)" do
        results = capture(:stdout) do
          Formatador.display_table([{:a => 1}], [:header])
        end
        expect(results).to eq EXPECTED_TABLES[2]
      end
    end

    context "when called with: [{:a => 1, :nested => {:key => 'value'}}], [:header, :'nested.key']" do
      it "should dive into the nested hash for displaying the relevant column" do
        results = capture(:stdout) do
          Formatador.display_table([{:a => 1, :nested => {:key => 'value'}}], [:a, :'nested.key'])
        end
        expect(results).to eq EXPECTED_TABLES[3]
      end
    end

    context "when called with: [{:a => 1, :nested => {:key => 'value'}}]" do
      it "should display the Hash value for the row in a human-friendly manner" do
        results = capture(:stdout) do
          Formatador.display_table([{:a => 1, :nested => {:key => 'value'}}])
        end
        expect(results).to eq EXPECTED_TABLES[4]
      end
    end

    context "when called with: [{:a => 1, 'just.pointed' => :value}]" do
      it "should not get confused when presented with columns that have a period in the name" do
        results = capture(:stdout) do
          Formatador.display_table([{:a => 1, 'just.pointed' => :value}])
        end
        expect(results).to eq EXPECTED_TABLES[5]
      end
    end
  end
end
