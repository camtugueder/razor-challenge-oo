RSpec.describe Scheduler do
  before do
    # Seed database
    File.read(example_file).each_line do |line|
      id, quantity, last_update = line.split(",")
      Show.create!(id: id, quantity: quantity, last_update: last_update)
    end
  end

  context "example 1", vcr: { cassette_name: "example1" } do
    let(:example_file) { "spec/fixtures/example1.txt" }
    let(:needs_updating) { [1, 2] }

    it "finds the IDs that need updating" do
      result = [] # replace this with your result
      expect(result).to match_array needs_updating
    end

    it "creates the update schedule" do
      scheduled = {} # replace this with your schedule
      expect(scheduled).to eq({}) # replace this hash with the correct schedule
    end
  end

  context "example 2", vcr: { cassette_name: "example2" } do
    let(:example_file) { "spec/fixtures/example2.txt" }
    let(:needs_updating) { [2, 4] }

    it "finds the IDs that need updating"

    it "creates the update schedule"
  end

  context "example 3", vcr: { cassette_name: "example3" } do
    let(:example_file) { "spec/fixtures/example3.txt" }
    # These are the show IDs that need updating
    let(:needs_updating) { File.read("spec/fixtures/example3-updates.txt").split.map(&:to_i) }

    it "finds the IDs that need updating"

    it "creates the update schedule"
  end
end
