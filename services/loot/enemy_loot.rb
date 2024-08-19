class EnemyLoot
  def initialize(hero, enemy, messages)
    @hero = hero
    @enemy = enemy

    @messages = messages
  end

  def looting
    weapon_loot() if rand(0..1) == 1 && @enemy.weapon.code != "without"
    body_armor_loot() if rand(0..1) == 1 && @enemy.body_armor.code != "without"
    head_armor_loot() if rand(0..1) == 1 && @enemy.head_armor.code != "without"
    arms_armor_loot() if rand(0..1) == 1 && @enemy.arms_armor.code != "without"
    shield_loot() if rand(0..1) == 1 && @enemy.shield.code != "without"
    coins_loot() if @enemy.coins_gived > 0
  end

  private

  def weapon_loot
    @messages.main = "Having searched the body #{@enemy.name} you found #{@enemy.weapon.name}"
    display_loot_screen(:weapon)
    @hero.weapon = @enemy.weapon if gets.strip.upcase == 'Y'
  end

  def body_armor_loot
    @messages.main = "Having searched the body #{@enemy.name} you found #{@enemy.body_armor.name}"
    display_loot_screen(:body_armor)
    @hero.body_armor = @enemy.body_armor if gets.strip.upcase == 'Y'
  end

  def head_armor_loot
    @messages.main = "Having searched the body #{@enemy.name} you found #{@enemy.head_armor.name}"
    display_loot_screen(:head_armor)
    @hero.head_armor = @enemy.head_armor if gets.strip.upcase == 'Y'
  end

  def arms_armor_loot
    @messages.main = "Having searched the body #{@enemy.name} you found #{@enemy.arms_armor.name}"
    display_loot_screen(:arms_armor)
    @hero.arms_armor = @enemy.arms_armor if gets.strip.upcase == 'Y'
  end

  def shield_loot
    @messages.main = "Having searched the body #{@enemy.name} you found #{@enemy.shield.name}"
    display_loot_screen(:shield)
    @hero.shield = @enemy.shield if gets.strip.upcase == 'Y'
  end

  def coins_loot
    @hero.coins += @enemy.coins_gived
    @messages.log << "Having searched the body #{@enemy.name} you found #{@enemy.coins_gived} coins. Now you have #{@hero.coins} coins"
    @messages.main = "Мy precious... Press Eenter to continue"
    display_message_screen
    gets
  end

  private

  def display_loot_screen(ammunition_type)
    hero_ammunition_obj = @hero.send(ammunition_type)
    enemy_ammunition_obj = @enemy.send(ammunition_type)
    MainRenderer.new(
      :"loot_enemy_#{ammunition_type}",
      hero_ammunition_obj,
      enemy_ammunition_obj,
      entity: @messages
    ).display
  end

  def display_message_screen
    MainRenderer.new(:messages_screen, entity: @messages).display
  end
end
















#
