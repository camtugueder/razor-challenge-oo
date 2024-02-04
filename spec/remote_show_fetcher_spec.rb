RSpec.describe RemoteShowFetcher do
  context "when fetching data from remote API" do
    it "fetches and parses the data correctly for example 1" do
      VCR.use_cassette("example1") do
        data = RemoteShowFetcher.fetch_data
        expect(data).to be_a(Array)
        expected_data = [
          {id: 1, quantity: 15},
          {id: 2, quantity: 3},
          {id: 3, quantity: 40},
          {id: 4, quantity: 22}
        ]

        expect(data).to match_array(expected_data)
      end
    end
  end
end