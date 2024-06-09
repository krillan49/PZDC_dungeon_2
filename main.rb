require_relative "hero"
require_relative "enemyes"
require_relative "weapons"


#======================================= Методы временные решения =================================================

# Заплатка для корректного отображения навыков на которые влияют характеристики(Концентрация)
def temporary_patch_concentration
  if @name_passive_pl == "Концентрация"
    damage_passive_pl = rand(0..0.1 * (@hero.mp_max_pl * (1 + 0.05 * @lvl_passive_pl) - 100))
    @lor_passive_pl = "(#{@lvl_passive_pl}): если мана больше 100(#{@hero.mp_max_pl}) наносится случайный доп урон до #{(0.1 * (@hero.mp_max_pl * (1 + 0.05 * @lvl_passive_pl) - 100)).round(1)}"
  end
end

# Панель характеристик персонажа
def character_panel
  puts '--------------------------------------------------------------------------------------------'
  puts '--------------------------------------------------------------------------------------------'
  puts "#{@hero.name_pl}"
  puts "Уровень #{@hero.lvl_pl} (#{@hero.exp_pl}/#{@hero.exp_lvl[@hero.lvl_pl + 1]})"
  puts "Н А В Ы К И:"
  puts "[акт] #{@name_special_pl} #{@lor_special_pl}"
  puts "[пас] #{@name_passive_pl} #{@lor_passive_pl}"
  puts "[неб] #{@name_noncombat_pl} #{@lor_noncombat_pl}"
  puts "С Т А Т Ы:"
  puts "HP #{@hero.hp_pl.round}/#{@hero.hp_max_pl} Реген #{@hero.regen_hp_base_pl} Восстановление #{@hero.recovery_hp.round}"
  puts "MP #{@hero.mp_pl.round}/#{@hero.mp_max_pl} Реген #{@hero.regen_mp_base_pl} Восстановление #{@hero.recovery_mp.round}"
  puts "Урон #{@hero.mindam_pl}-#{@hero.maxdam_pl} (базовый #{@hero.mindam_base_pl}-#{@hero.maxdam_base_pl} + #{@hero.weapon.name} #{@hero.weapon.min_dmg}-#{@hero.weapon.max_dmg})"
  puts "Точность #{@hero.accuracy_pl} (базовая #{@hero.accuracy_base_pl} + #{@hero.arms_armor.name} #{@hero.arms_armor.accuracy})"
  puts "Броня #{@hero.armor_pl} (базовая #{@hero.armor_base_pl} + #{@hero.body_armor.name} #{@hero.body_armor.armor} + #{@hero.head_armor.name} #{@hero.head_armor.armor} + #{@hero.arms_armor.name} #{@hero.arms_armor.armor} + #{@hero.shield.name} #{@hero.shield.armor})"
  puts "Шанс блока #{0 if @hero.shield.name == "без щита"}#{@hero.block_pl if @hero.shield.name != "без щита" and @name_passive_pl != "Мастер щита"}#{@hero.block_pl + @coeff_passive_pl if @hero.shield.name != "без щита" and @name_passive_pl == "Мастер щита"} (#{@hero.shield.name} #{@hero.shield.block_chance}) блокируемый урон #{100 - (100 / (1 + @hero.hp_pl.to_f / 200)).to_i}%"
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
@hero.name_pl = gets.strip

# Выбор стартовых навыков .......................................................................................
puts 'Выберите стартовый активный навык '
print 'Сильный удар(S) Точный удар(A) '
special_choiсe = gets.strip.upcase
while special_choiсe != 'S' and special_choiсe != 'A'
  print 'Введен неверный символ. Попробуйте еще раз. Сильный удар(S) Точный удар(A) '
  special_choiсe = gets.strip.upcase
end
lvl_special_pl = 0
case special_choiсe
when 'S'
  @name_special_pl = "Сильный удар"
  special_damage_pl = 2 + 0.2 * lvl_special_pl
  special_accuracy_pl = 1
  special_mp_cost_pl = 15
  @lor_special_pl = "(#{lvl_special_pl}): урон сильнее в #{special_damage_pl}, наносится по телу. Цена 15 выносливости"
