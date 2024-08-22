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
    SecretLoot.new(@hero).looting
  end

end
