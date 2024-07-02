require_relative "attacks_round"
require_relative "loot"

# renderers ---------------------------
require_relative "renderers/arts/arts"
require_relative "renderers/menues/menues"
require_relative "renderers/info_block"

# savers ------------------------------
require_relative "savers/save_hero"
require_relative "savers/load_hero"

# controllers -------------------------
# ammunition
require_relative "controllers/ammunition/ammunition_creator"
# skills
require_relative "controllers/skills/skills_creator"
# characters
require_relative "controllers/characters/enemy_creator"
require_relative "controllers/characters/hero_creator"
require_relative "controllers/characters/hero_updator"

# models ------------------------------
# ammunition
require_relative "models/ammunition/arms_armor"
require_relative "models/ammunition/body_armor"
require_relative "models/ammunition/head_armor"
require_relative "models/ammunition/shield"
require_relative "models/ammunition/weapon"
# skills
require_relative "models/skills/concentration"
require_relative "models/skills/dazed"
require_relative "models/skills/first_aid"
require_relative "models/skills/precise_strike"
require_relative "models/skills/shield_master"
require_relative "models/skills/strong_strike"
require_relative "models/skills/treasure_hunter"
# characters
require_relative "models/characters/enemy"
require_relative "models/characters/hero"




# TODO
# разбить фаилы по категориям
# вынести методы действий с выводом сообщений из модели hero в контроллер чето типм хиро_скилл_юзер, ? либо вынести сообщения в данные ?



def confirm_and_change_screen
  print 'Чтобы продолжить нажмите Enter'
  gets
  puts "\e[H\e[2J"
end

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
    load_hero = LoadHero.new
    load_hero.load
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

  confirm_and_change_screen()

  print "\nautosave..."
  SaveHero.new(@hero, leveling).save
  puts "done\n"

  @hero.use_camp_skill # Навык Первая помощь
  @hero.rest # пассивное восстановления жизней и маны между боями

  confirm_and_change_screen()

  puts "++++++++++++++++++++++++++++++++++++++ Бой #{leveling + 1} +++++++++++++++++++++++++++++++++++++++++++++++++"

  @enemy = EnemyCreator.new(leveling).create_new_enemy # Назначение противника

  # Характеристики противника
  puts InfoBlock.enemy_name(@enemy)
  Menu.new(:character_stats, @enemy).display

  confirm_and_change_screen()

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

  confirm_and_change_screen()

  puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

  # Сбор лута
  if run == false
    EnemyLoot.new(@hero, @enemy).looting
    FieldLoot.new(@hero).looting
    SecretLoot.new(@hero).looting
  end

  @hero.add_exp_and_hero_level_up(@enemy.exp_gived) if !run # Получение опыта и очков

  confirm_and_change_screen()

  puts '-------------------------------------------------------------------------------------------------'
  leveling += 1
end












#
