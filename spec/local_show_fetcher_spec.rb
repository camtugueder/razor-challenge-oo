require 'activerecord-import'

RSpec.describe LocalShowFetcher do
  context "when fetching shows that need updates" do
    def setup_database_records(example_file)
      shows = []
      File.read(example_file).each_line do |line|
        id, quantity, last_update = line.split(",")
        shows << Show.new(id: id, quantity: quantity, last_update: last_update)
      end
      Show.import shows
    end

    it "fetches shows older than one hour or never updated for example 1" do
      setup_database_records("spec/fixtures/example1.txt")
      fetched_shows = LocalShowFetcher.fetch_local_update_candidates
      # Assuming fetched_shows returns a Hash with IDs as keys
      expect(fetched_shows.keys).to eq([1, 2])  # IDs from your fixture
    end

    it "fetches shows older than one hour or never updated for example 2" do
      setup_database_records("spec/fixtures/example2.txt")
      fetched_shows = LocalShowFetcher.fetch_local_update_candidates
      expect(fetched_shows.keys).to eq([2, 3, 4])  # IDs from your fixture
    end

    it "fetches shows older than one hour or never updated for example 3" do
      setup_database_records("spec/fixtures/example3.txt")
      fetched_shows = LocalShowFetcher.fetch_local_update_candidates
      expected_ids = File.read("spec/fixtures/example3-update-candidates.txt").split.map(&:to_i)
      expect(fetched_shows.keys.sort).to eq(expected_ids.sort)
    end
  end
end

