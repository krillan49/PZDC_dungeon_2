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
  end

  private

  def weapon_loot
    @messages.log << "Обыскав труп #{@enemy.name} ты нашел #{@enemy.weapon.name}"
    @messages.main = "Поменяем #{@hero.weapon.name}(#{@hero.weapon.min_dmg}-#{@hero.weapon.max_dmg}) на #{@enemy.weapon.name}(#{@enemy.weapon.min_dmg}-#{@enemy.weapon.max_dmg}) y/N?"
    display_message_screen
    @hero.weapon = @enemy.weapon if gets.strip.upcase == 'Y'
  end

  def body_armor_loot
    @messages.log << "Обыскав труп #{@enemy.name} ты нашел #{@enemy.body_armor.name}"
    @messages.main = "Поменяем #{@hero.body_armor.name}(#{@hero.body_armor.armor}) на #{@enemy.body_armor.name}(#{@enemy.body_armor.armor}) y/N?"
    display_message_screen
    @hero.body_armor = @enemy.body_armor if gets.strip.upcase == 'Y'
  end

  def head_armor_loot
    @messages.log << "Обыскав труп #{@enemy.name} ты нашел #{@enemy.head_armor.name}"
    @messages.main = "Поменяем #{@hero.head_armor.name}(#{@hero.head_armor.armor}) на #{@enemy.head_armor.name}(#{@enemy.head_armor.armor}) y/N?"
    display_message_screen
    @hero.head_armor = @enemy.head_armor if gets.strip.upcase == 'Y'
  end

  def arms_armor_loot
    @messages.log << "Обыскав труп #{@enemy.name} ты нашел #{@enemy.arms_armor.name}"
    @messages.main = "Поменяем #{@hero.arms_armor.name}(бр-#{@hero.arms_armor.armor} точ-#{@hero.arms_armor.accuracy}) на #{@enemy.arms_armor.name}(бр-#{@enemy.arms_armor.armor} точ-#{@enemy.arms_armor.accuracy}) y/N?"
    display_message_screen
    @hero.arms_armor = @enemy.arms_armor if gets.strip.upcase == 'Y'
  end

  def shield_loot
    @messages.log << "Обыскав труп #{@enemy.name} ты нашел #{@enemy.shield.name}"
    @messages.main = "Поменяем #{@hero.shield.name}(бр-#{@hero.shield.armor} блок-#{@hero.shield.block_chance}) на #{@enemy.shield.name}(бр-#{@enemy.shield.armor} блок-#{@enemy.shield.block_chance}) y/N?"
    display_message_screen
    @hero.shield = @enemy.shield if gets.strip.upcase == 'Y'
  end

  private

  def display_message_screen
    puts "\e[H\e[2J"
    MainRenderer.new(:messages_screen, entity: @messages).display
  end
end
















#
