# frozen_string_literal: true


class LocalShowFetcher
  def self.fetch_local_update_candidates
    older_than_one_hour_shows = Show.unscoped.older_than_one_hour
    never_updated_shows = Show.unscoped.never_updated
    older_than_one_hour_shows.or(never_updated_shows).index_by(&:id)
  end
end
