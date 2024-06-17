module InfoBlock
  def InfoBlock.hero_stats_info(hero)
    puts '--------------------------------------------------------------------------------------------'
    puts '--------------------------------------------------------------------------------------------'
    puts "#{hero.name}"
    puts "Уровень #{hero.lvl} (#{hero.exp}/#{hero.exp_lvl[hero.lvl + 1]})"
    puts "Н А В Ы К И:"
    puts "[акт] #{hero.active_skill.name} #{hero.active_skill.description}"
    puts "[пас] #{hero.passive_skill.name} #{hero.passive_skill.description}"
    puts "[неб] #{hero.camp_skill.name} #{hero.camp_skill.description}"
    puts "С Т А Т Ы:"
    puts "HP #{hero.hp.round}/#{hero.hp_max} Реген #{hero.regen_hp_base} Восстановление #{hero.recovery_hp.round}"
    puts "MP #{hero.mp.round}/#{hero.mp_max} Реген #{hero.regen_mp_base} Восстановление #{hero.recovery_mp.round}"
    puts "Урон #{hero.min_dmg}-#{hero.max_dmg} (базовый #{hero.min_dmg_base}-#{hero.max_dmg_base} + #{hero.weapon.name} #{hero.weapon.min_dmg}-#{hero.weapon.max_dmg})"
    puts "Точность #{hero.accuracy} (базовая #{hero.accuracy_base} + #{hero.arms_armor.name} #{hero.arms_armor.accuracy})"
    puts "Броня #{hero.armor} (базовая #{hero.armor_base} + #{hero.body_armor.name} #{hero.body_armor.armor} + #{hero.head_armor.name} #{hero.head_armor.armor} + #{hero.arms_armor.name} #{hero.arms_armor.armor} + #{hero.shield.name} #{hero.shield.armor})"
    puts "Шанс блока #{hero.block_chance} (#{hero.shield.name} #{hero.shield.block_chance}) блокируемый урон #{hero.block_power_in_percents}%"
    puts '--------------------------------------------------------------------------------------------'
    puts '--------------------------------------------------------------------------------------------'
  end

  def InfoBlock.enemy_start_stats_info(enemy)
    puts "В бой! Ваш противник #{enemy.name}"
    puts "HP #{enemy.hp}"
    puts "Damage #{enemy.min_dmg}-#{enemy.max_dmg} = #{enemy.min_dmg_base}-#{enemy.max_dmg_base} + #{enemy.weapon.min_dmg}-#{enemy.weapon.max_dmg}(#{enemy.weapon.name})"
    puts "Armor #{enemy.armor} = #{enemy.armor_base} + #{enemy.body_armor.armor}(#{enemy.body_armor.name}) + #{enemy.head_armor.armor}(#{enemy.head_armor.name}) + #{enemy.arms_armor.armor}(#{enemy.arms_armor.name}) + #{enemy.shield.armor}(#{enemy.shield.name})"
    puts "Accurasy #{enemy.accuracy} = #{enemy.accuracy_base} + #{enemy.arms_armor.accuracy}(#{enemy.arms_armor.name})"
    puts "Block #{enemy.block_chance} = #{enemy.shield.block_chance}(#{enemy.shield.name})"
  end
end















#
