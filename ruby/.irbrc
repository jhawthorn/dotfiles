if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  # for rails 2
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
elsif defined?(Rails)
  # for rails 3
  require 'logger'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
