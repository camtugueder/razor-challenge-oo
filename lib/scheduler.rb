class Scheduler
  attr_reader :shows_to_update, :show_updater, :schedule_calculator

  def initialize(local_show_fetcher, remote_show_fetcher, show_updater, schedule_calculator)
    @local_show_fetcher = local_show_fetcher
    @remote_show_fetcher = remote_show_fetcher
    @show_updater = show_updater
    @schedule_calculator = schedule_calculator
    fetch_shows_to_update
  end

  def fetch_shows_to_update
    local_shows = @local_show_fetcher.fetch_local_update_candidates
    remote_shows = @remote_show_fetcher.fetch_data
    @shows_to_update = @show_updater.new(local_shows, remote_shows).shows_to_update
  end

  def schedule_show_updates
    @schedule_calculator.new(@shows_to_update).calculate
  end
end