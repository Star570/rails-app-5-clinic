require "tzinfo"

set :output, 'log/cron.log'

def local(time)
  TZInfo::Timezone.get("Asia/Taipei").local_to_utc(Time.parse(time))
end

every 1.day, :at => local("8:00 am") do
  rake "slot:generate"
end
