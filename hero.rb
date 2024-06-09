require 'yaml'
require_relative 'weapons'

class Hero
  attr_accessor :name_pl
  attr_reader :background

  attr_accessor :hp_max_pl, :hp_pl, :regen_hp_base_pl
  attr_accessor :mp_max_pl, :mp_pl, :regen_mp_base_pl
  attr_accessor :mindam_base_pl, :maxdam_base_pl
  attr_accessor :accuracy_base_pl
  attr_accessor :armor_base_pl
  attr_accessor :block_pl
  attr_accessor :exp_pl, :lvl_pl
  attr_reader :exp_lvl
  attr_accessor :stat_points, :skill_points

  attr_accessor :weapon, :body_armor, :head_armor, :arms_armor, :shield

  def initialize(background)
    hero = YAML.safe_load_file('data/characters/heroes.yml', symbolize_names: true)[background.to_sym]

    @background = hero[:name]

    @hp_pl = hero[:hp]
    @hp_max_pl = hero[:hp]
    @regen_hp_base_pl = 0

    @mp_pl = hero[:mp]
    @mp_max_pl = hero[:mp]
    @regen_mp_base_pl = 0

    @mindam_base_pl = hero[:min_dmg]
    @maxdam_base_pl = hero[:max_dmg]

    @accuracy_base_pl = hero[:accurasy]

    @armor_base_pl = hero[:armor]

    @exp_pl = 0
    @lvl_pl = 0
    @exp_lvl = [0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200]

    @stat_points = 5
    @skill_points = hero[:skill_points]

    @weapon = Weapon.new(hero[:weapon])
    @body_armor = BodyArmor.new(hero[:body_armor].sample)
    @head_armor = HeadArmor.new(hero[:head_armor].sample)
    @arms_armor = ArmsArmor.new(hero[:arms_armor].sample)
    @shield = Shield.new(hero[:shields].sample)
  end

  # Геттеры - Методы зависимых характеристик:

  def mindam_pl
    @mindam_base_pl + @weapon.min_dmg
  end

  def maxdam_pl
    @maxdam_base_pl + @weapon.max_dmg
  end

  def recovery_hp
    @hp_max_pl * 0.1
  end

  def recovery_mp
    @mp_max_pl * 0.1
  end

  def regen_hp
    @regen_hp_base_pl
  end

  def regen_mp
    @regen_mp_base_pl
  end

  def armor_pl
    @armor_base_pl + @body_armor.armor + @head_armor.armor + @arms_armor.armor + @shield.armor
  end

  def accuracy_pl
    @accuracy_base_pl + @arms_armor.accuracy
  end


  # Методы действий

  def rest # отдых между боями(Восстановления жизней и маны)
    if @hp_pl < @hp_max_pl
      @hp_pl += [recovery_hp(), @hp_max_pl - @hp_pl].min
      puts "Передохнув вы восстанавливаете #{recovery_hp().round} жизней, теперь у вас #{@hp_pl.round}/#{@hp_max_pl} жизней"
    end
    if @mp_pl < @mp_max_pl
      @mp_pl += [recovery_mp(), @mp_max_pl - @mp_pl].min
      puts "Передохнув вы восстанавливаете #{recovery_mp().round} выносливости, теперь у вас #{@mp_pl.round}/#{@mp_max_pl} выносливости"
    end
  end

  def regeneration_hp_mp # регенерация в бою
    if regen_hp() > 0 && @hp_max_pl > @hp_pl
      @hp_pl += [regen_hp(), @hp_max_pl - @hp_pl].min
      puts "Вы регенерируете #{regen_hp()} жизней, теперь у вас #{@hp_pl.round}/#{@hp_max_pl} жизней"
    end
    if regen_mp() > 0 && @mp_max_pl > @mp_pl
      @mp_pl += [regen_mp(), @mp_max_pl - @mp_pl].min
      puts "Вы регенерируете #{regen_mp()} выносливости, теперь у вас #{@mp_pl.round}/#{@mp_max_pl} выносливости"
    end
  end

  def add_exp_and_hero_level_up(added_exp) # получения нового опыта, уровня, очков характеристик и наыков
    @exp_pl += added_exp
    puts "Вы получили #{added_exp} опыта. Теперь у вас #{@exp_pl} опыта"
    @exp_lvl.each.with_index do |exp_val, i|
      if @exp_pl >= exp_val && @lvl_pl < i
        new_levels = i - @lvl_pl
        @stat_points += new_levels
        @skill_points += new_levels
        @lvl_pl += new_levels
        puts "Вы получили новый уровень, теперь ваш уровень #{@lvl_pl}й"
        puts "Вы получили #{new_levels} очков характеристик и #{new_levels} очков навыков"
        puts "У вас теперь #{@stat_points} очков характеристик и #{@skill_points} очков навыков"
      end
    end
  end
end


# ["drunk", "watchman", "thief", "worker", "student"].each do |background|
#   p Hero.new(background)
#   p '================================'
# end
















#
