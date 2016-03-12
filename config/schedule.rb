require "tzinfo"

set :output, 'log/cron.log'

def local(time)
  TZInfo::Timezone.get("Asia/Taipei").local_to_utc(Time.parse(time))
end

every 1.day, :at => local("8:05 pm") do
  rake "slot:generate"
end
