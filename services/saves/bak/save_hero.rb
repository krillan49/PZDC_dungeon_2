class SaveHero
  PATH = 'saves/hero_in_run/'
  OPTIONS_FILE = '0_options.yml'
  DEFAULT_OPTIONS = { 'n' => 0, 'names' => [], 'ns' => [], 'file_names' => [] }

  def initialize(hero, leveling)
    @hero = hero
    @leveling = leveling
    @options = load_or_create_options()
    @n = @options['n']
    @file_name = hero_exist?() ? old_file_name() : "#{@n}--#{hero.name}--.yml"
  end

  def save
    update_options() unless hero_exist?()
    create_hero_file()
    true
  end

  def hero_exist?
    @options['names'].include?(@hero.name)
  end

  private

  def load_or_create_options
    if RubyVersionFixHelper.file_exists?("#{PATH}#{OPTIONS_FILE}") # File::exists?("#{PATH}#{OPTIONS_FILE}")
      YAML.safe_load_file("#{PATH}#{OPTIONS_FILE}")
    else
      File.write("#{PATH}#{OPTIONS_FILE}", {}.to_yaml)
      DEFAULT_OPTIONS
    end
  end

  def old_file_name
    @options['file_names'].find{|file_name| file_name.split('--')[1] == @hero.name}
  end

  def update_options
    @options['n'] = @n + 1
    @options['names'].push(@hero.name)
    @options['ns'].push(@n)
    @options['file_names'].push(@file_name)
    File.write("#{PATH}#{OPTIONS_FILE}", @options.to_yaml)
  end

  def create_hero_file
    File.write("#{PATH}#{@file_name}", new_record().to_yaml)
  end

  def new_record
    {
      'hero_create' => {
        'name' => @hero.name,
        'background' => @hero.background
      },
      'hero_stats' => {
        'hp' => @hero.hp, 'hp_max' => @hero.hp_max, 'regen_hp_base' => @hero.regen_hp_base,
        'mp' => @hero.mp, 'mp_max' => @hero.mp_max, 'regen_mp_base' => @hero.regen_mp_base,
        'min_dmg_base' => @hero.min_dmg_base, 'max_dmg_base' => @hero.max_dmg_base,
        'accuracy_base' => @hero.accuracy_base,
        'armor_base' => @hero.armor_base,
        'exp' => @hero.exp, 'lvl' => @hero.lvl,
        'stat_points' => @hero.stat_points, 'skill_points' => @hero.skill_points
      },
      'hero_skills' => {
        'active_skill' => {
          'code' => @hero.active_skill.code,
          'lvl' => @hero.active_skill.lvl
        },
        'passive_skill' => {
          'code' => @hero.passive_skill.code,
          'lvl' => @hero.passive_skill.lvl
        },
        'camp_skill' => {
          'code' => @hero.camp_skill.code,
          'lvl' => @hero.camp_skill.lvl
        }
      },
      'hero_ammunition' => {
        'weapon' => @hero.weapon.code,
        'body_armor' => @hero.body_armor.code,
        'head_armor' => @hero.head_armor.code,
        'arms_armor' => @hero.arms_armor.code,
        'shield' => @hero.shield.code
      },
      'leveling' => @leveling
    }
  end

end















#
