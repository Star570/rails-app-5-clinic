require "tzinfo"

set :output, 'log/cron.log'

def local(time)
  TZInfo::Timezone.get("Taipei").local_to_utc(Time.parse(time))
end

every 1.day, :at => at: local("8:01 pm") do
  rake "slot:generate"
end
