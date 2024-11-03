class RunBoss
  def initialize(hero)
    @hero = hero

    @enemy = nil
    @hero_run_from_battle = false
    @messages = MainMessage.new

    @exit_to_main = false
  end

  def start
    monolith_gifts() if @hero.exp == 0
    camp_fire_actions()
    loop do
      @messages.clear_log
      break if @exit_to_main
      enemy_mutation() if @hero.leveling > 0
      enemy_choose()
      enemy_show()
      battle()
      break if @exit_to_main
      after_battle()
      @hero.leveling += 1
      boss_defeat() if @hero.leveling >= 3
      break if @exit_to_main
      @messages.clear_log
    end
  end

  def monolith_gifts
    exp = 150
    @messages.main = 'To continue press Enter'
    @messages.log << "PZDC Monolith gives you #{exp} exp"
    MainRenderer.new(:messages_screen, entity: @messages, arts: [{ camp: :pzdc_monolith }]).display
    @messages.clear_log
    gets
    HeroActions.add_exp_and_hero_level_up(@hero, exp, @messages)
    MainRenderer.new(:messages_screen, entity: @messages, arts: [{ exp_gained: :exp_gained }]).display
    @messages.clear_log
    gets
  end

  def camp_fire_actions
    cfe = CampFireEngine.new(@hero, @messages)
    cfe.start
    @exit_to_main = cfe.exit_to_main
  end

  def enemy_mutation
    %i[normal mutation1 mutation2 mutation_final].each do |art|
      MainRenderer.new(
        :messages_screen,
        entity: @messages,
        arts: [ {art => :"enemyes/pzdc/_stage_#{@hero.leveling}_to_#{@hero.leveling+1}" } ]
      ).display
      gets
    end
  end

  def enemy_choose
    @enemy = Enemy.new("e#{@hero.leveling+1}", @hero.dungeon_name)
    @messages.main = 'Boss fight'
    MainRenderer.new( :enemy_1_choose_screen, @enemy, entity: @messages, arts: [ { mini: @enemy } ] ).display
    gets
  end

  def enemy_show
    @attacks_round_messages = AttacksRoundMessage.new
    @attacks_round_messages.main = 'To continue press Enter'
    @attacks_round_messages.actions = "++++++++++++ Stage #{@hero.leveling+1} ++++++++++++"
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
    if !@hero_run_from_battle
      # статистика
      @hero.statistics.add_enemy_to_data(@enemy.code_name)
      # Сбор лута
      EnemyLoot.new(@hero, @enemy, @messages).looting
    end
  end

  def boss_defeat
    if !@hero_run_from_battle
      @exit_to_main = true
      @messages.main = 'Boss killed. To continue press Enter'
      DeleteHeroInRun.new(@hero, :dungeon_completed, @messages).add_camp_loot_and_delete_hero_file
      return
    end
  end

end

















#
