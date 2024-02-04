class Scheduler
  attr_reader :shows_to_update
  def initialize
    local_shows = LocalShowFetcher.fetch_local_update_candidates
    remote_shows = RemoteShowFetcher.fetch_data
    @shows_to_update = ShowUpdater.new(local_shows, remote_shows).shows_to_update
  end

  def schedule_show_updates
    ScheduleCalculator.new(@shows_to_update).calculate
  end
end
