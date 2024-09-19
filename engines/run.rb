class Run
  def initialize(hero, leveling)
    @hero = hero
    @leveling = leveling

    @enemy = nil
    @hero_run_from_battle = false
    @messages = MainMessage.new

    @exit_to_main = false
  end

  def start
    (1..Float::INFINITY).each do |n|
      hero_update()
      save_and_exit()
      break if @exit_to_main
      camp_actions()
      if n.even? # event
        # one_event_test()
        event_choose()
      else # enemy
        enemy_choose()
        enemy_show()
        battle()
        break if @exit_to_main
        after_battle()
      end
      break if @exit_to_main
    end
  end

  def hero_update
    HeroUpdator.new(@hero).spend_stat_points # распределение очков характеристик
    HeroUpdator.new(@hero).spend_skill_points # распределение очков навыков  (тут вызывается старое меню, потом доделать)
  end

  def save_and_exit
    choose = nil
    until ['Y', 'N', ''].include?(choose)
      @messages.main = 'Save this run and exit game? [y/N]'
      MainRenderer.new(:hero_update_screen, @hero, @hero, entity: @messages).display
      choose = gets.strip.upcase
      if choose == 'Y'
        # сохранение персонажа
        SaveHeroInRun.new(@hero, @leveling).save
        @exit_to_main = true # exit
      end
      show_weapon_buttons_actions(choose, @hero)
    end
  end

  def camp_actions
    HeroUseSkill.camp_skill(@hero, @messages)
    HeroActions.rest(@hero, @messages)
    @messages.clear_log
    OccultLibraryEnhanceEngine.new(@hero).start
  end

  # enemy

  def enemy_choose
    enemy1 = EnemyCreator.new(@leveling, @hero.dungeon_name).create_new_enemy
    enemy2 = EnemyCreator.new(@leveling, @hero.dungeon_name).create_new_enemy
    enemy3 = EnemyCreator.new(@leveling, @hero.dungeon_name).create_new_enemy
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
    @attacks_round_messages.actions = "++++++++++++ Battle #{@leveling + 1} ++++++++++++"
    choose = nil
    until [''].include?(choose)
      MainRenderer.new(:enemy_start_screen, @enemy, entity: @attacks_round_messages, arts: [{ normal: @enemy }]).display
      choose = gets.strip.upcase
      show_weapon_buttons_actions(choose, @enemy)
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
    # Сбор лута
    loot = LootRound.new(@hero, @enemy, @hero_run_from_battle)
    loot.action
    if @enemy.code == 'boss'
      @exit_to_main = true
      @messages.main = 'Boss killed. To continue press Enter'
      MainRenderer.new(:run_end_screen, entity: @messages, arts: [{ end: :run_end_art }]).display
      gets
      DeleteHeroInRun.new(@hero).add_camp_loot_and_delete_hero_file
      return
    end
    @leveling += 1
  end

  # event

  # def one_event_test
  #   EventCreator.new(@leveling, @hero.dungeon_name).create_new_event(1).sample.new(@hero).start
  # end

  def event_choose
    events_count, message = generate_events_count()
    return if events_count == 0
    event_constants = EventCreator.new(@leveling, @hero.dungeon_name).create_new_event(events_count)
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

  private

  def show_weapon_buttons_actions(distribution, character)
    if distribution == 'A' # show all ammunition
    elsif %w[B C D E F].include?(distribution) # show chosen ammunition
      ammunition_type = {B: 'weapon', C: 'head_armor', D: 'body_armor', E: 'arms_armor', F: 'shield'}[distribution.to_sym]
      ammunition_obj = character.send(ammunition_type)
      if ammunition_obj.code != 'without'
        AmmunitionShow.display(obj: ammunition_obj, type: ammunition_type, arts: [{normal: ammunition_obj}])
      end
    end
  end

end

















#
