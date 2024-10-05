class Run
  def initialize(hero)
    @hero = hero

    @enemy = nil
    @hero_run_from_battle = false
    @messages = MainMessage.new

    @exit_to_main = false
  end

  def start
    loop do
      hero_update()
      save_and_exit()
      break if @exit_to_main
      camp_actions()
      if @hero.dungeon_part_number.even? # event
        event_choose()
      else # enemy
        enemy_choose()
        enemy_show()
        battle()
        break if @exit_to_main
        after_battle()
      end
      break if @exit_to_main
      @hero.dungeon_part_number += 1
    end
  end

  def hero_update
    HeroUpdator.new(@hero).spend_stat_points
    HeroUpdator.new(@hero).spend_skill_points
  end

  def save_and_exit
    choose = nil
    until ['Y', 'N', ''].include?(choose)
      @messages.main = 'Save this run and exit game? [y/N]'
      @messages.log = ["#{@hero.dungeon_name.capitalize}"]
      MainRenderer.new(
        :hero_sl_screen,
        @hero, @hero,
        entity: @messages,
        arts: [ { normal: :"dungeons/_#{@hero.dungeon_name}" }]
      ).display
      choose = gets.strip.upcase
      if choose == 'Y'
        @hero.statistics.update # сохранение статистики забега
        SaveHeroInRun.new(@hero).save # сохранение персонажа
        @exit_to_main = true # exit
      end
      AmmunitionShow.show_weapon_buttons_actions(choose, @hero)
    end
  end

  def camp_actions
    @messages.clear_log
    HeroActions.rest(@hero, @messages)
    HeroUseSkill.camp_skill(@hero, @messages)
    @messages.clear_log
    OccultLibraryEnhanceEngine.new(@hero).start
  end

  # enemy

  def enemy_choose
    enemy1 = EnemyCreator.new(@hero.leveling, @hero.dungeon_name).create_new_enemy
    enemy2 = EnemyCreator.new(@hero.leveling, @hero.dungeon_name).create_new_enemy
    enemy3 = EnemyCreator.new(@hero.leveling, @hero.dungeon_name).create_new_enemy
    enemyes_count, message = generate_enemy_count(enemy1)
    enemyes = [enemy1, enemy2, enemy3][0, enemyes_count]
    n = 9000
    @messages.main = message
    until n >= 1 && n <= enemyes.length
      MainRenderer.new(
        [:enemy_1_choose_screen, :enemy_2_choose_screen, :enemy_3_choose_screen][enemyes_count-1],
        *enemyes,
        entity: @messages,
        arts: enemyes.map{|enemy| { mini: enemy } }
      ).display
      n = gets.to_i
      if n >= 1 && n <= enemyes.length
        @enemy = enemyes[n-1]
      else
        @messages.main = 'There is no such way. Which way will you go?'
      end
    end
  end

  def generate_enemy_count(enemy)
    return [1, "You've reached the end of the dungeon, this is a boss fight!"] if enemy.code == 'boss'
    random = rand(1..200)
    th = @hero.camp_skill.code == 'treasure_hunter' ? @hero.camp_skill.coeff_lvl : 0
    res = random + th
    n = res > 120 ? 3 : res > 50 ? 2 : 1
    [n, "Random is #{random}" + (th == 0 ? '' : " + treasure hunter #{th}") + " = you find #{n} ways. Which way will you go?"]
  end

  def enemy_show
    @attacks_round_messages = AttacksRoundMessage.new
    @attacks_round_messages.main = 'To continue press Enter'
    @attacks_round_messages.actions = "++++++++++++ Battle #{@hero.leveling + 1} ++++++++++++"
    choose = nil
    until [''].include?(choose)
      MainRenderer.new(:enemy_start_screen, @enemy, entity: @attacks_round_messages, arts: [{ normal: @enemy }]).display
      choose = gets.strip.upcase
      AmmunitionShow.show_weapon_buttons_actions(choose, @enemy)
    end
  end

  def battle
    @hero_run_from_battle = false
    # lap = 1 # номер хода
    while @enemy.hp > 0 && @hero_run_from_battle == false
      round = AttacksRound.new(@hero, @enemy, @attacks_round_messages)
      round.action
      @hero_run_from_battle = round.hero_run?
      if round.hero_dead?
        @exit_to_main = true
        break
      end
      # lap += 1
    end
  end

  def after_battle
    # Получение опыта и очков
    if !@hero_run_from_battle
      HeroActions.add_exp_and_hero_level_up(@hero, @enemy.exp_gived, @messages)
      @messages.main = 'To continue press Enter'
      MainRenderer.new(:messages_screen, entity: @messages, arts: [{ exp_gained: :exp_gained }]).display
      @messages.clear_log
      gets
    end
    # статистика
    @hero.statistics.add_enemy_to_data(@enemy.code_name) if !@hero_run_from_battle
    # Сбор лута
    loot = LootRound.new(@hero, @enemy, @hero_run_from_battle)
    loot.action
    if @enemy.code == 'boss' && !@hero_run_from_battle
      @exit_to_main = true
      @messages.main = 'Boss killed. To continue press Enter'
      DeleteHeroInRun.new(@hero, false, @messages).add_camp_loot_and_delete_hero_file
      return
    end
    @hero.leveling += 1
  end

  # event

  def event_choose
    events_count, message = generate_events_count()
    return if events_count == 0
    event_constants = EventCreator.new(@hero.leveling, @hero.dungeon_name).create_new_event(events_count)
    events = event_constants.map{|const| const.new(@hero)}
    n = 9000
    @messages.main = message + 'Which way will you go?'
    until n >= 0 && n <= events.length
      @event = nil # для повторного вызова и других раундов
      MainRenderer.new(
        [:event_1_choose_screen, :event_2_choose_screen, :event_3_choose_screen][events_count-1],
        *events,
        entity: @messages,
        arts: events.map{|event| { mini: event } }
      ).display
      n = gets.to_i
      if n >= 1 && n <= events.length
        @event = events[n-1]
      else
        @messages.main = 'There is no such way. Which way will you go?'
      end
    end
    if @event
      hero_exit_run = @event.start
      if @hero.hp <= 0 || hero_exit_run == 'exit_run'
        @exit_to_main = true
        return
      end
    end
  end

  def generate_events_count
    random = rand(1..200)
    th = @hero.camp_skill.code == 'treasure_hunter' ? @hero.camp_skill.coeff_lvl : 0
    res = random + th
    n = res > 150 ? 3 : res > 80 ? 2 : 1
    [n, "Random is #{random}" + (th == 0 ? '' : " + treasure hunter #{th}") + " = you find #{n} ways. "]
  end

end

















#