when 'A'
  @name_special_pl = "Точный удар"
  special_damage_pl = 1 + 0.1 * lvl_special_pl
  special_accuracy_pl = 1.5 + 0.1 * lvl_special_pl
  special_mp_cost_pl = 5
  @lor_special_pl = "(#{lvl_special_pl}): точнее в #{special_accuracy_pl}, сильнее в #{special_damage_pl} наносится по телу. Цена 5 выносливости"
end

puts 'Выберите стартовый пассивный навык '
print 'Ошеломление(D) Концентрация(C) Мастер щита(B) '
passive_choiсe = gets.strip.upcase
while passive_choiсe != 'D' and passive_choiсe != 'C' and passive_choiсe != 'B'
  print 'Неверный символ попробуйте еще раз. Ошеломление(D) Концентрация(C) Мастер щита(B) '
  passive_choiсe = gets.strip.upcase
end
@lvl_passive_pl = 0
case passive_choiсe
when 'D'
  @name_passive_pl = "Ошеломление"
  @coeff_passive_pl = 1 + 0.1 * @lvl_passive_pl
  @lor_passive_pl = "(#{@lvl_passive_pl}): если урон больше #{(100 / (2 * @coeff_passive_pl)).round}% осташихся жизней врага то он теряет 10-90(%) точности"
when 'C'
  @name_passive_pl = "Концентрация"
  damage_passive_pl = rand(0..0.1 * (@hero.mp_max_pl * (1 + 0.05 * @lvl_passive_pl) - 100))
  @lor_passive_pl = "(#{@lvl_passive_pl}): если мана больше 100(#{@hero.mp_max_pl}) наносится случайный доп урон до #{(0.1 * (@hero.mp_max_pl * (1 + 0.05 * @lvl_passive_pl) - 100)).round(1)}"
when 'B'
  @name_passive_pl = "Мастер щита"
  @coeff_passive_pl = 10 + 2 * @lvl_passive_pl
  @lor_passive_pl = "(#{@lvl_passive_pl}): шанс блока щитом увеличен на #{@coeff_passive_pl}%"
end

puts 'Выберите стартовый небоевой навык '
print 'Первая помощь(F) Кладоискатель(T) '
noncombat_choiсe = gets.strip.upcase
while noncombat_choiсe != 'F' and noncombat_choiсe != 'T'
  print 'Введен неверный символ попробуйте еще раз. Первая помощь(F) Кладоискатель(T) '
  noncombat_choiсe = gets.strip.upcase
end
lvl_noncombat_pl = 0
case noncombat_choiсe
when 'F'
  @name_noncombat_pl = "Первая помощь"
  coeff_noncombat_pl = 1 + 0.1 * lvl_noncombat_pl
  effect_noncombat_pl = (@hero.hp_max_pl - @hero.hp_pl) * 0.2 * coeff_noncombat_pl
  noncombat_mp_cost_pl = 10
  @lor_noncombat_pl = "(#{lvl_noncombat_pl}): восстанавливает #{((@hero.hp_max_pl - @hero.hp_pl) * 0.2 * coeff_noncombat_pl).round} жизней, чем больше жизней потеряно, тем больше эффект(#{(0.2 * coeff_noncombat_pl * 100).round}%), цена 10 маны."
when 'T'
  @name_noncombat_pl = "Кладоискатель"
  coeff_noncombat_pl = 50 + 5 * lvl_noncombat_pl
  @lor_noncombat_pl = "(#{lvl_noncombat_pl}): дополнительный бонус очков поиска сокровищ = #{coeff_noncombat_pl}"
end
#--------------------------------------------------------------------------------------------------------------------

# Стартовый шанс блока
@hero.block_pl = @hero.shield.block_chance

zombie_knight = 0

