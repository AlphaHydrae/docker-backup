require 'shellwords'

set :job_template, nil
set :output, standard: '/var/log/backup.log', error: '/var/log/backup.log'

def perform_backup trigger, options = {}
  environment = options.fetch :environment, {}
  export_environment = environment.empty? ? '' : "export#{environment.reduce(''){ |memo,(k,v)| memo << " #{k}=#{Shellwords.shellescape v}" }} && "
  command "#{export_environment} /usr/local/bin/with-contenv.sh /usr/local/bundle/bin/backup perform --no-logfile --root-path /backup --config-file /backup/config.rb -t #{trigger}"
end

