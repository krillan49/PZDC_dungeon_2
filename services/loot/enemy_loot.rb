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
    @messages.log << "Having searched the body #{@enemy.name} you found #{@enemy.weapon.name}"
    @messages.main = "Let's swap #{@hero.weapon.name}(#{@hero.weapon.min_dmg}-#{@hero.weapon.max_dmg}) for a #{@enemy.weapon.name}(#{@enemy.weapon.min_dmg}-#{@enemy.weapon.max_dmg}) y/N?"
    display_message_screen
    @hero.weapon = @enemy.weapon if gets.strip.upcase == 'Y'
  end

  def body_armor_loot
    @messages.log << "Having searched the body #{@enemy.name} you found #{@enemy.body_armor.name}"
    @messages.main = "Let's swap #{@hero.body_armor.name}(#{@hero.body_armor.armor}) for a #{@enemy.body_armor.name}(#{@enemy.body_armor.armor}) y/N?"
    display_message_screen
    @hero.body_armor = @enemy.body_armor if gets.strip.upcase == 'Y'
  end

  def head_armor_loot
    @messages.log << "Having searched the body #{@enemy.name} you found #{@enemy.head_armor.name}"
    @messages.main = "Let's swap #{@hero.head_armor.name}(#{@hero.head_armor.armor}) for a #{@enemy.head_armor.name}(#{@enemy.head_armor.armor}) y/N?"
    display_message_screen
    @hero.head_armor = @enemy.head_armor if gets.strip.upcase == 'Y'
  end

  def arms_armor_loot
    @messages.log << "Having searched the body #{@enemy.name} you found #{@enemy.arms_armor.name}"
    @messages.main = "Let's swap #{@hero.arms_armor.name}(arm-#{@hero.arms_armor.armor} acc-#{@hero.arms_armor.accuracy}) for a #{@enemy.arms_armor.name}(arm-#{@enemy.arms_armor.armor} acc-#{@enemy.arms_armor.accuracy}) y/N?"
    display_message_screen
    @hero.arms_armor = @enemy.arms_armor if gets.strip.upcase == 'Y'
  end

  def shield_loot
    @messages.log << "Having searched the body #{@enemy.name} you found #{@enemy.shield.name}"
    @messages.main = "Let's swap #{@hero.shield.name}(arm-#{@hero.shield.armor} block-#{@hero.shield.block_chance}) for a #{@enemy.shield.name}(arm-#{@enemy.shield.armor} block-#{@enemy.shield.block_chance}) y/N?"
    display_message_screen
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

  def display_message_screen
    MainRenderer.new(:messages_screen, entity: @messages).display
  end
end
















#
