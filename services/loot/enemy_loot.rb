class EnemyLoot
  def initialize(hero, enemy)
    @hero = hero
    @enemy = enemy
  end

  def looting
    weapon_loot() if rand(0..1) == 1 && @enemy.weapon.name != "без оружия"
    body_armor_loot() if rand(0..1) == 1 && @enemy.body_armor.name != "без нагрудника"
    head_armor_loot() if rand(0..1) == 1 && @enemy.head_armor.name != "без шлема"
    arms_armor_loot() if rand(0..1) == 1 && @enemy.arms_armor.name != "без перчаток"
    shield_loot() if rand(0..1) == 1 && @enemy.shield.name != "без щита"
    puts '------------------------------------------------------------------------'
  end

  private

  def weapon_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.weapon.name}"
    print "Поменяем #{@hero.weapon.name}(#{@hero.weapon.min_dmg}-#{@hero.weapon.max_dmg}) на #{@enemy.weapon.name}(#{@enemy.weapon.min_dmg}-#{@enemy.weapon.max_dmg}) y/N? "
    @hero.weapon = @enemy.weapon if gets.strip.upcase == 'Y'
  end

  def body_armor_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.body_armor.name}"
    print "Поменяем #{@hero.body_armor.name}(#{@hero.body_armor.armor}) на #{@enemy.body_armor.name}(#{@enemy.body_armor.armor}) y/N? "
    @hero.body_armor = @enemy.body_armor if gets.strip.upcase == 'Y'
  end

  def head_armor_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.head_armor.name}"
    print "Поменяем #{@hero.head_armor.name}(#{@hero.head_armor.armor}) на #{@enemy.head_armor.name}(#{@enemy.head_armor.armor}) y/N? "
    @hero.head_armor = @enemy.head_armor if gets.strip.upcase == 'Y'
  end

  def arms_armor_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.arms_armor.name}"
    print "Поменяем #{@hero.arms_armor.name}(бр-#{@hero.arms_armor.armor} точ-#{@hero.arms_armor.accuracy}) на #{@enemy.arms_armor.name}(бр-#{@enemy.arms_armor.armor} точ-#{@enemy.arms_armor.accuracy}) y/N? "
    @hero.arms_armor = @enemy.arms_armor if gets.strip.upcase == 'Y'
  end

  def shield_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.shield.name}"
    print "Поменяем #{@hero.shield.name}(бр-#{@hero.shield.armor} блок-#{@hero.shield.block_chance}) на #{@enemy.shield.name}(бр-#{@enemy.shield.armor} блок-#{@enemy.shield.block_chance}) y/N? "
    @hero.shield = @enemy.shield if gets.strip.upcase == 'Y'
  end
end
















# 
