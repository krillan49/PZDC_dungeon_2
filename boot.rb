require 'yaml'

config = ["helpers", "engines", "renderers", "services", "controllers", "models"]

config_ignore = ['test__', '/bak/']

config.each do |path|
  Dir.glob("#{path}/**/*.rb").each do |file|
    require_relative file unless config_ignore.any?{|str| file.include?(str)}
  end
end


Main.new.start_game
