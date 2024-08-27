class LoadHeroInRun
  PATH = 'saves/'
  HERO_FILE = 'hero_in_run.yml'

  attr_reader :hero, :leveling

  def initialize
    if RubyVersionFixHelper.file_exists?("#{PATH}#{HERO_FILE}") # File::exists?("#{PATH}#{HERO_FILE}")
      @hero_data = YAML.safe_load_file("#{PATH}#{HERO_FILE}")
    end
    @messages = LoadHeroMessage.new
  end

  def load
    if @hero_data
      choose_hero()
    else
      @messages.main = 'No hero saved. Press Enter to continue'
      @messages.heroes = []
      display_with_confirm_and_change_screen()
    end
  end

  private

  def choose_hero
    hero_recreate()
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
    # add dungeon_name
    @hero.dungeon_name = @hero_data['dungeon_name']
    # add leveling
    @leveling = @hero_data['leveling']
    # add camp_loot
    @hero_data['camp_loot'].each do |loot_type, value|
      @hero.send "#{loot_type}=", value
    end
    @hero.ingredients = @hero_data['ingredients']
  end

  def display_with_confirm_and_change_screen
    MainRenderer.new(:load_hero_screen, entity: @messages).display
    gets
  end

end












#
