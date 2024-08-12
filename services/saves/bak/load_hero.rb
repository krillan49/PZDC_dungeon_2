class LoadHero
  PATH = 'saves/hero_in_run/'
  OPTIONS_FILE = '0_options.yml'

  attr_reader :hero, :leveling

  def initialize
    @options = YAML.safe_load_file("#{PATH}#{OPTIONS_FILE}") if RubyVersionFixHelper.file_exists?("#{PATH}#{OPTIONS_FILE}") # File::exists?("#{PATH}#{OPTIONS_FILE}")
    @messages = LoadHeroMessage.new
  end

  def load
    if @options && @options['file_names'].length > 0
      @messages.main = 'Choose a hero'
      choose_hero()
    else
      @messages.main = 'No heroes saved. Press Enter to continue'
      @messages.heroes = []
      display_with_confirm_and_change_screen()
    end
  end

  private

  def choose_hero
    @options['names'].each.with_index(1) do |name, i|
      i = '0' + i.to_s if i < 10
      @messages.heroes << "                                            № #{i}     #{name}"
    end
    @messages.main = "Enter the character number or name"
    display_and_change_screen()
    input = gets.strip
    @file_name = /^\d+$/ === input ? choose_hero_by_number(input.to_i-1) : choose_hero_by_name(input)
    if !@file_name
      @messages.main = 'There is no such hero. To continue press Enter'
      @messages.heroes = []
      display_with_confirm_and_change_screen()
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

  def display_and_change_screen
    MainRenderer.new(:load_hero_screen, entity: @messages).display
  end

  def display_with_confirm_and_change_screen
    MainRenderer.new(:load_hero_screen, entity: @messages).display
    gets
  end

end












#
