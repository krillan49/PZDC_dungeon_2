class LootRound
  def initialize(hero, enemy, run)
    @hero, @enemy, @run = hero, enemy, run
    @messages = MainMessage.new
  end

  def hero_dead?
    @hero.hp <= 0
  end

  def action
    return if @run || hero_dead?
    pzdc_monolith_loot()
    @messages.clear_log
    enemy_loot()
    @messages.clear_log
    other_loot()
  end

  def pzdc_monolith_loot()
    PzdcMonolithLoot.new(@hero, @enemy, @messages).looting
  end

  def enemy_loot
    EnemyLoot.new(@hero, @enemy, @messages).looting
  end

  def other_loot
    fl = FieldLoot.new(@hero, @messages)
    fl.looting
    return if fl.hero_dead?
    SecretLoot.new(@hero, @messages).looting
    display_message_screen_with_confirm_and_change_screen()
  end

  private

  def display_message_screen_with_confirm_and_change_screen
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    gets
  end
end
