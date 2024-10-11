require 'yaml'

config = ["helpers", "engines", "renderers", "services", "controllers", "models"]

config.each do |path|
  Dir.glob("#{path}/**/*.rb").each do |file|
   require_relative file
  end
end


Main.new.start_game
