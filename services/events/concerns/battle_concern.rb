module BattleConcern

  # In your class you need variabels:
  # @messages   for example with MainMessage.new
  # @hero       with charater object
  # @enemy      with enemy object

  def battle(message='Event enemy')
    enemy_show(message)
    course_of_battle()
    after_battle()
  end

  def enemy_show(message='Event enemy')
    @messages.clear_log
    @messages.main = message
    MainRenderer.new(:enemy_1_choose_screen, @enemy, entity: @messages, arts: [{ mini: @enemy }]).display
    gets
    @battle_messages = AttacksRoundMessage.new
    @battle_messages.main = 'To continue press Enter'
    @battle_messages.actions = "++++++++++++ Event Battle ++++++++++++"
    choose = nil
    until [''].include?(choose)
      MainRenderer.new(:enemy_start_screen, @enemy, entity: @battle_messages, arts: [{ normal: @enemy }]).display
      choose = gets.strip.upcase
      AmmunitionShow.show_weapon_buttons_actions(choose, @enemy)
    end
  end

  def course_of_battle
    @battle_messages = AttacksRoundMessage.new unless @battle_messages
    @hero_run_from_battle = false
    while @enemy.hp > 0 && @hero_run_from_battle == false
      round = AttacksRound.new(@hero, @enemy, @battle_messages)
      round.action
      @hero_run_from_battle = round.hero_run?
      break if round.hero_dead?
    end
  end

  def after_battle
    # Gaining experience and points
    if !@hero_run_from_battle
      HeroActions.add_exp_and_hero_level_up(@hero, @enemy.exp_gived, @messages)
      @messages.main = 'To continue press Enter'
      MainRenderer.new(:messages_screen, entity: @messages, arts: [{ exp_gained: :exp_gained }]).display
      @messages.clear_log
      gets
    end
    # statistics are not implemented for events yet:
    # @hero.statistics.add_enemy_to_data(@enemy.code_name) if !@hero_run_from_battle
    # Loot and other awards:
    LootRound.new(@hero, @enemy, @hero_run_from_battle).action
  end

end
