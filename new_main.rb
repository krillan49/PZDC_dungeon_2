require_relative "hero"
require_relative "skills"
require_relative "enemyes"
require_relative "weapons"
require_relative "loot"
require_relative "info_block"
require_relative "arts"


#======================================= Методы временные решения =================================================

# Панель характеристик персонажа
def character_panel
  puts '--------------------------------------------------------------------------------------------'
  puts '--------------------------------------------------------------------------------------------'
  puts "#{@hero.name}"
  puts "Уровень #{@hero.lvl} (#{@hero.exp}/#{@hero.exp_lvl[@hero.lvl + 1]})"
  puts "Н А В Ы К И:"
  puts "[акт] #{@hero.active_skill.name} #{@hero.active_skill.description}"
  puts "[пас] #{@hero.passive_skill.name} #{@hero.passive_skill.description}"
  puts "[неб] #{@hero.camp_skill.name} #{@hero.camp_skill.description}"
  puts "С Т А Т Ы:"
  puts "HP #{@hero.hp.round}/#{@hero.hp_max} Реген #{@hero.regen_hp_base} Восстановление #{@hero.recovery_hp.round}"
  puts "MP #{@hero.mp.round}/#{@hero.mp_max} Реген #{@hero.regen_mp_base} Восстановление #{@hero.recovery_mp.round}"
  puts "Урон #{@hero.min_dmg}-#{@hero.max_dmg} (базовый #{@hero.min_dmg_base}-#{@hero.max_dmg_base} + #{@hero.weapon.name} #{@hero.weapon.min_dmg}-#{@hero.weapon.max_dmg})"
  puts "Точность #{@hero.accuracy} (базовая #{@hero.accuracy_base} + #{@hero.arms_armor.name} #{@hero.arms_armor.accuracy})"
  puts "Броня #{@hero.armor} (базовая #{@hero.armor_base} + #{@hero.body_armor.name} #{@hero.body_armor.armor} + #{@hero.head_armor.name} #{@hero.head_armor.armor} + #{@hero.arms_armor.name} #{@hero.arms_armor.armor} + #{@hero.shield.name} #{@hero.shield.armor})"
  puts "Шанс блока #{@hero.block_chance} (#{@hero.shield.name} #{@hero.shield.block_chance}) блокируемый урон #{@hero.block_power_in_percents}%"
  puts '--------------------------------------------------------------------------------------------'
  puts '--------------------------------------------------------------------------------------------'
end

#==================================================================================================================

# Создание персонажа..............................................................................................
puts 'Создание персонажа'
puts '========================'

# Выбор предистории .................................................................................................
print "Выберите предисторию:
Сторож(G) + 30 жизней, Дубинка
Карманник(T) + 5 точности, Ножик
Рабочий(W) + 30 выносливости, Ржавый топорик
Умник(S) + 5 очков навыков, без оружия
"
choose_story_pl = gets.strip.upcase
case choose_story_pl
when 'G'; @hero = Hero.new('watchman')
when 'T'; @hero = Hero.new('thief')
when 'W'; @hero = Hero.new('worker')
when 'S'; @hero = Hero.new('student')
else
  @hero = Hero.new('drunk')
  puts 'Перепутал буквы, ты тупой алкаш -5 жизней -5 выносливости -10 точность'
end

# Выбор имени .................................................................................................
print 'Введите имя персонажа: '
@hero.name = gets.strip

# Выбор стартовых навыков .......................................................................................
puts 'Выберите стартовый активный навык '
print 'Сильный удар(S) Точный удар(A) '
special_choiсe = gets.strip.upcase
while special_choiсe != 'S' and special_choiсe != 'A'
  print 'Введен неверный символ. Попробуйте еще раз. Сильный удар(S) Точный удар(A) '
  special_choiсe = gets.strip.upcase
end
case special_choiсe
when 'S'; @hero.active_skill = StrongStrike.new
when 'A'; @hero.active_skill = PreciseStrike.new
end

puts 'Выберите стартовый пассивный навык '
print 'Ошеломление(D) Концентрация(C) Мастер щита(B) '
passive_choiсe = gets.strip.upcase
while passive_choiсe != 'D' and passive_choiсe != 'C' and passive_choiсe != 'B'
  print 'Неверный символ попробуйте еще раз. Ошеломление(D) Концентрация(C) Мастер щита(B) '
  passive_choiсe = gets.strip.upcase
end
case passive_choiсe
when 'D'; @hero.passive_skill = Dazed.new
when 'C'; @hero.passive_skill = Concentration.new(@hero)
when 'B'; @hero.passive_skill = ShieldMaster.new
end

