require 'shellwords'

set :job_template, nil
set :output, standard: '/var/log/backup.log', error: '/var/log/backup.log'

def perform_backup trigger, options = {}
  data_path = ENV.fetch 'BACKUP_DATA_PATH', '/var/lib/backups'
  tmp_path = ENV.fetch 'BACKUP_TMP_PATH', '/tmp/backup'
  command "/usr/local/bin/with-contenv.sh /usr/local/bundle/bin/backup perform --no-logfile --config-file /backup/config.rb --data-path #{Shellwords.shellescape data_path} --tmp-path #{Shellwords.shellescape tmp_path} -t #{trigger}"
end

