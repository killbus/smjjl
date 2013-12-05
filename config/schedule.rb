set :output, "log/cron_log.log"

# 抓取id
every :day, :at => '1:00am', :roles => [:app] do
  rake "daemon:get_id"
end

# 更新内容
every :day, :at => '4:00am', :roles => [:app] do
  rake "daemon:update_content"
end

# 抓取价格
every '0 8,14,20 * * *' do
  rake "daemon:update_price"
end