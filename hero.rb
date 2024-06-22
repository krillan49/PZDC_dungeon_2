require 'yaml'
require_relative 'weapons'

class Hero
  attr_accessor :name
  attr_reader :background

  attr_accessor :hp_max, :hp, :regen_hp_base
  attr_accessor :mp_max, :mp, :regen_mp_base
  attr_accessor :min_dmg_base, :max_dmg_base
  attr_accessor :accuracy_base
  attr_accessor :armor_base
  # attr_accessor :block
  attr_accessor :exp, :lvl
  attr_reader :exp_lvl
  attr_accessor :stat_points, :skill_points

  attr_accessor :active_skill, :passive_skill, :camp_skill

  attr_accessor :weapon, :body_armor, :head_armor, :arms_armor, :shield

  def initialize(name, background)
    @name = name

    hero = YAML.safe_load_file('data/characters/heroes.yml', symbolize_names: true)[background.to_sym]

    @background = hero[:name]

    @hp = hero[:hp]
    @hp_max = hero[:hp]
    @regen_hp_base = 0

    @mp = hero[:mp]
    @mp_max = hero[:mp]
    @regen_mp_base = 0

    @min_dmg_base = hero[:min_dmg]
    @max_dmg_base = hero[:max_dmg]

    @accuracy_base = hero[:accurasy]

    @armor_base = hero[:armor]

    @exp = 0
    @lvl = 0
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

  def min_dmg
    @min_dmg_base + @weapon.min_dmg
  end

  def max_dmg
    @max_dmg_base + @weapon.max_dmg
  end

  def recovery_hp
    @hp_max * 0.1
  end

  def recovery_mp
    @mp_max * 0.1
  end

  def regen_hp
    @regen_hp_base
  end

  def regen_mp
    @regen_mp_base
  end

  def armor
    @armor_base + @body_armor.armor + @head_armor.armor + @arms_armor.armor + @shield.armor
  end

  def accuracy
    @accuracy_base + @arms_armor.accuracy
  end

  def block_chance
    if @passive_skill.name == "Мастер щита" && @shield.name != "без щита"
      @shield.block_chance + @passive_skill.block_chance_bonus
    else
      @shield.block_chance
    end
  end
  def block_power_coeff
    1 + @hp.to_f / 200
  end
  def block_power_in_percents
    100 - (100 / block_power_coeff()).to_i
  end

  def next_lvl_exp
    @exp_lvl[@lvl + 1]
  end


  # Методы применения навыков

  def use_camp_skill
    if @hp_max - @hp > 0 && @camp_skill.name == "Первая помощь"
      print "У вас #{@hp.round}/#{@hp_max} жизней, хотите использовать навык #{@camp_skill.name}, чтобы восстановить #{@camp_skill.heal_effect.round} жизней за 10 маны? (Y/N) "
      noncombat_choice = gets.strip.upcase
      if @mp >= @camp_skill.mp_cost && noncombat_choice == "Y"
        heal_effect_message = @camp_skill.heal_effect.round
        @hp += @camp_skill.heal_effect
        @mp -= @camp_skill.mp_cost
        puts "Вы восстановили #{heal_effect_message} жизней за #{@camp_skill.mp_cost} маны, теперь у вас #{@hp.round}/#{@hp_max} жизней и #{@mp.round}/#{@mp_max} маны"
      elsif noncombat_choice == "Y"
        puts "Не хватает маны"
      end
    end
  end


  # Методы действий

  def rest # отдых между боями(Восстановления жизней и маны)
    if @hp < @hp_max
      @hp += [recovery_hp(), @hp_max - @hp].min
      puts "Передохнув вы восстанавливаете #{recovery_hp().round} жизней, теперь у вас #{@hp.round}/#{@hp_max} жизней"
    end
    if @mp < @mp_max
      @mp += [recovery_mp(), @mp_max - @mp].min
      puts "Передохнув вы восстанавливаете #{recovery_mp().round} выносливости, теперь у вас #{@mp.round}/#{@mp_max} выносливости"
    end
  end

  def regeneration_hp_mp # регенерация в бою
    if regen_hp() > 0 && @hp_max > @hp
      @hp += [regen_hp(), @hp_max - @hp].min
      puts "Вы регенерируете #{regen_hp()} жизней, теперь у вас #{@hp.round}/#{@hp_max} жизней"
    end
    if regen_mp() > 0 && @mp_max > @mp
      @mp += [regen_mp(), @mp_max - @mp].min
      puts "Вы регенерируете #{regen_mp()} выносливости, теперь у вас #{@mp.round}/#{@mp_max} выносливости"
    end
  end

  def add_exp_and_hero_level_up(added_exp) # получения нового опыта, уровня, очков характеристик и наыков
    @exp += added_exp
    puts "Вы получили #{added_exp} опыта. Теперь у вас #{@exp} опыта"
    @exp_lvl.each.with_index do |exp_val, i|
      if @exp >= exp_val && @lvl < i
        new_levels = i - @lvl
        @stat_points += new_levels
        @skill_points += new_levels
        @lvl += new_levels
        puts "Вы получили новый уровень, теперь ваш уровень #{@lvl}й"
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
