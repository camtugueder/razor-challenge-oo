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
  context "when the remote API returns a 500 error" do
    around do |example|
      VCR.turn_off!
      example.run
      VCR.turn_on!
    end
    before do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('https://shows-remote-api.com') { [500, {}, 'Internal Server Error'] }
      end
      Faraday.default_connection = Faraday.new do |builder|
        builder.adapter :test, stubs
      end
    end
    it "handles the error gracefully" do
      expect { RemoteShowFetcher.fetch_data }.not_to raise_error
      data = RemoteShowFetcher.fetch_data
      expect(data).to eq([])
    end
  end
end