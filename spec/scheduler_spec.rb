require 'activerecord-import'

RSpec.describe Scheduler do
  def setup_database_records(example_file)
    shows = []
    File.read(example_file).each_line do |line|
      id, quantity, last_update = line.split(",")
      shows << Show.new(id: id, quantity: quantity, last_update: last_update)
    end
    Show.import shows
  end

  context "when scheduling show updates for example 1", vcr: { cassette_name: "example1" } do
    let(:example_file) { "spec/fixtures/example1.txt" }
    let(:needs_updating) { [1, 2] }
    let(:updates_hash) { { 1 => 0, 2 => 15 } }  # Adjust as needed based on your scheduling logic

    before do
      setup_database_records(example_file)  # Seed the database
    end

    it "orchestrates components to find shows to update and calculate the schedule" do
      scheduler = Scheduler.new
      expect(scheduler.shows_to_update.sort).to eq(needs_updating.sort)
      expect(scheduler.schedule_show_updates).to eq(updates_hash)
    end
  end

  context "when scheduling show updates for example 2", vcr: { cassette_name: "example2" } do
    let(:example_file) { "spec/fixtures/example2.txt" }
    let(:needs_updating) { [2, 4] }
    let(:updates_hash) { { 2 => 0, 4 => 15 } }  # Adjust as needed based on your scheduling logic

    before do
      setup_database_records(example_file)  # Seed the database
    end

    it "orchestrates components to find shows to update and calculate the schedule" do
      scheduler = Scheduler.new
      expect(scheduler.shows_to_update.sort).to eq(needs_updating.sort)
      expect(scheduler.schedule_show_updates).to eq(updates_hash)
    end
  end

  context "when scheduling show updates for example 3", vcr: { cassette_name: "example3" } do
    let(:example_file) { "spec/fixtures/example3.txt" }
    let(:needs_updating) { File.read("spec/fixtures/example3-updates.txt").split.map(&:to_i) }
    let(:updates_hash) { JSON.parse(File.read("spec/fixtures/example3-update-hash.json")).transform_keys(&:to_i) }  # Assuming this file has the correct schedule

    before do
      setup_database_records(example_file)  # Seed the database
    end

    it "orchestrates components to find shows to update and calculate the schedule" do
      scheduler = Scheduler.new
      expect(scheduler.shows_to_update.sort).to eq(needs_updating.sort)
      expect(scheduler.schedule_show_updates).to eq(updates_hash)
    end
  end
end
