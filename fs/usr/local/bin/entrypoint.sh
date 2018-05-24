#!/usr/bin/env sh

mkfifo /var/log/cron.log
tail -f /var/log/cron.log &

schedule_header_file=/backup/schedule-header.rb
schedule_file=/backup/schedule.rb
full_schedule_file=/backup/full-schedule.rb
if test -f "$full_schedule_file"; then
  echo Using schedule file "$full_schedule_file"
else
  echo Concatenating $schedule_header_file and $schedule_file to $full_schedule_file
  cat "$schedule_header_file" "$schedule_file" > "$full_schedule_file"
fi

whenever -f "$full_schedule_file" -w "$full_schedule_file"
crontab -l

/usr/sbin/cron -f
