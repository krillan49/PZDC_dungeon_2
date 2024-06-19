require 'yaml'

module InfoBlock
  def InfoBlock.hero_stats_info(hero)
    puts InfoBlock.hero_name_level_exp(hero)
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

  def InfoBlock.hero_name_level_exp(hero)
    menu = YAML.safe_load_file('data/arts/menues.yml', symbolize_names: true)[:name_level_exp]
    name = menu[1].gsub(/[^N]/,'').size
    lvl = menu[1].gsub(/[^L]/,'').size
    exp1, exp2 = menu[1].gsub(/[^E]/,'').size, menu[1].gsub(/[^X]/,'').size
    res = InfoBlock.length_updater N: [name, hero.name],
                                   L: [lvl, hero.lvl.to_s],
                                   E: [exp1, hero.exp.to_s],
                                   X: [exp2, hero.exp_lvl[hero.lvl + 1].to_s]
    menu[1] = InfoBlock.incerter(menu[1], res)
    menu
  end

  def InfoBlock.enemy_start_stats_info(enemy)
    puts "В бой! Ваш противник #{enemy.name}"
    puts "HP #{enemy.hp}"
    puts "Damage #{enemy.min_dmg}-#{enemy.max_dmg} = #{enemy.min_dmg_base}-#{enemy.max_dmg_base} + #{enemy.weapon.min_dmg}-#{enemy.weapon.max_dmg}(#{enemy.weapon.name})"
    puts "Armor #{enemy.armor} = #{enemy.armor_base} + #{enemy.body_armor.armor}(#{enemy.body_armor.name}) + #{enemy.head_armor.armor}(#{enemy.head_armor.name}) + #{enemy.arms_armor.armor}(#{enemy.arms_armor.name}) + #{enemy.shield.armor}(#{enemy.shield.name})"
    puts "Accurasy #{enemy.accuracy} = #{enemy.accuracy_base} + #{enemy.arms_armor.accuracy}(#{enemy.arms_armor.name})"
    puts "Block #{enemy.block_chance} = #{enemy.shield.block_chance}(#{enemy.shield.name})"
  end

  private

  def InfoBlock.length_updater(hh)
    hh.each do |k, (size, v)|
      half_min = (size - v.size) / 2
      half_max = size - v.size - half_min
      hh[k] = ' ' * half_max + v + ' ' * half_min
    end
  end

  def InfoBlock.incerter(str, hh)
    hh.each do |k, v|
      str = str.sub(/#{k}+/, v)
    end
    str
  end

end

# class TestHero
#   attr_reader :name, :exp, :lvl, :exp_lvl
#   def initialize
#     @name = 'Vasya'
#     @exp = rand(0..199)
#     @lvl = rand(0..15)
#     @exp_lvl = [0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200]
#   end
# end
#
# puts InfoBlock.name_level_exp(TestHero.new)














#