puts 'Выберите стартовый небоевой навык '
print 'Первая помощь(F) Кладоискатель(T) '
noncombat_choiсe = gets.strip.upcase
while noncombat_choiсe != 'F' and noncombat_choiсe != 'T'
  print 'Введен неверный символ попробуйте еще раз. Первая помощь(F) Кладоискатель(T) '
  noncombat_choiсe = gets.strip.upcase
end
case noncombat_choiсe
when 'F'; @hero.camp_skill = FirstAid.new(@hero)
when 'T'; @hero.camp_skill = TreasureHunter.new
end
#--------------------------------------------------------------------------------------------------------------------

# Основной игровой блок ===============================================================================================
leveling = 0
while true

  zombie_knight = 0

  # распределение очков характеристик --------------------------------------------------------------------------
  while @hero.stat_points != 0

    character_panel # Панель характеристик персонажа (Основные)

    distribution = ''
    until %w[H M X A].include?(distribution)
      puts "Распределите очки характеристик. У вас осталось #{@hero.stat_points} очков"
      print '+5 жизней(H). +5 выносливости(M). +1 мин/макс случайно урон(X). +1 точность(A)  '
      distribution = gets.strip.upcase
      case distribution
      when 'H'
        @hero.hp_max += 5
        @hero.hp += 5
      when 'M'
        @hero.mp_max += 5
        @hero.mp += 5
      when 'X'
        @hero.min_dmg_base < @hero.max_dmg_base && rand(0..1) == 0 ? @hero.min_dmg_base += 1 : @hero.max_dmg_base += 1
      when 'A'
        @hero.accuracy_base += 1
      else
        puts 'Вы ввели неверный символ, попробуйте еще раз'
      end
    end
    @hero.stat_points -= 1
  end

  # распределение очков навыков --------------------------------------------------------------------------
  while @hero.skill_points != 0

    character_panel # Панель характеристик персонажа (Основные)

    distribution = ''
    while distribution != 'S' and distribution != 'P' and distribution != 'N'
      puts "Распределите очки навыков. У вас осталось #{@hero.skill_points} очков"
      print "+1 #{@hero.active_skill.name}(S). +1 #{@hero.passive_skill.name}(P). +1 #{@hero.camp_skill.name}(N) "
      distribution = gets.strip.upcase
      case distribution
      when 'S'; @hero.active_skill.lvl += 1
      when 'P'; @hero.passive_skill.lvl += 1
      when 'N'; @hero.camp_skill.lvl += 1
      else
        puts 'Вы ввели неверный символ, попробуйте еще раз'
        @hero.skill_points += 1
      end
      @hero.skill_points -= 1
    end
  end

  character_panel # Панель характеристик персонажа (Основные)

  #---------------------------------------------------------------------------------

  @hero.use_camp_skill # Навык Первая помощь

  @hero.rest # пассивное восстановления жизней и маны между боями

  #--------------------------------------------------------------------------------------------------------------

  print 'Чтобы начать следующий бой нажмите Enter'
  gets
  puts "++++++++++++++++++++++++++++++++++++++ Бой #{leveling + 1} +++++++++++++++++++++++++++++++++++++++++++++++++"

  # Назначение противника ---------------------------------------------------------------------------------

  # Проверка шанса уникальных противников
  enemy_event_rand = rand(1..100)
  if enemy_event_rand > (99 - leveling) and zombie_knight != 1
    print 'Вы заметили с одной стороны развилки фигуру рыцаря, идем туда(Y) или свернем в другую сторону? '
    r_choose = gets.strip.upcase
    case r_choose
    when 'Y'
      zombie_knight = 1
      puts 'Это рыцарь-зомби, приготовься к сложному бою'
      @enemy = Enemy.new("Рыцарь-зомби")
    else
      puts 'Правильный выбор, выглядело опасно'
      puts '-' * 40
      enemy_rand = rand(1..12) + rand(0..leveling)
    end
  else
    enemy_rand = rand(1..12) + rand(0..leveling)
  end

  # Выбор стандартного противника
  if zombie_knight != 1
    if enemy_rand > 0 and enemy_rand <= 5
      @enemy = Enemy.new("Оборванец")
    elsif enemy_rand > 5 and enemy_rand <= 10
      @enemy = Enemy.new("Бешеный пес")
    elsif enemy_rand > 10 and enemy_rand <= 15
      @enemy = Enemy.new("Гоблин")
    elsif enemy_rand > 15 and enemy_rand <= 20
      @enemy = Enemy.new("Бандит")
    elsif enemy_rand > 20 and enemy_rand <= 25
      @enemy = Enemy.new("Дезертир")
    elsif enemy_rand > 25 #and enemy_rand <= 30
      @enemy = Enemy.new("Орк")
    end
  end

  #--------------------------------------------------------------------------------------------------------------------

  InfoBlock.enemy_start_stats_info(@enemy)

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
      Art.game_over
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
            Art.game_over
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
