require "active_record"

class Show < ActiveRecord::Base
  scope :older_than_one_hour, -> { where("last_update >= 3600") }
  scope :never_updated, -> { where(last_update: nil) }
end
