# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# LoggingConfig
Rails.logger = Logger.new(STDOUT)
Rails.logger.level = :info
Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"
Rails.logger.formatter = proc do | severity, time, progname, msg | 
    "#{time}, #{severity}: #{msg} \n"
end