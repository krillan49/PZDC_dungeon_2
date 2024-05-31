require_relative "hero"


puts '==========================================================================='
puts 'Добро пожаловать в рогулайк РПГ "Пиздецовое подземелье"'
puts '==========================================================================='

# Базоаве статы................................................................................................
@hero = Hero.new

# raice 'Error'

@exp_lvl = [0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200]
#.................................................................................................................

#======================================= Методы временные решения =================================================

# Заплатка для корректного отображения навыков на которые влияют характеристики(Концентрация)
def temporary_patch_concentration
  if @name_passive_pl == "Концентрация"
    damage_passive_pl = rand(0..0.1 * (@hero.max_mp_pl * (1 + 0.05 * @lvl_passive_pl) - 100))
    @lor_passive_pl = "(#{@lvl_passive_pl}): если мана больше 100(#{@hero.max_mp_pl}) наносится случайный доп урон до #{(0.1 * (@hero.max_mp_pl * (1 + 0.05 * @lvl_passive_pl) - 100)).round(1)}"
  end
end

#==================================================================================================================

#======================================= Методы основные ==========================================================

# Панель характеристик персонажа
def character_panel
  puts '--------------------------------------------------------------------------------------------'
  puts '--------------------------------------------------------------------------------------------'
  puts "#{@name_pl}"
  puts "Уровень #{@hero.lvl_pl} (#{@hero.exp_pl}/#{@exp_lvl[@hero.lvl_pl + 1]})"
  puts "Н А В Ы К И:"
  puts "[акт] #{@name_special_pl} #{@lor_special_pl}"
  puts "[пас] #{@name_passive_pl} #{@lor_passive_pl}"
  puts "[неб] #{@name_noncombat_pl} #{@lor_noncombat_pl}"
  puts "С Т А Т Ы:"
  puts "HP #{@hp_pl.round}/#{@hero.max_hp_pl} Реген #{@hero.regen_hp_pl_base} Восстановление #{@hero.recovery_hp_pl.round}"
  puts "MP #{@mp_pl.round}/#{@hero.max_mp_pl} Реген #{@hero.regen_mp_pl_base} Восстановление #{@hero.recovery_mp_pl.round}"
  puts "Урон #{@mindam_pl}-#{@maxdam_pl} (базовый #{@hero.mindam_pl_base}-#{@hero.maxdam_pl_base} + #{@weapon} #{@mindam_weapon}-#{@maxdam_weapon})"
  puts "Точность #{@accuracy_pl} (базовая #{@hero.accuracy_pl_base} + #{@gloves} #{@accuracy_gloves})"
  puts "Броня #{@armor_pl} (базовая #{@hero.armor_pl_base} + #{@torso} #{@armor_torso} + #{@helmet} #{@armor_helmet} + #{@gloves} #{@armor_gloves} + #{@shield} #{@armor_shield})"
  puts "Шанс блока #{0 if @shield == "без щита"}#{@block_pl if @shield != "без щита" and @name_passive_pl != "Мастер щита"}#{@block_pl + @coeff_passive_pl if @shield != "без щита" and @name_passive_pl == "Мастер щита"} (#{@shield} #{@block_shield}) блокируемый урон #{100 - (100 / (1 + @hp_pl.to_f / 200)).to_i}%"
  puts '--------------------------------------------------------------------------------------------'
  puts '--------------------------------------------------------------------------------------------'
end

#==================================================================================================================

# Создание персонажа..............................................................................................
puts 'Создание персонажа'
puts '========================'
print 'Введите имя персонажа: '
@name_pl = gets.strip

# Выбор предистории .................................................................................................
print "Выберите предисторию:
Сторож(G) + 30 жизней, Ржавый топорик
Карманник(T) + 5 точности, Ножик
Рабочий(W) + 30 выносливости, Дубинка
Умник(S) + 5 очков навыков, без оружия
"
story_pl = gets.strip.upcase
case story_pl
when 'G'
  @weapon = "Ржавый топорик"
  @hero.max_hp_pl += 30
  @hero.recovery_hp_pl = @hero.max_hp_pl * 0.1
when 'T'
  @weapon = "Ножик"
  @hero.accuracy_pl_base += 5
when 'W'
  @weapon = "Дубинка"
  @hero.max_mp_pl += 30
  @hero.recovery_mp_pl = @hero.max_mp_pl * 0.1
when 'S'
  @weapon = "без оружия"
  @hero.skill_points += 5
else
  @weapon = "без оружия"
  @hero.max_hp_pl -= 5
  @hero.max_mp_pl -= 5
  @hero.accuracy_pl_base -= 1
  puts 'Перепутал буквы, ты тупой алкаш -5 жизней -5выносливости -1точность'
