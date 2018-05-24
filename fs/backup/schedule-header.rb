require 'shellwords'

%i(BUNDLE_APP_CONFIG BUNDLE_BIN BUNDLE_PATH BUNDLE_SILENCE_ROOT_WARNING GEM_HOME PATH).each do |env_var|
  env env_var, ENV[env_var.to_s]
end

set :job_template, nil
set :output, standard: '/var/log/cron.log', error: '/var/log/cron.log'

def perform_backup trigger, options = {}
  environment = options.fetch :environment, {}
  export_environment = environment.empty? ? '' : "export#{environment.reduce(''){ |memo,(k,v)| memo << " #{k}=#{Shellwords.shellescape v}" }} && "
  command "#{export_environment} /usr/local/bundle/bin/backup perform --no-logfile --root-path /backup --config-file /backup/config.rb -t #{trigger}"
end

