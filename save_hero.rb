require 'yaml'

class SaveHero
  PATH = 'save/'
  OPTIONS_FILE = '0_options.yml'

  def initialize(hero)
    @hero = hero
    options_update()
    @file_name = "#{@n}--#{hero.name}--#{hero.lvl}.yml"
  end

  def save
    File.write("#{PATH}#{OPTIONS_FILE}", {'n' => @n}.to_yaml)
    File.write("#{PATH}#{@file_name}", new_record().to_yaml)

    # cl = YAML.safe_load_file("#{PATH}#{@file_name}", symbolize_names: true)[:passive_skill][:class].new
    # p cl
    # p cl.class
  end

  def options_update()
    unless File::exists?("#{PATH}#{OPTIONS_FILE}")
      File.write("#{PATH}#{OPTIONS_FILE}", default_options().to_yaml)
    end
    @n = YAML.safe_load_file("#{PATH}#{OPTIONS_FILE}", symbolize_names: true)[:n] + 1
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
          'class' => @hero.active_skill.class,
          'lvl' => @hero.active_skill.lvl
        },
        'passive_skill' => {
          'class' => @hero.passive_skill.class,
          'lvl' => @hero.passive_skill.lvl
        },
        'camp_skill' => {
          'class' => @hero.camp_skill.class,
          'lvl' => @hero.camp_skill.lvl
        }
      },
      'hero_ammunition' => {
        'weapon' => @hero.weapon.code,
        'body_armor' => @hero.body_armor.code,
        'head_armor' => @hero.head_armor.code,
        'arms_armor' => @hero.arms_armor.code,
        'shield' => @hero.shield.code
      }
    }
  end

  def default_options
    {
      'n' => 0,
      'names' => {},
      'ns' => {}
    }
  end
end

# require_relative 'hero'
# require_relative "skills"
# hero = Hero.new('Vasya','watchman')
# hero.active_skill = StrongStrike.new
# hero.passive_skill = Concentration.new(hero)
# hero.camp_skill = FirstAid.new(hero)
# SaveHero.new(hero).save















#
