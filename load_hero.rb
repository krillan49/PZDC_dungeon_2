require 'yaml'

class LoadHero
  PATH = 'save/'
  OPTIONS_FILE = '0_options.yml'

  attr_reader :hero, :leveling

  def initialize
    @options = YAML.safe_load_file("#{PATH}#{OPTIONS_FILE}") if File::exists?("#{PATH}#{OPTIONS_FILE}")
  end

  def load
    if @options
      puts 'Выберите героя'
      hero_choose()
    else
      puts 'Нет сохраненных героев'
    end
  end

  private

  def hero_choose
    @options['names'].each.with_index(1) do |i, name|
      puts "№#{i} #{name}"
    end
    print "Введите номер или имя персонажа "
    input = gets.strip
    if /^\d+$/ === input
      
    else
    end
  end

end














#
