class LoadHeroInRun
  PATH = 'saves/'
  HERO_FILE = 'hero_in_run.yml'

  attr_reader :hero

  def initialize
    if RubyVersionFixHelper.file_exists?("#{PATH}#{HERO_FILE}") # File::exists?("#{PATH}#{HERO_FILE}")
      @hero_data = YAML.safe_load_file("#{PATH}#{HERO_FILE}")
    end
  end

  def load
    if @hero_data
      choose_hero()
    else
      MainRenderer.new(:load_no_hero_screen).display
      gets
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
    # add ammunition and enhance
    @hero_data['hero_ammunition'].each do |ammunition_type, data|
      # add ammunition
      ammunition_code = data['code']
      ammunition_obj = AmmunitionCreator.create(ammunition_type, ammunition_code)
      @hero.send "#{ammunition_type}=", ammunition_obj
      # add enhance
      enhance_code = data['enhance_code']
      if enhance_code != ''
        recipe = OccultLibraryRecipe.new(enhance_code)
        OccultLibraryEnhanceService.new(@hero, ammunition_obj, ammunition_type, recipe).ammunition_enhance
      end
    end
    # add other
    @hero.dungeon_name = @hero_data['dungeon_name']
    @hero.dungeon_part_number = @hero_data['dungeon_part_number']
    @hero.leveling = @hero_data['leveling']
    # add camp_loot
    @hero_data['camp_loot'].each do |loot_type, value|
      @hero.send "#{loot_type}=", value
    end
    @hero.ingredients = @hero_data['ingredients']
    @hero.events_data = @hero_data['events_data']
  end

end












#
