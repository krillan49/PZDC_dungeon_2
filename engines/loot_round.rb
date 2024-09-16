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
  end

  def pzdc_monolith_loot()
    PzdcMonolithLoot.new(@hero, @enemy, @messages).looting
  end

  def enemy_loot
    EnemyLoot.new(@hero, @enemy, @messages).looting
  end

end