end

@hp_pl = @hero.max_hp_pl
@mp_pl = @hero.max_mp_pl

@torso = "без нагрудника"
@helmet = "без шлема"
@gloves = "без перчаток"
@shield = "без щита"
story_pl = ""

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
  damage_passive_pl = rand(0..0.1 * (@hero.max_mp_pl * (1 + 0.05 * @lvl_passive_pl) - 100))
  @lor_passive_pl = "(#{@lvl_passive_pl}): если мана больше 100(#{@hero.max_mp_pl}) наносится случайный доп урон до #{(0.1 * (@hero.max_mp_pl * (1 + 0.05 * @lvl_passive_pl) - 100)).round(1)}"
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
  effect_noncombat_pl = (@hero.max_hp_pl - @hp_pl) * 0.2 * coeff_noncombat_pl
  noncombat_mp_cost_pl = 10
  @lor_noncombat_pl = "(#{lvl_noncombat_pl}): восстанавливает #{((@hero.max_hp_pl - @hp_pl) * 0.2 * coeff_noncombat_pl).round} жизней, чем больше жизней потеряно, тем больше эффект(#{(0.2 * coeff_noncombat_pl * 100).round}%), цена 10 маны."
when 'T'
  @name_noncombat_pl = "Кладоискатель"
  coeff_noncombat_pl = 50 + 5 * lvl_noncombat_pl
  @lor_noncombat_pl = "(#{lvl_noncombat_pl}): дополнительный бонус очков поиска сокровищ = #{coeff_noncombat_pl}"
end
#--------------------------------------------------------------------------------------------------------------------

# Стартовая броня, точность и доп эффекты(регенерация) -------------------------------------------------------
if @torso == "без нагрудника"
  @armor_torso = 0
end

if @helmet == "без шлема"
  @armor_helmet = 0
end

if @gloves == "без перчаток"
  @armor_gloves = 0
  @accuracy_gloves = 0
end

if @shield == "без щита"
  @armor_shield = 0
  @block_shield = 0
end

@armor_pl = @hero.armor_pl_base + @armor_torso + @armor_helmet + @armor_gloves + @armor_shield
@accuracy_pl = @hero.accuracy_pl_base + @accuracy_gloves
@block_pl = @block_shield
regen_hp_pl = @hero.regen_hp_pl_base
regen_mp_pl = @hero.regen_mp_pl_base
#--------------------------------------------------------------------------------------------------------------------

# Стартовое оружие и урон ----------------------------------------------------------------------------------
case @weapon
when "без оружия"
  @mindam_weapon = 0
  @maxdam_weapon = 0
when "Ржавый топорик"
  @mindam_weapon = 1
  @maxdam_weapon = 6
when "Ножик"
  @mindam_weapon = 2
  @maxdam_weapon = 5
when "Дубинка"
  @mindam_weapon = 3
  @maxdam_weapon = 4
end

