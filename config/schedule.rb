env :PATH, ENV['PATH']
set :output, "log/cron_log.log"
set :job_template, "bash -l -c ':job'"

# 抓取id
every :day, :at => '1:00am', :roles => [:master] do
  rake "daemon:get_id"
end

# 更新内容
every :day, :at => '3:00am', :roles => [:master] do
  rake "daemon:update_content"
end

# 抓取价格
every '0 0,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23 * * *', :roles => [:master] do
  rake "daemon:update_price"
end

# 每小时清空log
every '0 * * * *', :roles => [:master] do
  command "cd /www/smjjl && > log/production.log"
end

# 每小时零55分重启worker服务
every '55 * * * *', :roles => [:worker] do
  rake "sidekiq:restart"
end