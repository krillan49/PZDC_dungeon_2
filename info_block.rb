module InfoBlock
  def InfoBlock.enemy_start_stats_info(enemy)
    puts "В бой! Ваш противник #{enemy.name}"
    puts "HP #{enemy.hp}"
    puts "Damage #{enemy.min_dmg}-#{enemy.max_dmg} = #{enemy.min_dmg_base}-#{enemy.max_dmg_base} + #{enemy.weapon.min_dmg}-#{enemy.weapon.max_dmg}(#{enemy.weapon.name})"
    puts "Armor #{enemy.armor} = #{enemy.armor_base} + #{enemy.body_armor.armor}(#{enemy.body_armor.name}) + #{enemy.head_armor.armor}(#{enemy.head_armor.name}) + #{enemy.arms_armor.armor}(#{enemy.arms_armor.name}) + #{enemy.shield.armor}(#{enemy.shield.name})"
    puts "Accurasy #{enemy.accuracy} = #{enemy.accuracy_base} + #{enemy.arms_armor.accuracy}(#{enemy.arms_armor.name})"
    puts "Block #{enemy.block_chance} = #{enemy.shield.block_chance}(#{enemy.shield.name})"
  end
end