@mindam_pl = @hero.mindam_pl_base + @mindam_weapon
@maxdam_pl = @hero.maxdam_pl_base + @maxdam_weapon
#-------------------------------------------------------------------------------------------------------------------

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
        @hero.max_hp_pl += 5
        @hp_pl += 5
        @hero.recovery_hp_pl = @hero.max_hp_pl * 0.1
      when 'M'
        @hero.max_mp_pl += 5
        @mp_pl += 5
        @hero.recovery_mp_pl = @hero.max_mp_pl * 0.1
      when 'X'
        min_or_max = rand(0..1)
        if min_or_max == 0 and @hero.mindam_pl_base < @hero.maxdam_pl_base
          @hero.mindam_pl_base += 1
          @mindam_pl = @hero.mindam_pl_base + @mindam_weapon
        else
          @hero.maxdam_pl_base += 1
          @maxdam_pl = @hero.maxdam_pl_base + @maxdam_weapon
        end
      when 'A'
        @hero.accuracy_pl_base += 1
        @accuracy_pl = @hero.accuracy_pl_base + @accuracy_gloves
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
          damage_passive_pl = rand(0..0.1 * (@hero.max_mp_pl * (1 + 0.05 * @lvl_passive_pl) - 100))
          @lor_passive_pl = "(#{@lvl_passive_pl}): если мана больше 100(#{@hero.max_mp_pl}) наносится случайный доп урон до #{(0.1 * (@hero.max_mp_pl * (1 + 0.05 * @lvl_passive_pl) - 100)).round(1)}"
        elsif @name_passive_pl == "Мастер щита"
          @coeff_passive_pl = 10 + 2 * @lvl_passive_pl
          @lor_passive_pl = "(#{@lvl_passive_pl}): шанс блока щитом увеличен на #{@coeff_passive_pl}%"
        end
      when 'N' # небоевые
        lvl_noncombat_pl += 1
        if @name_noncombat_pl == "Первая помощь"
          coeff_noncombat_pl = 1 + 0.1 * lvl_noncombat_pl
          effect_noncombat_pl = (@hero.max_hp_pl - @hp_pl) * 0.2 * coeff_noncombat_pl
          @lor_noncombat_pl = "(#{lvl_noncombat_pl}): восстанавливает #{((@hero.max_hp_pl - @hp_pl) * 0.2 * coeff_noncombat_pl).round} жизней, чем больше жизней потеряно, тем больше эффект(#{(0.2 * coeff_noncombat_pl * 100).round}%), цена 10 маны."
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
  if (@hero.max_hp_pl - @hp_pl) > 0 and @name_noncombat_pl == "Первая помощь"
    coeff_noncombat_pl = 1 + 0.1 * lvl_noncombat_pl
    effect_noncombat_pl = (@hero.max_hp_pl - @hp_pl) * 0.2 * coeff_noncombat_pl
    print "У вас #{@hp_pl.round}/#{@hero.max_hp_pl} жизней, хотите использовать навык #{@name_noncombat_pl}, чтобы восстановить #{effect_noncombat_pl.round} жизней за 10 маны? (Y/N) "
    noncombat_choice = gets.strip.upcase
    if noncombat_choice == "Y" and @mp_pl >= noncombat_mp_cost_pl
      @hp_pl += effect_noncombat_pl
      @mp_pl -= noncombat_mp_cost_pl
      puts "Вы восстановили #{effect_noncombat_pl.round} жизней за #{noncombat_mp_cost_pl} маны, теперь у вас #{@hp_pl.round}/#{@hero.max_hp_pl} жизней и #{@mp_pl.round}/#{@hero.max_mp_pl} маны"
    elsif noncombat_choice == "Y" and @mp_pl <= noncombat_mp_cost_pl
      puts "Не хватает маны"
    end
  end
  #-----------------------------------------------------------------------------------------------------------

  # Восстановления жизней и маны между боями-----------------------------------------------------------------
  if (@hero.max_hp_pl - @hp_pl) >= @hero.recovery_hp_pl
    @hp_pl += @hero.recovery_hp_pl
    puts "Передохнув вы восстанавливаете #{@hero.recovery_hp_pl.round} жизней, теперь у вас #{@hp_pl.round}/#{@hero.max_hp_pl} жизней"
  elsif (@hero.max_hp_pl - @hp_pl) < @hero.recovery_hp_pl and @hp_pl < @hero.max_hp_pl
    @hp_pl = @hero.max_hp_pl
    puts "Передохнув вы восстанавливаете #{@hero.recovery_hp_pl.round} жизней, теперь у вас #{@hp_pl.round}/#{@hero.max_hp_pl} жизней"
  end

  if (@hero.max_mp_pl - @mp_pl) >= @hero.recovery_mp_pl
    @mp_pl += @hero.recovery_mp_pl
    puts "Передохнув вы восстанавливаете #{@hero.recovery_mp_pl.round} выносливости, теперь у вас #{@mp_pl.round}/#{@hero.max_mp_pl} выносливости"
  elsif (@hero.max_mp_pl - @mp_pl) < @hero.recovery_mp_pl and @mp_pl < @hero.max_mp_pl
    @mp_pl = @hero.max_mp_pl
    puts "Передохнув вы восстанавливаете #{@hero.recovery_mp_pl.round} выносливости, теперь у вас #{@mp_pl.round}/#{@hero.max_mp_pl} выносливости"
  end
  #--------------------------------------------------------------------------------------------------------------

  print 'Чтобы начать следующий бой нажмите Enter'
  gets
  puts "++++++++++++++++++++++++++++++++++++++ Бой #{leveling + 1} +++++++++++++++++++++++++++++++++++++++++++++++++"

  # Назначение противника ---------------------------------------------------------------------------------

  # Значения характеристик экипировки по умолчанию(ели не прописаны впоследствии)
  weapon_en = "без оружия"
  mindam_weapon_en = 0
  maxdam_weapon_en = 0
  torso_en = "без нагрудника"
  armor_torso_en = 0
  helmet_en = "без шлема"
  armor_helmet_en = 0
  gloves_en = "без перчаток"
  armor_gloves_en = 0
  accurasy_gloves_en = 0
  shield_en = "без щита"
  armor_shield_en = 0
  block_shield_en = 0

  # Проверка шанса уникальных противников
  enemy_event_rand = rand(1..100)
  if enemy_event_rand > (99 - leveling) and zombie_knight != 1
    print 'Вы заметили с одной стороны развилки фигуру рыцаря, идем туда(Y) или свернем в другую сторону? '
    r_choose = gets.strip.upcase
    case r_choose
    when 'Y'
      zombie_knight = 1
      puts 'Это рыцарь-зомби, приготовься к сложному бою'
      name_en = "Рыцарь-зомби"

      weapon_en = "Ржавый полуторник"
      mindam_weapon_en = 6
      maxdam_weapon_en = 17
      torso_en = "Ветхая кираса"
      armor_torso_en = 3
      helmet_en = "Ветхий топфхельм"
      armor_helmet_en = 3
      gloves_en = "Ржавые кольчужные перчатки"
      armor_gloves_en = 2
      accurasy_gloves_en = -5

      hp_en = 300
      mindam_en_base = 5
      maxdam_en_base = 5
      accurasy_en_base = 40
      armor_en_base = 0
      exp = 20
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
    name_en = "Оборванец"
    rand_weapon_en = rand(0..1)
    if rand_weapon_en == 1
      weapon_en = "Палка"
      mindam_weapon_en = 1
      maxdam_weapon_en = 4
    end

    hp_en = 80
    mindam_en_base = 1
    maxdam_en_base = 5
    accurasy_en_base = 60
    armor_en_base = 0
    exp = 1
  elsif enemy_rand > 5 and enemy_rand <= 10
    name_en = "Бешеный пес"

    hp_en = 60
    mindam_en_base = 1
    maxdam_en_base = 8
    accurasy_en_base = 50
    armor_en_base = 0
    exp = 1
  elsif enemy_rand > 10 and enemy_rand <= 15
    name_en = "Гоблин"
    rand_weapon_en = rand(1..2)
    if rand_weapon_en == 1
      weapon_en = "Ножик"
      mindam_weapon_en = 2
      maxdam_weapon_en = 5
    elsif rand_weapon_en == 2
      weapon_en = "Кинжал"
      mindam_weapon_en = 3
      maxdam_weapon_en = 6
    end
    rand_gloves_en = rand(0..1)
    if rand_gloves_en == 1
      gloves_en = "Кожаные перчатки"
      armor_gloves_en = 0
      accurasy_gloves_en = 10
    end
    rand_shield_en = rand(0..1)
    if rand_shield_en == 1
      shield_en = "Плетеный баклер"
      armor_shield_en = 0
      block_shield_en = 30
    end

    hp_en = 65
    mindam_en_base = 3
    maxdam_en_base = 3
    accurasy_en_base = 85
    armor_en_base = 0
    exp = 2
  elsif enemy_rand > 15 and enemy_rand <= 20
    name_en = "Бандит"
    rand_weapon_en = rand(1..3)
    if rand_weapon_en == 1
      weapon_en = "Ржавый топорик"
      mindam_weapon_en = 1
      maxdam_weapon_en = 6
    elsif rand_weapon_en == 2
      weapon_en = "Ножик"
      mindam_weapon_en = 2
      maxdam_weapon_en = 5
    elsif rand_weapon_en == 3
      weapon_en = "Дубинка"
      mindam_weapon_en = 3
      maxdam_weapon_en = 4
    end
    rand_torso_en = rand(0..1)
    if rand_torso_en == 1
      torso_en = "Кожанка"
      armor_torso_en = 1
    end
    rand_helmet_en = rand(0..1)
    if rand_helmet_en == 1
      helmet_en = "Кожаный шлем"
      armor_helmet_en = 1
    end
    rand_gloves_en = rand(0..1)
    if rand_gloves_en == 1
      gloves_en = "Кожаные перчатки"
      armor_gloves_en = 0
      accurasy_gloves_en = 10
    end
    rand_shield_en = rand(0..1)
    if rand_shield_en == 1
      shield_en = "Деревянный баклер"
      armor_shield_en = 1
      block_shield_en = 25
    end

    hp_en = 100
    mindam_en_base = 5
    maxdam_en_base = 5
    accurasy_en_base = 80
    armor_en_base = 0
    exp = 2
  elsif enemy_rand > 20 and enemy_rand <= 25
    name_en = "Дезертир"
    rand_weapon_en = rand(1..3)
    if rand_weapon_en == 1
      weapon_en = "Ржавый топорик"
      mindam_weapon_en = 1
      maxdam_weapon_en = 6
    elsif rand_weapon_en == 2
      weapon_en = "Топорик"
      mindam_weapon_en = 5
      maxdam_weapon_en = 8
    elsif rand_weapon_en == 3
      weapon_en = "Фальшион"
      mindam_weapon_en = 5
      maxdam_weapon_en = 10
    end
    rand_torso_en = rand(0..2)
    if rand_torso_en == 1
      torso_en = "Кожанка"
      armor_torso_en = 1
    elsif rand_torso_en == 2
      torso_en = "Стеганка"
      armor_torso_en = 2
    end
    rand_helmet_en = rand(0..2)
    if rand_helmet_en == 1
      helmet_en = "Кожаный шлем"
      armor_helmet_en = 1
    elsif rand_helmet_en == 2
      helmet_en = "Стеганый шлем"
      armor_helmet_en = 2
    end
    rand_gloves_en = rand(0..2)
    if rand_gloves_en == 1
      gloves_en = "Кожаные перчатки"
      armor_gloves_en = 0
      accurasy_gloves_en = 10
    elsif rand_gloves_en == 2
      gloves_en = "Стеганые перчатки"
      armor_gloves_en = 1
      accurasy_gloves_en = 7
    end
    rand_shield_en = rand(0..2)
    if rand_shield_en == 1
      shield_en = "Деревянный баклер"
      armor_shield_en = 1
      block_shield_en = 25
    elsif rand_shield_en == 2
      shield_en = "Деревянный щит"
      armor_shield_en = 2
      block_shield_en = 15
    end

    hp_en = 120
    mindam_en_base = 5
    maxdam_en_base = 5
    accurasy_en_base = 80
    armor_en_base = 0
    exp = 3
  elsif enemy_rand > 25 #and enemy_rand <= 30
    name_en = "Орк"
    rand_weapon_en = rand(1..2)
    if rand_weapon_en == 1
      weapon_en = "Топор"
      mindam_weapon_en = 6
      maxdam_weapon_en = 10
    elsif rand_weapon_en == 2
      weapon_en = "Цеп"
      mindam_weapon_en = 0
      maxdam_weapon_en = 20
    end

    hp_en = 180
    mindam_en_base = 7
    maxdam_en_base = 7
    accurasy_en_base = 70
    armor_en_base = 0
    exp = 4
  end

  mindam_en = mindam_en_base + mindam_weapon_en
  maxdam_en = maxdam_en_base + maxdam_weapon_en
  armor_en = armor_en_base + armor_torso_en + armor_helmet_en + armor_gloves_en + armor_shield_en
  accurasy_en = accurasy_en_base + accurasy_gloves_en
  block_en = block_shield_en
  #--------------------------------------------------------------------------------------------------------------------

  puts "В бой! Ваш противник #{name_en}"
  puts "HP #{hp_en}"
  puts "Damage #{mindam_en}-#{maxdam_en} = #{mindam_en_base}-#{maxdam_en_base} + #{mindam_weapon_en}-#{maxdam_weapon_en}(#{weapon_en})"
  puts "Armor #{armor_en} = #{armor_en_base} + #{armor_torso_en}(#{torso_en}) + #{armor_helmet_en}(#{helmet_en}) + #{armor_gloves_en}(#{gloves_en}) + #{armor_shield_en}(#{shield_en})"
  puts "Accurasy #{accurasy_en} = #{accurasy_en_base} + #{accurasy_gloves_en}(#{gloves_en})"
  puts "Block #{block_en} = #{block_shield_en}(#{shield_en})"

  # Ход боя ===============================================================================================
  run = false
  lap = 1 # номер хода

  while hp_en > 0 and run == false

    puts "====================================== ХОД #{lap} ============================================"

    # Расчет базового урона----------------------------------------------------------------------------------------
    damage_pl = rand(@mindam_pl..@maxdam_pl)

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
        accuracy_action_pl = @accuracy_pl * 0.7
        target_name_pl = "по голове"
      when 'L'
        damage_pl *= 0.7
        accuracy_action_pl = @accuracy_pl * 1.5
        target_name_pl = "по ногам"
      when 'S'
        if @mp_pl >= special_mp_cost_pl
          damage_pl *= special_damage_pl
          accuracy_action_pl = @accuracy_pl * special_accuracy_pl
          target_name_pl = @name_special_pl
          @mp_pl -= special_mp_cost_pl
        else
          puts "Недостаточно маны на #{@name_special_pl}"
          cant_do -= 1
        end
      else
        accuracy_action_pl = @accuracy_pl
      end
    end
    # -----------------------------------------------------------------------------------------------------

    # Направление атаки бота ----------------------------------------------------------------------------
    target_en = rand(1..10)
    target_name_en = "по телу"
    if target_en >= 1 and target_en <= 3
      damage_en *= 1.5
      accurasy_action_en = accurasy_en * 0.7
      target_name_en = "по голове"
    elsif target_en >= 4 and target_en <= 6
      damage_en *= 0.7
      accurasy_action_en = accurasy_en * 1.5
      target_name_en = "по ногам"
    else
      accurasy_action_en = accurasy_en
    end
    #-----------------------------------------------------------------------------------------------------------
    puts '-----------------------------------------------------------------------------------------'

    # Расчет блока щитом --------------------------------------------------------------------------------------------
    if @name_passive_pl == "Мастер щита" and @shield != "без щита"
      @block_pl = @block_shield + @coeff_passive_pl
    end

    chanse_block_pl = rand(1..100)
    if @block_pl >= chanse_block_pl
      damage_en /= 1 + @hp_pl.to_f / 200
    end

    chanse_block_en = rand(1..100)
    if block_en >= chanse_block_en
      damage_pl /= 1 + hp_en.to_f / 200
    end
    # ---------------------------------------------------------------------------------------------------------------

    # Расчет итогового урона-----------------------------------------------------------------------------------------
    damage_pl -= armor_en
    if damage_pl < 0
      damage_pl = 0
    end

    damage_en -= @armor_pl
    if damage_en < 0
      damage_en = 0
    end
    #----------------------------------------------------------------------------------------------------------------

    # Расчет попадания/промаха и проведения атак и навыков -----------------------------------------------------
    if accuracy_action_pl >= rand(1..100)
      puts "#{name_en} заблокировал #{100 - (100 / (1 + hp_en.to_f / 200)).to_i}% урона" if block_en >= chanse_block_en
      hp_en -= damage_pl
      puts "Вы нанесли #{damage_pl.round} урона #{target_name_pl}"
      hit_miss_pl = 1
    else
      puts "Вы промахнулись #{target_name_pl}"
      hit_miss_pl = 0
    end

    case @name_passive_pl
    when "Ошеломление"
      if hit_miss_pl == 1 and damage_pl * @coeff_passive_pl > (hp_en + damage_pl) / 2
        accurasy_action_en *= 0.1*rand(1..9)
        puts "атака ошеломила врага, уменьшив его точность до #{(accurasy_en * 0.1 * rand(1..9)).round}"
      end
    when "Концентрация"
      if hit_miss_pl == 1 and damage_passive_pl > 0
        damage_passive_pl = rand(0..0.1 * (@hero.max_mp_pl * (1 + 0.05 * @lvl_passive_pl) - 100))
        hp_en -= damage_passive_pl
        puts "дополнительный урон от концентрации #{damage_passive_pl.round(1)}"
      end
    end

    if accurasy_action_en >= rand(1..100)
      puts "Вы заблокировали #{100 - (100 / (1 + @hp_pl.to_f / 200)).to_i}% урона" if @block_pl >= chanse_block_pl
      @hp_pl -= damage_en
      puts "#{name_en} нанес #{damage_en.round} урона #{target_name_en}"
      hit_miss_en = 1
    else
      puts "#{name_en} промахнулся #{target_name_en}"
      hit_miss_en = 0
    end
    #------------------------------------------------------------------------------------------------------------------

    # Доп эффекты(регенерация)------------------------------------------------------------------------------
    if (@hero.max_hp_pl - @hp_pl) >= regen_hp_pl and regen_hp_pl > 0
      @hp_pl += regen_hp_pl
      puts "Вы регенерируете #{regen_hp_pl} жизней, теперь у вас #{@hp_pl.round}/#{@hero.max_hp_pl} жизней"
    elsif (@hero.max_hp_pl - @hp_pl) < regen_hp_pl and @hp_pl < @hero.max_hp_pl and regen_hp_pl > 0
      @hp_pl = @hero.max_hp_pl
      puts "Вы регенерируете #{regen_hp_pl} жизней, теперь у вас #{@hp_pl.round}/#{@hero.max_hp_pl} жизней"
    end

    if (@hero.max_mp_pl - @mp_pl) >= regen_mp_pl and regen_mp_pl > 0
      @mp_pl += regen_mp_pl
      puts "Вы регенерируете #{regen_mp_pl} выносливости, теперь у вас #{@mp_pl.round}/#{@hero.max_mp_pl} выносливости"
    elsif (@hero.max_mp_pl - @mp_pl) < regen_mp_pl and @mp_pl < @hero.max_mp_pl and regen_mp_pl > 0
      @mp_pl = @hero.max_mp_pl
      puts "Вы регенерируете #{regen_mp_pl} выносливости, теперь у вас #{@mp_pl.round}/#{@hero.max_mp_pl} выносливости"
    end
    #---------------------------------------------------------------------------------------------------------------

    # Результат обмена ударами --------------------------------------------------------------------------------
    if @hp_pl > 0 and hp_en > 0
      puts "У вас осталось #{@hp_pl.round}/#{@hero.max_hp_pl} жизней и #{@mp_pl.round}/#{@hero.max_mp_pl} выносливости, у #{name_en}а осталось #{hp_en.round} жизней."
    elsif @hp_pl > 0 and hp_en <= 0
      puts "У вас осталось #{@hp_pl.round}/#{@hero.max_hp_pl} жизней и #{@mp_pl.round}/#{@hero.max_mp_pl} выносливости, у #{name_en}а осталось #{hp_en.round} жизней."
      puts "#{name_en} убит, победа!!!"
    elsif @hp_pl <= 0
      puts "Ты убит - слабак!"
      exit
    end
    #------------------------------------------------------------------------------------------------------------------

    # Побег ---------------------------------------------------------------------------------------------------
    if @hp_pl < (@hero.max_hp_pl * 0.15) and @hp_pl > 0 and hp_en > 0
      print 'Ты на пороге смерти. Чтобы убежать введи Y : '
      run_select = gets.strip.upcase
      if run_select == 'Y'
        run_chance = rand(0..2)
        if run_chance >= 1
          puts "Сбежал ссыкло, штраф 5 опыта"
          exp = -5
          run = true
        else
          @hp_pl -= damage_en
          puts "Не удалось убежать #{name_en} нанес #{damage_en.round} урона"
          if @hp_pl <= 0
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
      if (@hero.max_hp_pl - @hp_pl) >= 20
        @hp_pl += 20
      elsif (@hero.max_hp_pl - @hp_pl) < 20 and @hp_pl < @hero.max_hp_pl
        @hp_pl = @hero.max_hp_pl
      end
      puts "Обыскав все вокруг ты нашел зелье восстанавливающее 20 жизней, теперь у тебя #{@hp_pl.round}/#{@hero.max_hp_pl} жизней"
    elsif loot <= 3 and loot >= 2
      puts "Рядом нет ничего ценного"
    elsif loot <= 1
      @hp_pl -= 5
      puts "Пока ты шарил по углам, тебя укусила крыса(-5 жизней), теперь у тебя #{@hp_pl.round}/#{@hero.max_hp_pl} жизней"
      if @hp_pl <= 0
        puts "Ты подох от укуса крысы. Жалкая смерть"
        exit
      end
    end

    if @name_noncombat_pl == "Кладоискатель"
      #stash_magic = rand(1..200) + coeff_noncombat_pl
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
      puts "Эликсир здоровья. Ваши жизни #{@hp_pl.round}/#{@hero.max_hp_pl} увеличиваются на #{bonus_hp}"
      @hero.max_hp_pl += bonus_hp
      @hp_pl += bonus_hp
      puts "Теперь у вас #{@hp_pl.round}/#{@hero.max_hp_pl} жизней"
    elsif stash_magic_treasure <= 20 and stash_magic >= 180
      bonus_mp = rand(1..3)
      puts "Эликсир выносливости. Ваша выносливость #{@mp_pl.round}/#{@hero.max_mp_pl} увеличивается на #{bonus_mp}"
      @hero.max_mp_pl += bonus_mp
      @mp_pl += bonus_mp
      puts "Теперь у вас #{@mp_pl.round}/#{@hero.max_mp_pl} выносливости"
    elsif stash_magic_treasure <= 25 and stash_magic >= 180
      bonus_accuracy = rand(1..2)
      puts "Эликсир точности. Ваша точность #{@hero.accuracy_pl_base} увеличивается на #{bonus_accuracy}"
      @hero.accuracy_pl_base += bonus_accuracy
      puts "Теперь у вас #{@hero.accuracy_pl_base} точности"
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
      puts "Эликсир камня. Ваша броня #{@hero.armor_pl_base} увеличивается на #{bonus_armor}"
      @hero.armor_pl_base += bonus_armor
      puts "Теперь у вас #{@hero.armor_pl_base} брони"
    elsif stash_magic_treasure <= 31 and stash_magic >= 180
      bonus_hp_regen = 1
      puts "Эликсир троля. Регенерация жизней #{@hero.regen_hp_pl_base} увеличивается на #{bonus_hp_regen}"
      @hero.regen_hp_pl_base += bonus_hp_regen
      puts "Теперь у вас #{@hero.regen_hp_pl_base} регенерации жизней"
    elsif stash_magic_treasure <= 32 and stash_magic >= 180
      bonus_mp_regen = 1
      puts "Эликсир единорога. Регенерация выносливости #{@hero.regen_mp_pl_base} увеличивается на #{bonus_mp_regen}"
      @hero.regen_mp_pl_base += bonus_mp_regen
      puts "Теперь у вас #{@hero.regen_mp_pl_base} регенерации выносливости"
    end

    weapon_loot = rand(0..1)
    if weapon_loot == 1 and weapon_en != "без оружия"
      puts "Обыскав труп #{name_en} ты нашел #{weapon_en}"
      print "Поменяем #{@weapon}(#{@mindam_weapon}-#{@maxdam_weapon}) на #{weapon_en}(#{mindam_weapon_en}-#{maxdam_weapon_en}) Y/N? "
      weapon_loot_choice = gets.strip.upcase
      if weapon_loot_choice == 'Y'
        @weapon = weapon_en
        @mindam_weapon = mindam_weapon_en
        @maxdam_weapon = maxdam_weapon_en
        @mindam_pl = @hero.mindam_pl_base + @mindam_weapon
        @maxdam_pl = @hero.maxdam_pl_base + @maxdam_weapon
      end
    end

    torso_loot = rand(0..1)
    if torso_loot == 1 and torso_en != "без нагрудника"
      puts "Обыскав труп #{name_en} ты нашел #{torso_en}"
      print "Поменяем #{@torso}(#{@armor_torso}) на #{torso_en}(#{armor_torso_en}) Y/N? "
      torso_loot_choice = gets.strip.upcase
      if torso_loot_choice == 'Y'
        @torso = torso_en
        @armor_torso = armor_torso_en
      end
    end

    helmet_loot = rand(0..1)
    if helmet_loot == 1 and helmet_en != "без шлема"
      puts "Обыскав труп #{name_en} ты нашел #{helmet_en}"
      print "Поменяем #{@helmet}(#{@armor_helmet}) на #{helmet_en}(#{armor_helmet_en}) Y/N? "
      helmet_loot_choice = gets.strip.upcase
      if helmet_loot_choice == 'Y'
        @helmet = helmet_en
        @armor_helmet = armor_helmet_en
      end
    end

    gloves_loot = rand(0..1)
    if gloves_loot == 1 and gloves_en != "без перчаток"
      puts "Обыскав труп #{name_en} ты нашел #{gloves_en}"
      print "Поменяем #{@gloves}(бр-#{@armor_gloves} точ-#{@accuracy_gloves}) на #{gloves_en}(бр-#{armor_gloves_en} точ-#{accurasy_gloves_en}) Y/N? "
      gloves_loot_choice = gets.strip.upcase
      if gloves_loot_choice == 'Y'
        @gloves = gloves_en
        @armor_gloves = armor_gloves_en
        @accuracy_gloves = accurasy_gloves_en
      end
    end

    shield_loot = rand(0..1)
    if shield_loot == 1 and shield_en != "без щита"
      puts "Обыскав труп #{name_en} ты нашел #{shield_en}"
      print "Поменяем #{@shield}(бр-#{@armor_shield} блок-#{@block_shield}) на #{shield_en}(бр-#{armor_shield_en} блок-#{block_shield_en}) Y/N? "
      shield_loot_choice = gets.strip.upcase
      if shield_loot_choice == 'Y'
        @shield = shield_en
        @armor_shield = armor_shield_en
        @block_shield = block_shield_en
      end
    end

    regen_hp_pl = @hero.regen_hp_pl_base
    regen_mp_pl = @hero.regen_mp_pl_base
    @hero.recovery_hp_pl = @hero.max_hp_pl * 0.1
    @hero.recovery_mp_pl = @hero.max_mp_pl * 0.1
    @armor_pl = @hero.armor_pl_base + @armor_torso + @armor_helmet + @armor_gloves + @armor_shield
    @accuracy_pl = @hero.accuracy_pl_base + @accuracy_gloves
    @block_pl = @block_shield
  end
  #-------------------------------------------------------------------------------------------------------------
  puts
  # Получение опыта и очков -------------------------------------------------------------------------------------
  @exp_lvl = [0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200]
  @hero.exp_pl += exp
  puts "Вы получили #{exp} опыта. Теперь у вас #{@hero.exp_pl} опыта"
  for i in 0...@exp_lvl.size
    if @hero.exp_pl >= @exp_lvl[i] and @hero.lvl_pl < i
      new_points = i - @hero.lvl_pl
      @hero.stat_points += new_points
      skill_new_points = i - @hero.lvl_pl
      @hero.skill_points += skill_new_points
      @hero.lvl_pl += (i - @hero.lvl_pl)
      puts "Вы получили новый уровень, теперь ваш уровень #{@hero.lvl_pl}й"
      puts "Вы получили #{new_points} очков характеристик и #{skill_new_points} очков навыков"
      puts "У вас теперь #{@hero.stat_points} очков характеристик и #{@hero.skill_points} очков навыков"
    end
  end

  #-----------------------------------------------------------------------------------------------------------------
  puts '-------------------------------------------------------------------------------------------------'
  leveling += 1
end
#====================================================================================================================












#
