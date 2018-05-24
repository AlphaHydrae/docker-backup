# Backup v5.x Configuration
# (Do not remove the preceding comment, as Backup checks that it is there.)
# Documentation: http://backup.github.io/backup/v4/
Model.new(:system, 'System configuration') do

  archive :system_configuration do |archive|
    archive.add '/etc/'
  end

  store_with Local do |local|
    local.path = '/var/lib/backups/'
    local.keep = 5
  end

  compress_with Gzip

end
