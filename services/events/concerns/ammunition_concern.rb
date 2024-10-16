module AmmunitionConcern

  # In your class you need variabels:
  # @messages   for example with MainMessage.new
  # @hero       with charater object

  def weapon_loot(weapon_obj, message='Change weapon?')
    @messages.main = message
    display_loot_screen(:weapon, @hero.weapon, weapon_obj)
    @hero.weapon = weapon_obj if gets.strip.upcase == 'Y'
  end

  def body_armor_loot(body_armor_obj, message='Change body armor?')
    @messages.main = message
    display_loot_screen(:body_armor, @hero.body_armor, body_armor_obj)
    @hero.body_armor = body_armor_obj if gets.strip.upcase == 'Y'
  end

  def head_armor_loot(head_armor_obj, message='Change head armor?')
    @messages.main = message
    display_loot_screen(:head_armor, @hero.head_armor, head_armor_obj)
    @hero.head_armor = head_armor_obj if gets.strip.upcase == 'Y'
  end

  def arms_armor_loot(arms_armor_obj, message='Change arms armor?')
    @messages.main = message
    display_loot_screen(:arms_armor, @hero.arms_armor, arms_armor_obj)
    @hero.arms_armor = arms_armor_obj if gets.strip.upcase == 'Y'
  end

  def shield_loot(shield_obj, message='Change shield?')
    @messages.main = message
    display_loot_screen(:shield, @hero.shield, shield_obj)
    @hero.shield = shield_obj if gets.strip.upcase == 'Y'
  end

  def display_loot_screen(ammunition_type, hero_ammunition_obj, enemy_ammunition_obj)
    MainRenderer.new(
      :"loot_enemy_#{ammunition_type}",
      hero_ammunition_obj,
      enemy_ammunition_obj,
      entity: @messages,
      arts: [{normal: hero_ammunition_obj}, {normal: enemy_ammunition_obj}]
    ).display
  end

end
