RSpec.describe ShowUpdater do
  context "when comparing local and remote shows" do
    let(:local_shows) { {1 => Show.new(id: 1, quantity: 10, last_update: 3600), 2 => Show.new(id: 2, quantity: 20, last_update: 3600)} }
    let(:remote_shows) { [{id: 1, quantity: 10}, {id: 2, quantity: 15}] }  # Simulated data from remote API

    it "identifies shows that need updating based on quantity" do
      updater = ShowUpdater.new(local_shows, remote_shows)
      result = updater.shows_to_update
      expect(result).to match_array [2]  # Only show with ID 2 needs updating
    end

    it "identifies shows that need updating based on last update" do
      # Modify one local show to have a different last_update value
      local_shows[1].last_update = nil
      updater = ShowUpdater.new(local_shows, remote_shows)
      result = updater.shows_to_update
      expect(result).to match_array [1, 2]  # Now ID 1 also needs updating because it has no last_update
    end
  end
end