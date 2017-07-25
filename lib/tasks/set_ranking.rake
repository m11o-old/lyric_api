ACCESS_LOGS_SQL = "SELECT music_info_id, count(*) AS music_info_count FROM access_logs WHERE access_at = '__DELIMITER__' GROUP BY music_info_id ORDER BY music_info_count DESC;"

ACCESS_LOGS_DELETE = %q(DELETE FROM access_logs WHERE access_at = "__DELIMITER__";)

def logger
  Rails.logger
end

desc "引数に与えられた期間の検索されたアクセス数のランキングを算出, [term]=>day, week, month"
task :set_ranking, ['term'] => :environment do |task, args|
  Rails.logger = Logger.new Rails.root.join('log', "#{File.basename(__FILE__, '.*')}.log")

  date = Time.zone.now - 1.day

  term = if args['term'].present?
    args['term']
  else
    'day'
  end
  if 'day' == term
    con = AccessLog.connection
    ActiveRecord::Base.transaction do
      delimiter = date.strftime '%Y/%m/%d %H:%M:%S'
      command   = ACCESS_LOGS_SQL.gsub '__DELIMITER__', delimiter

      access_logs = con.select_all command
      count = 0
      ranking = Ranking.new
      ranking.ranked_at = date
      access_logs.each do |row|
        ranking.send "music_info_id_on_rank#{count}=", row['music_info_id']
        count += 1
      end
      ranking.term = "day"
      ranking.ranked_at = date
      ranking.save!

      command = ACCESS_LOGS_DELETE.gsub '__DELIMITER__', delimiter
      con.execute command
    end
  elsif 'week' == term
    today = Time.zone.now - 1.day
    last_day = today - 1.week
    ranking = Ranking.where ranked_at <= today, ranked_at > last_day
    raise if ranking.blank?
    #途中
  elsif 'month' == term
    #途中
  else
  
  end
end
