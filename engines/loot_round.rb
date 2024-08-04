class LootRound
  def initialize(hero, enemy, run)
    @hero, @enemy, @run = hero, enemy, run
    @messages = MainMessage.new
  end

  def action
    return if @run
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
    FieldLoot.new(@hero, @messages).looting
    SecretLoot.new(@hero, @messages).looting
    display_message_screen_with_confirm_and_change_screen()
  end

  private

  def display_message_screen_with_confirm_and_change_screen
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    gets
    puts "\e[H\e[2J"
  end
end
