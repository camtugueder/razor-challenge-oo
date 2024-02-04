# frozen_string_literal: true

class ScheduleCalculator
  def initialize(shows_to_update)
    @shows_to_update = shows_to_update
  end

  def calculate
    count = @shows_to_update.count
    return @shows_to_update.each_with_index.map {|show, i| [show,i*15]}.to_h if count <= 240
    offset = 3600.0 / count
    @shows_to_update.each_with_index.map {|show, i| [show,i*offset]}.to_h
  end
end
