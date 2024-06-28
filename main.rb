require_relative "hero_creator"
require_relative "hero_updator"
require_relative "enemy_creator"
require_relative "skills_creator"
require_relative "attacks_round"
require_relative "hero"
require_relative "skills"
require_relative "enemyes"
require_relative "weapons"
require_relative "loot"
require_relative "menues"
require_relative "info_block"
require_relative "arts"
require_relative "save_hero"



while !@hero
  print 'Ведите 1 чтобы загрузить персонажа, введите 2 чтобы создать нового персонажа '
  new_load = gets.strip
  if new_load == '2'
    @hero = HeroCreator.new.create_new_hero # Создание нового персонажа
    leveling = 0
    print "\nautosave..."
    SaveHero.new(@hero, leveling).save
    puts "done\n"
  else
    load_hero = LoadHero.new.load
    @hero = load_hero.hero
    leveling = load_hero.leveling
  end
end

# Основной игровой блок
while true

  HeroUpdator.new(@hero).spend_stat_points # распределение очков характеристик
  HeroUpdator.new(@hero).spend_skill_points # распределение очков навыков  (тут вызывается старое меню, потом доделать)

  # Характеристики персонажа
  puts InfoBlock.hero_name_level_exp(@hero)
  Menu.new(:character_stats, @hero).display
  puts InfoBlock.character_skills(@hero)

  @hero.use_camp_skill # Навык Первая помощь
  @hero.rest # пассивное восстановления жизней и маны между боями

  print "\nautosave..."
  SaveHero.new(@hero, leveling).save
  puts "done\n"

  print 'Чтобы начать следующий бой нажмите Enter'
  gets
  puts "++++++++++++++++++++++++++++++++++++++ Бой #{leveling + 1} +++++++++++++++++++++++++++++++++++++++++++++++++"

  @enemy = EnemyCreator.new(leveling).create_new_enemy # Назначение противника

  # Характеристики противника
  puts InfoBlock.enemy_name(@enemy)
  Menu.new(:character_stats, @enemy).display

  # Ход боя
  run = false
  lap = 1 # номер хода
  while @enemy.hp > 0 && run == false
    puts "====================================== ХОД #{lap} ============================================"

    round = AttacksRound.new(@hero, @enemy)
    round.action
    run = round.hero_run?

    lap += 1 # номер хода
  end

  puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

  # Сбор лута
  if run == false
    EnemyLoot.new(@hero, @enemy).looting
    FieldLoot.new(@hero).looting
    SecretLoot.new(@hero).looting
  end

  @hero.add_exp_and_hero_level_up(@enemy.exp_gived) if !run # Получение опыта и очков

  puts '-------------------------------------------------------------------------------------------------'
  leveling += 1
end












#
