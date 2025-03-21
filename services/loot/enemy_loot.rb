class EnemyLoot
  def initialize(hero, enemy, messages)
    @hero = hero
    @enemy = enemy

    @messages = messages
  end

  def looting
    weapon_loot() if loot_drop?() && @enemy.weapon.code != "without"
    body_armor_loot() if loot_drop?() && @enemy.body_armor.code != "without"
    head_armor_loot() if loot_drop?() && @enemy.head_armor.code != "without"
    arms_armor_loot() if loot_drop?() && @enemy.arms_armor.code != "without"
    shield_loot() if loot_drop?() && @enemy.shield.code != "without"
    coins_loot() if @enemy.coins_gived > 0
    ingredients_loot() if @enemy.ingredients != "without" #&& rand(0..1) == 1
  end

  private

  def loot_drop?
    if @hero.camp_skill.code == 'treasure_hunter'
      rand(0..1) == 1 || rand(0..150) < @hero.camp_skill.coeff_lvl
    else
      rand(0..1) == 1
    end
  end

  def weapon_loot
    @messages.main = "After searching the #{@enemy.name}'s body you found #{@enemy.weapon.name}"
    display_loot_screen(:weapon, @hero.weapon, @enemy.weapon)
    @hero.weapon = @enemy.weapon if gets.strip.upcase == 'Y'
  end

  def body_armor_loot
    @messages.main = "After searching the #{@enemy.name}'s body you found #{@enemy.body_armor.name}"
    display_loot_screen(:body_armor, @hero.body_armor, @enemy.body_armor)
    @hero.body_armor = @enemy.body_armor if gets.strip.upcase == 'Y'
  end

  def head_armor_loot
    @messages.main = "After searching the #{@enemy.name}'s body you found #{@enemy.head_armor.name}"
    display_loot_screen(:head_armor, @hero.head_armor, @enemy.head_armor)
    @hero.head_armor = @enemy.head_armor if gets.strip.upcase == 'Y'
  end

  def arms_armor_loot
    @messages.main = "After searching the #{@enemy.name}'s body you found #{@enemy.arms_armor.name}"
    display_loot_screen(:arms_armor, @hero.arms_armor, @enemy.arms_armor)
    @hero.arms_armor = @enemy.arms_armor if gets.strip.upcase == 'Y'
  end

  def shield_loot
    @messages.main = "After searching the #{@enemy.name}'s body you found #{@enemy.shield.name}"
    display_loot_screen(:shield, @hero.shield, @enemy.shield)
    @hero.shield = @enemy.shield if gets.strip.upcase == 'Y'
  end

  def coins_loot
    @hero.coins += @enemy.coins_gived
    @messages.log << "After searching the #{@enemy.name}'s body you found #{@enemy.coins_gived} coins. Now you have #{@hero.coins} coins"
    @messages.main = "Мy precious... Press Eenter to continue"
    display_message_screen([{ loot_coins: :loot_coins }])
    gets
  end

  def ingredients_loot
    if @hero.ingredients[@enemy.ingredients]
      @hero.ingredients[@enemy.ingredients] += 1
    else
      @hero.ingredients[@enemy.ingredients] = 1
    end
    ingredient = @enemy.ingredients.tr('_',' ').capitalize
    @messages.main = "After searching the #{@enemy.name}'s body you found #{ingredient}"
    @messages.clear_log
    display_message_screen([{ dead: @enemy }])
    gets
  end

  private

  def display_loot_screen(ammunition_type, hero_ammunition_obj, enemy_ammunition_obj)
    MainRenderer.new(
      :"loot_enemy_#{ammunition_type}",
      hero_ammunition_obj,
      enemy_ammunition_obj,
      entity: @messages,
      arts: [{normal: hero_ammunition_obj}, {normal: enemy_ammunition_obj}]
    ).display
  end

  def display_message_screen(arts=nil)
    MainRenderer.new(:messages_screen, entity: @messages, arts: arts).display
  end
end
















#
