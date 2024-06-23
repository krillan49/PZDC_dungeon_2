require_relative "hero_creator"
require_relative "hero_updator"
require_relative "enemy_creator"
require_relative "hero"
require_relative "skills"
require_relative "enemyes"
require_relative "weapons"
require_relative "loot"
require_relative "menues"
require_relative "info_block"
require_relative "arts"



@hero = HeroCreator.new.create_new_hero # Создание нового персонажа


# Основной игровой блок ===============================================================================================
leveling = 0
while true

  HeroUpdator.new(@hero).spend_stat_points # распределение очков характеристик
  HeroUpdator.new(@hero).spend_skill_points # распределение очков навыков  (тут вызывается старое меню, потом доделать)

  # InfoBlock.hero_stats_info(@hero)
  # Панель характеристик персонажа
  puts InfoBlock.hero_name_level_exp(@hero)
  Menu.new(:character_stats, @hero).display
  puts InfoBlock.character_skills(@hero)

  #---------------------------------------------------------------------------------

  @hero.use_camp_skill # Навык Первая помощь
  @hero.rest # пассивное восстановления жизней и маны между боями

  #--------------------------------------------------------------------------------------------------------------

  print 'Чтобы начать следующий бой нажмите Enter'
  gets
  puts "++++++++++++++++++++++++++++++++++++++ Бой #{leveling + 1} +++++++++++++++++++++++++++++++++++++++++++++++++"

  @enemy = EnemyCreator.new(leveling).create_new_enemy # Назначение противника

  # InfoBlock.enemy_start_stats_info(@enemy)
  puts InfoBlock.enemy_name(@enemy)
  Menu.new(:character_stats, @enemy).display

  # Ход боя ===============================================================================================
  run = false
  lap = 1 # номер хода

  while @enemy.hp > 0 and run == false

    puts "====================================== ХОД #{lap} ============================================"

    # Расчет базового урона----------------------------------------------------------------------------------------
    damage_pl = rand(@hero.min_dmg..@hero.max_dmg)

    damage_en = rand(@enemy.min_dmg..@enemy.max_dmg)
    #----------------------------------------------------------------------------------------------------------

    # Выбор вида атаки ------------------------------------------------------------------------------------
    cant_do = 0
    while cant_do == 0
      cant_do += 1
      print 'Атакуйте! 1.По телу(B) 2.По голове(H) 3.По ногам(L) 4.Навык(S) '
      target_pl = gets.strip.upcase
      target_name_pl = "по телу"
      case target_pl
      when 'H'
        damage_pl *= 1.5
        accuracy_action_pl = @hero.accuracy * 0.7
        target_name_pl = "по голове"
      when 'L'
        damage_pl *= 0.7
        accuracy_action_pl = @hero.accuracy * 1.5
        target_name_pl = "по ногам"
      when 'S'
        if @hero.mp >= @hero.active_skill.mp_cost
          damage_pl *= @hero.active_skill.damage_mod
          accuracy_action_pl = @hero.accuracy * @hero.active_skill.accuracy_mod
          target_name_pl = @hero.active_skill.name
          @hero.mp -= @hero.active_skill.mp_cost
        else
          puts "Недостаточно маны на #{@hero.active_skill.name}"
          cant_do -= 1
        end
      else
        accuracy_action_pl = @hero.accuracy
      end
    end
    # -----------------------------------------------------------------------------------------------------

    # Направление атаки бота ----------------------------------------------------------------------------
    target_en = rand(1..10)
    name_target_en = "по телу"
    if target_en >= 1 and target_en <= 3
      damage_en *= 1.5
      accurasy_action_en = @enemy.accuracy * 0.7
      name_target_en = "по голове"
    elsif target_en >= 4 and target_en <= 6
      damage_en *= 0.7
      accurasy_action_en = @enemy.accuracy * 1.5
      name_target_en = "по ногам"
    else
      accurasy_action_en = @enemy.accuracy
    end
    #-----------------------------------------------------------------------------------------------------------
    puts '-----------------------------------------------------------------------------------------'

    # Расчет блока щитом --------------------------------------------------------------------------------------------
    chanse_block_pl = rand(1..100)
    if @hero.block_chance >= chanse_block_pl
      damage_en /= @hero.block_power_coeff
    end

    chanse_block_en = rand(1..100)
    if @enemy.block_chance >= chanse_block_en
      damage_pl /= @enemy.block_power_coeff
    end
    # ---------------------------------------------------------------------------------------------------------------

    # Расчет итогового урона-----------------------------------------------------------------------------------------
    damage_pl -= @enemy.armor
    if damage_pl < 0
      damage_pl = 0
    end

    damage_en -= @hero.armor
    if damage_en < 0
      damage_en = 0
    end
    #----------------------------------------------------------------------------------------------------------------

    # Расчет попадания/промаха и проведения атак и навыков -----------------------------------------------------
    if accuracy_action_pl >= rand(1..100)
      puts "#{@enemy.name} заблокировал #{@enemy.block_power_in_percents}% урона" if @enemy.block_chance >= chanse_block_en
      @enemy.hp -= damage_pl
      puts "Вы нанесли #{damage_pl.round} урона #{target_name_pl}"
      hit_miss_pl = 1
    else
      puts "Вы промахнулись #{target_name_pl}"
      hit_miss_pl = 0
    end

    case @hero.passive_skill.name
    when "Ошеломление"
      if hit_miss_pl == 1 and damage_pl * @hero.passive_skill.accuracy_reduce_coef > (@enemy.hp + damage_pl) / 2 # прибавляется дамаг который отнялся выше
        accurasy_action_en *= 0.1*rand(1..9)
        puts "атака ошеломила врага, уменьшив его точность до #{(@enemy.accuracy * 0.1 * rand(1..9)).round}"
      end
    when "Концентрация"
      if hit_miss_pl == 1 and @hero.passive_skill.damage_bonus > 0
        damage_bonus = @hero.passive_skill.damage_bonus # чтобы в след 2х строках был одинаковый
        @enemy.hp -= damage_bonus
        puts "дополнительный урон от концентрации #{damage_bonus.round(1)}"
      end
    end

    if accurasy_action_en >= rand(1..100)
      puts "Вы заблокировали #{@hero.block_power_in_percents}% урона" if @hero.block_chance >= chanse_block_pl
      @hero.hp -= damage_en
      puts "#{@enemy.name} нанес #{damage_en.round} урона #{name_target_en}"
      hit_miss_en = 1
    else
      puts "#{@enemy.name} промахнулся #{name_target_en}"
      hit_miss_en = 0
    end
    #------------------------------------------------------------------------------------------------------------------

    @hero.regeneration_hp_mp # регенерация

    # Результат обмена ударами --------------------------------------------------------------------------------
    if @hero.hp > 0 and @enemy.hp > 0
      puts "У вас осталось #{@hero.hp.round}/#{@hero.hp_max} жизней и #{@hero.mp.round}/#{@hero.mp_max} выносливости, у #{@enemy.name}а осталось #{@enemy.hp.round} жизней."
    elsif @hero.hp > 0 and @enemy.hp <= 0
      puts "У вас осталось #{@hero.hp.round}/#{@hero.hp_max} жизней и #{@hero.mp.round}/#{@hero.mp_max} выносливости, у #{@enemy.name}а осталось #{@enemy.hp.round} жизней."
      puts "#{@enemy.name} убит, победа!!!"
    elsif @hero.hp <= 0
      puts "Ты убит - слабак!"
      Art.display_art(:game_over)
      exit
    end
    #------------------------------------------------------------------------------------------------------------------

    # Побег ---------------------------------------------------------------------------------------------------
    if @hero.hp < (@hero.hp_max * 0.15) and @hero.hp > 0 and @enemy.hp > 0
      print 'Ты на пороге смерти. Чтобы убежать введи Y : '
      run_select = gets.strip.upcase
      if run_select == 'Y'
        run_chance = rand(0..2)
        if run_chance >= 1
          puts "Сбежал ссыкло, штраф 5 опыта"
          @hero.exp -= 5
          run = true
        else
          @hero.hp -= damage_en
          puts "Не удалось убежать #{@enemy.name} нанес #{damage_en.round} урона"
          if @hero.hp <= 0
            puts "Ты убит - трусливая псина!"
            Art.display_art(:game_over)
            exit
          end
          run = false
        end
      end
    end
    #-----------------------------------------------------------------------------------------------------------------

    lap += 1 # номер хода

  end
  #===================================================================================================================

  puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

  # Сбор лута-----------------------------------------------------------------------------------------------------
  if run == false
    EnemyLoot.new(@hero, @enemy).looting
    FieldLoot.new(@hero).looting
    SecretLoot.new(@hero).looting
  end
  #-------------------------------------------------------------------------------------------------------------

  @hero.add_exp_and_hero_level_up(@enemy.exp_gived) # Получение опыта и очков

  puts '-------------------------------------------------------------------------------------------------'
  leveling += 1
end
#====================================================================================================================












#
