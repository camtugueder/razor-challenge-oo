RSpec.describe ScheduleCalculator do
  context "when calculating the update schedule" do
    let(:shows_to_update) { [1, 2, 3, 4] }  # Simulated IDs of shows to update

    it "calculates the schedule correctly for less than or equal to 240 shows" do
      calculator = ScheduleCalculator.new(shows_to_update)
      schedule = calculator.calculate
      expected_schedule = {1 => 0, 2 => 15, 3 => 30, 4 => 45}  # Example of expected schedule
      expect(schedule).to eq(expected_schedule)
    end

    it "calculates the schedule correctly for more than 240 shows" do
      lots_of_shows = (1..500).to_a  # Simulate a scenario with many shows
      calculator = ScheduleCalculator.new(lots_of_shows)
      schedule = calculator.calculate
      expect(schedule.keys).to match_array(lots_of_shows)

      # Check that the spacing between consecutive shows is consistent
      sorted_times = schedule.values.sort
      expected_interval = 3600.0 / lots_of_shows.size
      sorted_times.each_cons(2) do |a, b|
        expect(b - a).to be_within(0.1).of(expected_interval)
      end

      # Check that the schedule covers the entire time window
      expect(sorted_times.first).to be >= 0
      expect(sorted_times.last).to be <= 3600
    end
  end
end
