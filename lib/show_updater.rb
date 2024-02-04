# frozen_string_literal: true

class ShowUpdater
  def initialize(local_shows, remote_shows)
    @local_shows = local_shows
    @remote_shows = remote_shows
  end

  def shows_to_update
    @remote_shows.each_with_object([]) do |show, array|
      local_show = @local_shows[show[:id]]
      array << show[:id] if local_show && (!local_show.last_update || local_show.quantity != show[:quantity])
    end
  end
end
