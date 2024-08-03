class SaveHeroInRun
  PATH = 'saves/'
  HERO_FILE = 'hero_in_run.yml'

  def initialize(hero, leveling)
    @hero = hero
    @leveling = leveling
  end

  def save
    create_hero_file()
    true
  end

  private

  def create_hero_file
    File.write("#{PATH}#{HERO_FILE}", new_record().to_yaml)
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
