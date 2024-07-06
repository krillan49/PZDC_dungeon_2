class LoadHero
  PATH = 'saves/'
  OPTIONS_FILE = '0_options.yml'

  attr_reader :hero, :leveling

  def initialize
    @options = YAML.safe_load_file("#{PATH}#{OPTIONS_FILE}") if File::exists?("#{PATH}#{OPTIONS_FILE}")
  end

  def load
    if @options && @options['file_names'].length > 0
      puts 'Выберите героя'
      choose_hero()
    else
      puts 'Нет сохраненных героев'
    end
  end

  private

  def choose_hero
    @options['names'].each.with_index(1) do |name, i|
      puts "№ #{i} #{name}"
    end
    print "Введите номер или имя персонажа "
    input = gets.strip
    @file_name = /^\d+$/ === input ? choose_hero_by_number(input.to_i-1) : choose_hero_by_name(input)
    if !@file_name
      puts 'Такого героя не существует, попробуйте еще раз'
    else
      load_hero_data()
      hero_recreate()
    end
  end

  def choose_hero_by_number(n)
    i = @options['ns'].index(n)
    i ? @options['file_names'][i] : nil
  end

  def choose_hero_by_name(name)
    i = @options['names'].index(name)
    i ? @options['file_names'][i] : nil
  end

  def load_hero_data
    @hero_data = YAML.safe_load_file("#{PATH}#{@file_name}")
  end

  def hero_recreate
    # create hero
    @hero = Hero.new(@hero_data['hero_create']['name'], @hero_data['hero_create']['background'])
    # add stats
    @hero_data['hero_stats'].each{ |method, value| @hero.send("#{method}=", value) }
    # add skills
    @hero_data['hero_skills'].each do |slill_type, params|
      @hero.send "#{slill_type}=", SkillsCreator.create(params['code'], @hero)
      @hero.send(slill_type).lvl = params['lvl']
    end
    # add ammunition
    @hero_data['hero_ammunition'].each do |ammunition_type, ammunition_name|
      @hero.send "#{ammunition_type}=", AmmunitionCreator.create(ammunition_type, ammunition_name)
    end
    # add leveling
    @leveling = @hero_data['leveling']
  end

end


# require_relative "skills_creator"
# require_relative "ammunition_creator"
# require_relative "hero"
# require_relative "skills"
# require_relative "ammunition"
# load_hero = LoadHero.new
# load_hero.load
# p @hero = load_hero.hero
# p leveling = load_hero.leveling











#
