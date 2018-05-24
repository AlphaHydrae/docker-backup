# Whenever Configuration
# Documentation: https://github.com/javan/whenever
every :minute do
  perform_backup :system, environment: { FOO: 'bar', BAZ: 'qux' }
end
