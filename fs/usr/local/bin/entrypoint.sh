#!/usr/bin/env sh
set -e

mkfifo /var/log/backup.log
tail -f /var/log/backup.log &

/usr/local/bin/dumpenv.sh BUNDLE_APP_CONFIG BUNDLE_PATH BUNDLE_SILENCE_ROOT_WARNING GEM_HOME PATH $BACKUP_DUMPENV

schedule_header_file=/backup/schedule-header.rb
schedule_file=/backup/schedule.rb
full_schedule_file=/backup/full-schedule.rb
if test -f "$full_schedule_file"; then
  echo Using schedule file "$full_schedule_file" > /var/log/backup.log
else
  echo Concatenating $schedule_header_file and $schedule_file to $full_schedule_file > /var/log/backup.log
  cat "$schedule_header_file" "$schedule_file" > "$full_schedule_file"
fi

whenever -f "$full_schedule_file" -w "$full_schedule_file" > /var/log/backup.log
crontab -l > /var/log/backup.log

/usr/sbin/cron -f