# Основной игровой блок ===============================================================================================
leveling = 0
while true

  # Распределения очков характеристик и очков навыков ------------------------------------------------
  while @hero.stat_points != 0

    temporary_patch_concentration # Заплатка для корректного отображения навыков на которые влияют характеристики(Концентрация) (Временные решения)

    character_panel # Панель характеристик персонажа (Основные)

    # распределение очков характеристик --------------------------------------------------------------------------
    distribution = ''
    while distribution != 'H' and distribution != 'M' and distribution != 'X' and distribution != 'A'
      puts "Распределите очки характеристик. У вас осталось #{@hero.stat_points} очков"
      print '+5 жизней(H). +5 выносливости(M). +1 мин/макс случайно урон(X). +1 точность(A)  '
      distribution = gets.strip.upcase
      case distribution
      when 'H'
        @hero.hp_max_pl += 5
        @hero.hp_pl += 5
      when 'M'
        @hero.mp_max_pl += 5
        @hero.mp_pl += 5
      when 'X'
        min_or_max = rand(0..1)
        if min_or_max == 0 and @hero.mindam_base_pl < @hero.maxdam_base_pl
          @hero.mindam_base_pl += 1
        else
          @hero.maxdam_base_pl += 1
        end
      when 'A'
        @hero.accuracy_base_pl += 1
      else
        puts 'Вы ввели неверный символ, попробуйте еще раз'
        @hero.stat_points += 1
      end
      @hero.stat_points -= 1
    end
  end

  while @hero.skill_points != 0

    temporary_patch_concentration # Заплатка для корректного отображения навыков на которые влияют характеристики(Концентрация) (Временные решения)

    character_panel # Панель характеристик персонажа (Основные)

    # распределение очков навыков ------------------------------------------------------------------------------
    distribution = ''
    while distribution != 'S' and distribution != 'P' and distribution != 'N'
      puts "Распределите очки навыков. У вас осталось #{@hero.skill_points} очков"
      print "+1 #{@name_special_pl}(S). +1 #{@name_passive_pl}(P). +1 #{@name_noncombat_pl}(N) "
      distribution = gets.strip.upcase
      case distribution
      when 'S' # активные
        lvl_special_pl += 1
        if @name_special_pl == "Сильный удар"
          special_damage_pl = 2 + 0.2 * lvl_special_pl
          @lor_special_pl = "(#{lvl_special_pl}): урон сильнее в #{special_damage_pl.round(1)}, наносится по телу. Цена 15 выносливости"
        elsif @name_special_pl == "Точный удар"
          special_damage_pl = 1 + 0.1 * lvl_special_pl
          special_accuracy_pl = 1.5 + 0.1 * lvl_special_pl
          @lor_special_pl = "(#{lvl_special_pl}): точнее в #{special_accuracy_pl}, сильнее в #{special_damage_pl} наносится по телу. Цена 5 выносливости"
        end
      when 'P' # пассивные
        @lvl_passive_pl += 1
        if @name_passive_pl == "Ошеломление"
          @coeff_passive_pl = 1 + 0.1 * @lvl_passive_pl
          @lor_passive_pl = "(#{@lvl_passive_pl}): если урон больше #{(100 / (2 * @coeff_passive_pl)).round}% осташихся жизней врага то он теряет 10-90(%) точности"
        elsif @name_passive_pl == "Концентрация"
          damage_passive_pl = rand(0..0.1 * (@hero.mp_max_pl * (1 + 0.05 * @lvl_passive_pl) - 100))
          @lor_passive_pl = "(#{@lvl_passive_pl}): если мана больше 100(#{@hero.mp_max_pl}) наносится случайный доп урон до #{(0.1 * (@hero.mp_max_pl * (1 + 0.05 * @lvl_passive_pl) - 100)).round(1)}"
        elsif @name_passive_pl == "Мастер щита"
          @coeff_passive_pl = 10 + 2 * @lvl_passive_pl
          @lor_passive_pl = "(#{@lvl_passive_pl}): шанс блока щитом увеличен на #{@coeff_passive_pl}%"
        end
      when 'N' # небоевые
        lvl_noncombat_pl += 1
        if @name_noncombat_pl == "Первая помощь"
          coeff_noncombat_pl = 1 + 0.1 * lvl_noncombat_pl
          effect_noncombat_pl = (@hero.hp_max_pl - @hero.hp_pl) * 0.2 * coeff_noncombat_pl
          @lor_noncombat_pl = "(#{lvl_noncombat_pl}): восстанавливает #{((@hero.hp_max_pl - @hero.hp_pl) * 0.2 * coeff_noncombat_pl).round} жизней, чем больше жизней потеряно, тем больше эффект(#{(0.2 * coeff_noncombat_pl * 100).round}%), цена 10 маны."
        elsif @name_noncombat_pl == "Кладоискатель"
          coeff_noncombat_pl = 50 + 5 * lvl_noncombat_pl
          @lor_noncombat_pl = "(#{lvl_noncombat_pl}): дополнительный бонус очков поиска сокровищ = #{coeff_noncombat_pl}"
        end
      else
        puts 'Вы ввели неверный символ, попробуйте еще раз'
        @hero.skill_points += 1
      end
      @hero.skill_points -= 1
    end
  end

  temporary_patch_concentration # Заплатка для корректного отображения навыков на которые влияют характеристики(Концентрация) (Временные решения)

  character_panel # Панель характеристик персонажа (Основные)

  # Навык Первая помощь ---------------------------------------------------------------------------------
  if (@hero.hp_max_pl - @hero.hp_pl) > 0 and @name_noncombat_pl == "Первая помощь"
    coeff_noncombat_pl = 1 + 0.1 * lvl_noncombat_pl
    effect_noncombat_pl = (@hero.hp_max_pl - @hero.hp_pl) * 0.2 * coeff_noncombat_pl
    print "У вас #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней, хотите использовать навык #{@name_noncombat_pl}, чтобы восстановить #{effect_noncombat_pl.round} жизней за 10 маны? (Y/N) "
    noncombat_choice = gets.strip.upcase
    if noncombat_choice == "Y" and @hero.mp_pl >= noncombat_mp_cost_pl
      @hero.hp_pl += effect_noncombat_pl
      @hero.mp_pl -= noncombat_mp_cost_pl
      puts "Вы восстановили #{effect_noncombat_pl.round} жизней за #{noncombat_mp_cost_pl} маны, теперь у вас #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней и #{@hero.mp_pl.round}/#{@hero.mp_max_pl} маны"
    elsif noncombat_choice == "Y" and @hero.mp_pl <= noncombat_mp_cost_pl
      puts "Не хватает маны"
    end
  end
  #-----------------------------------------------------------------------------------------------------------

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

  mindam_en = @enemy.min_dmg_base + @enemy.weapon.min_dmg
  maxdam_en = @enemy.max_dmg_base + @enemy.weapon.max_dmg
  armor_en = @enemy.armor_base + @enemy.body_armor.armor + @enemy.head_armor.armor + @enemy.arms_armor.armor + @enemy.shield.armor
  accurasy_en = @enemy.accuracy_base + @enemy.arms_armor.accuracy
  block_en = @enemy.shield.block_chance
  #--------------------------------------------------------------------------------------------------------------------

  puts "В бой! Ваш противник #{@enemy.name}"
  puts "HP #{@enemy.hp}"
  puts "Damage #{mindam_en}-#{maxdam_en} = #{@enemy.min_dmg_base}-#{@enemy.max_dmg_base} + #{@enemy.weapon.min_dmg}-#{@enemy.weapon.max_dmg}(#{@enemy.weapon.name})"
  puts "Armor #{armor_en} = #{@enemy.armor_base} + #{@enemy.body_armor.armor}(#{@enemy.body_armor.name}) + #{@enemy.head_armor.armor}(#{@enemy.head_armor.name}) + #{@enemy.arms_armor.armor}(#{@enemy.arms_armor.name}) + #{@enemy.shield.armor}(#{@enemy.shield.name})"
  puts "Accurasy #{accurasy_en} = #{@enemy.accuracy_base} + #{@enemy.arms_armor.accuracy}(#{@enemy.arms_armor.name})"
  puts "Block #{block_en} = #{@enemy.shield.block_chance}(#{@enemy.shield.name})"

  # Ход боя ===============================================================================================
  run = false
  lap = 1 # номер хода

  while @enemy.hp > 0 and run == false

    puts "====================================== ХОД #{lap} ============================================"

    # Расчет базового урона----------------------------------------------------------------------------------------
    damage_pl = rand(@hero.mindam_pl..@hero.maxdam_pl)

    damage_en = rand(mindam_en..maxdam_en)
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
        accuracy_action_pl = @hero.accuracy_pl * 0.7
        target_name_pl = "по голове"
      when 'L'
        damage_pl *= 0.7
        accuracy_action_pl = @hero.accuracy_pl * 1.5
        target_name_pl = "по ногам"
      when 'S'
        if @hero.mp_pl >= special_mp_cost_pl
          damage_pl *= special_damage_pl
          accuracy_action_pl = @hero.accuracy_pl * special_accuracy_pl
          target_name_pl = @name_special_pl
          @hero.mp_pl -= special_mp_cost_pl
        else
          puts "Недостаточно маны на #{@name_special_pl}"
          cant_do -= 1
        end
      else
        accuracy_action_pl = @hero.accuracy_pl
      end
    end
    # -----------------------------------------------------------------------------------------------------

    # Направление атаки бота ----------------------------------------------------------------------------
    target_en = rand(1..10)
    name_target_en = "по телу"
    if target_en >= 1 and target_en <= 3
      damage_en *= 1.5
      accurasy_action_en = accurasy_en * 0.7
      name_target_en = "по голове"
    elsif target_en >= 4 and target_en <= 6
      damage_en *= 0.7
      accurasy_action_en = accurasy_en * 1.5
      name_target_en = "по ногам"
    else
      accurasy_action_en = accurasy_en
    end
    #-----------------------------------------------------------------------------------------------------------
    puts '-----------------------------------------------------------------------------------------'

    # Расчет блока щитом --------------------------------------------------------------------------------------------
    if @name_passive_pl == "Мастер щита" and @hero.shield.name != "без щита"
      @hero.block_pl = @hero.shield.block_chance + @coeff_passive_pl
    end

    chanse_block_pl = rand(1..100)
    if @hero.block_pl >= chanse_block_pl
      damage_en /= 1 + @hero.hp_pl.to_f / 200
    end

    chanse_block_en = rand(1..100)
    if block_en >= chanse_block_en
      damage_pl /= 1 + @enemy.hp.to_f / 200
    end
    # ---------------------------------------------------------------------------------------------------------------

    # Расчет итогового урона-----------------------------------------------------------------------------------------
    damage_pl -= armor_en
    if damage_pl < 0
      damage_pl = 0
    end

    damage_en -= @hero.armor_pl
    if damage_en < 0
      damage_en = 0
    end
    #----------------------------------------------------------------------------------------------------------------

    # Расчет попадания/промаха и проведения атак и навыков -----------------------------------------------------
    if accuracy_action_pl >= rand(1..100)
      puts "#{@enemy.name} заблокировал #{100 - (100 / (1 + @enemy.hp.to_f / 200)).to_i}% урона" if block_en >= chanse_block_en
      @enemy.hp -= damage_pl
      puts "Вы нанесли #{damage_pl.round} урона #{target_name_pl}"
      hit_miss_pl = 1
    else
      puts "Вы промахнулись #{target_name_pl}"
      hit_miss_pl = 0
    end

    case @name_passive_pl
    when "Ошеломление"
      if hit_miss_pl == 1 and damage_pl * @coeff_passive_pl > (@enemy.hp + damage_pl) / 2
        accurasy_action_en *= 0.1*rand(1..9)
        puts "атака ошеломила врага, уменьшив его точность до #{(accurasy_en * 0.1 * rand(1..9)).round}"
      end
    when "Концентрация"
      if hit_miss_pl == 1 and damage_passive_pl > 0
        damage_passive_pl = rand(0..0.1 * (@hero.mp_max_pl * (1 + 0.05 * @lvl_passive_pl) - 100))
        @enemy.hp -= damage_passive_pl
        puts "дополнительный урон от концентрации #{damage_passive_pl.round(1)}"
      end
    end

    if accurasy_action_en >= rand(1..100)
      puts "Вы заблокировали #{100 - (100 / (1 + @hero.hp_pl.to_f / 200)).to_i}% урона" if @hero.block_pl >= chanse_block_pl
      @hero.hp_pl -= damage_en
      puts "#{@enemy.name} нанес #{damage_en.round} урона #{name_target_en}"
      hit_miss_en = 1
    else
      puts "#{@enemy.name} промахнулся #{name_target_en}"
      hit_miss_en = 0
    end
    #------------------------------------------------------------------------------------------------------------------

    # Доп эффекты(регенерация)------------------------------------------------------------------------------
    @hero.regeneration_hp_mp
    #---------------------------------------------------------------------------------------------------------------

    # Результат обмена ударами --------------------------------------------------------------------------------
    if @hero.hp_pl > 0 and @enemy.hp > 0
      puts "У вас осталось #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней и #{@hero.mp_pl.round}/#{@hero.mp_max_pl} выносливости, у #{@enemy.name}а осталось #{@enemy.hp.round} жизней."
    elsif @hero.hp_pl > 0 and @enemy.hp <= 0
      puts "У вас осталось #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней и #{@hero.mp_pl.round}/#{@hero.mp_max_pl} выносливости, у #{@enemy.name}а осталось #{@enemy.hp.round} жизней."
      puts "#{@enemy.name} убит, победа!!!"
    elsif @hero.hp_pl <= 0
      puts "Ты убит - слабак!"
      exit
    end
    #------------------------------------------------------------------------------------------------------------------

    # Побег ---------------------------------------------------------------------------------------------------
    if @hero.hp_pl < (@hero.hp_max_pl * 0.15) and @hero.hp_pl > 0 and @enemy.hp > 0
      print 'Ты на пороге смерти. Чтобы убежать введи Y : '
      run_select = gets.strip.upcase
      if run_select == 'Y'
        run_chance = rand(0..2)
        if run_chance >= 1
          puts "Сбежал ссыкло, штраф 5 опыта"
          @hero.exp_pl -= 5
          run = true
        else
          @hero.hp_pl -= damage_en
          puts "Не удалось убежать #{@enemy.name} нанес #{damage_en.round} урона"
          if @hero.hp_pl <= 0
            puts "Ты убит - трусливая псина!"
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

    loot = rand(0..5)
    if loot <= 5 and loot >=4
      if (@hero.hp_max_pl - @hero.hp_pl) >= 20
        @hero.hp_pl += 20
      elsif (@hero.hp_max_pl - @hero.hp_pl) < 20 and @hero.hp_pl < @hero.hp_max_pl
        @hero.hp_pl = @hero.hp_max_pl
      end
      puts "Обыскав все вокруг ты нашел зелье восстанавливающее 20 жизней, теперь у тебя #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней"
    elsif loot <= 3 and loot >= 2
      puts "Рядом нет ничего ценного"
    elsif loot <= 1
      @hero.hp_pl -= 5
      puts "Пока ты шарил по углам, тебя укусила крыса(-5 жизней), теперь у тебя #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней"
      if @hero.hp_pl <= 0
        puts "Ты подох от укуса крысы. Жалкая смерть"
        exit
      end
    end

    if @name_noncombat_pl == "Кладоискатель"
      stash_magic0 = rand(1..200)
      stash_magic = stash_magic0 + coeff_noncombat_pl
    else
      stash_magic = rand(1..200)
    end
    puts "#{stash_magic0} + treasure hunter(#{coeff_noncombat_pl})= #{stash_magic}"
    if stash_magic >= 180
      puts "Осмотревшись вы заметили тайник мага, а в нем... "
    end
    stash_magic_treasure = rand(1..32)
    if stash_magic_treasure <= 10 and stash_magic >= 180
      bonus_hp = rand(1..3)
      puts "Эликсир здоровья. Ваши жизни #{@hero.hp_pl.round}/#{@hero.hp_max_pl} увеличиваются на #{bonus_hp}"
      @hero.hp_max_pl += bonus_hp
      @hero.hp_pl += bonus_hp
      puts "Теперь у вас #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней"
    elsif stash_magic_treasure <= 20 and stash_magic >= 180
      bonus_mp = rand(1..3)
      puts "Эликсир выносливости. Ваша выносливость #{@hero.mp_pl.round}/#{@hero.mp_max_pl} увеличивается на #{bonus_mp}"
      @hero.mp_max_pl += bonus_mp
      @hero.mp_pl += bonus_mp
      puts "Теперь у вас #{@hero.mp_pl.round}/#{@hero.mp_max_pl} выносливости"
    elsif stash_magic_treasure <= 25 and stash_magic >= 180
      bonus_accuracy = rand(1..2)
      puts "Эликсир точности. Ваша точность #{@hero.accuracy_base_pl} увеличивается на #{bonus_accuracy}"
      @hero.accuracy_base_pl += bonus_accuracy
      puts "Теперь у вас #{@hero.accuracy_base_pl} точности"
    elsif stash_magic_treasure <= 27 and stash_magic >= 180
      bonus_points = 1
      puts "Книга знаний. Ваши очки характеристик увеличились на #{bonus_points}"
      @hero.stat_points += bonus_points
    elsif stash_magic_treasure <= 29 and stash_magic >= 180
      skill_bonus_points = 1
      puts "Книга умений. Ваши очки умений увеличились на #{skill_bonus_points}"
      @hero.skill_points += skill_bonus_points
    elsif stash_magic_treasure <= 30 and stash_magic >= 180
      bonus_armor = 1
      puts "Эликсир камня. Ваша броня #{@hero.armor_base_pl} увеличивается на #{bonus_armor}"
      @hero.armor_base_pl += bonus_armor
      puts "Теперь у вас #{@hero.armor_base_pl} брони"
    elsif stash_magic_treasure <= 31 and stash_magic >= 180
      bonus_hp_regen = 1
      puts "Эликсир троля. Регенерация жизней #{@hero.regen_hp_base_pl} увеличивается на #{bonus_hp_regen}"
      @hero.regen_hp_base_pl += bonus_hp_regen
      puts "Теперь у вас #{@hero.regen_hp_base_pl} регенерации жизней"
    elsif stash_magic_treasure <= 32 and stash_magic >= 180
      bonus_mp_regen = 1
      puts "Эликсир единорога. Регенерация выносливости #{@hero.regen_mp_base_pl} увеличивается на #{bonus_mp_regen}"
      @hero.regen_mp_base_pl += bonus_mp_regen
      puts "Теперь у вас #{@hero.regen_mp_base_pl} регенерации выносливости"
    end

    weapon_loot = rand(0..1)
    if weapon_loot == 1 and @enemy.weapon.name != "без оружия"
      puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.weapon.name}"
      print "Поменяем #{@hero.weapon.name}(#{@hero.weapon.min_dmg}-#{@hero.weapon.max_dmg}) на #{@enemy.weapon.name}(#{@enemy.weapon.min_dmg}-#{@enemy.weapon.max_dmg}) Y/N? "
      weapon_loot_choice = gets.strip.upcase
      if weapon_loot_choice == 'Y'
        @hero.weapon = @enemy.weapon
      end
    end

    torso_loot = rand(0..1)
    if torso_loot == 1 and @enemy.body_armor.name != "без нагрудника"
      puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.body_armor.name}"
      print "Поменяем #{@hero.body_armor.name}(#{@hero.body_armor.armor}) на #{@enemy.body_armor.name}(#{@enemy.body_armor.armor}) Y/N? "
      torso_loot_choice = gets.strip.upcase
      if torso_loot_choice == 'Y'
        @hero.body_armor = @enemy.body_armor
      end
    end

    helmet_loot = rand(0..1)
    if helmet_loot == 1 and @enemy.head_armor.name != "без шлема"
      puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.head_armor.name}"
      print "Поменяем #{@hero.head_armor.name}(#{@hero.head_armor.armor}) на #{@enemy.head_armor.name}(#{@enemy.head_armor.armor}) Y/N? "
      helmet_loot_choice = gets.strip.upcase
      if helmet_loot_choice == 'Y'
        @hero.head_armor = @enemy.head_armor
      end
    end

    gloves_loot = rand(0..1)
    if gloves_loot == 1 and @enemy.arms_armor.name != "без перчаток"
      puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.arms_armor.name}"
      print "Поменяем #{@hero.arms_armor.name}(бр-#{@hero.arms_armor.armor} точ-#{@hero.arms_armor.accuracy}) на #{@enemy.arms_armor.name}(бр-#{@enemy.arms_armor.armor} точ-#{@enemy.arms_armor.accuracy}) Y/N? "
      gloves_loot_choice = gets.strip.upcase
      if gloves_loot_choice == 'Y'
        @hero.arms_armor = @enemy.arms_armor
      end
    end

    shield_loot = rand(0..1)
    if shield_loot == 1 and @enemy.shield.name != "без щита"
      puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.shield.name}"
      print "Поменяем #{@hero.shield.name}(бр-#{@hero.shield.armor} блок-#{@hero.shield.block_chance}) на #{@enemy.shield.name}(бр-#{@enemy.shield.armor} блок-#{@enemy.shield.block_chance}) Y/N? "
      shield_loot_choice = gets.strip.upcase
      if shield_loot_choice == 'Y'
        @hero.shield = @enemy.shield
      end
    end

    @hero.block_pl = @hero.shield.block_chance
  end
  #-------------------------------------------------------------------------------------------------------------
  puts
  # Получение опыта и очков -------------------------------------------------------------------------------------
  @hero.add_exp_and_hero_level_up(@enemy.exp_gived)
  #-----------------------------------------------------------------------------------------------------------------

  puts '-------------------------------------------------------------------------------------------------'
  leveling += 1
end
#====================================================================================================================












#
