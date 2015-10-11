require 'active_support/time'
Time.zone = 'UTC'

every 1.day, :at => Time.zone.parse('12:00pm') do
  runner 'CalculateScoresJob.perform_later'
end
