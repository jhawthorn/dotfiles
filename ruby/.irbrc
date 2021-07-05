if defined?(ActiveRecord)
  # for rails 3
  require 'logger'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

#begin
#  unless ENV['NO_PRY']
#    require 'pry'
#    Pry.start
#    exit
#  end
#rescue LoadError
#end

