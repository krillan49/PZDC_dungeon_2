require 'yaml'

# Потом переделать в класс, тк один фиг часто вызывать в разных вариантах

module InfoBlock

  def InfoBlock.enemy_start_stats_info(enemy)
    puts InfoBlock.enemy_name(enemy)
    puts "HP #{enemy.hp}"
    puts "Damage #{enemy.min_dmg}-#{enemy.max_dmg} = #{enemy.min_dmg_base}-#{enemy.max_dmg_base} + #{enemy.weapon.min_dmg}-#{enemy.weapon.max_dmg}(#{enemy.weapon.name})"
    puts "Armor #{enemy.armor} = #{enemy.armor_base} + #{enemy.body_armor.armor}(#{enemy.body_armor.name}) + #{enemy.head_armor.armor}(#{enemy.head_armor.name}) + #{enemy.arms_armor.armor}(#{enemy.arms_armor.name}) + #{enemy.shield.armor}(#{enemy.shield.name})"
    puts "Accurasy #{enemy.accuracy} = #{enemy.accuracy_base} + #{enemy.arms_armor.accuracy}(#{enemy.arms_armor.name})"
    puts "Block #{enemy.block_chance} = #{enemy.shield.block_chance}(#{enemy.shield.name})"
  end

  def InfoBlock.hero_stats_info(hero)
    puts InfoBlock.hero_name_level_exp(hero)
    puts InfoBlock.character_skills(hero)
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
    menu = YAML.safe_load_file('graphics/menues/menues.yml', symbolize_names: true)[:hero_name_level_exp]
    name = menu[1].gsub(/[^N]/,'').size
    lvl = menu[1].gsub(/[^L]/,'').size
    exp1 = menu[1].gsub(/[^E]/,'').size
    exp2 = menu[1].gsub(/[^X]/,'').size
    res = InfoBlock.length_updater N: [name, hero.name, :m],
                                   L: [lvl, hero.lvl.to_s, :m],
                                   E: [exp1, hero.exp.to_s, :e],
                                   X: [exp2, hero.exp_lvl[hero.lvl + 1].to_s, :s]
    menu[1] = InfoBlock.incerter(menu[1], res)
    menu
  end

  def InfoBlock.character_skills(hero)
    menu = YAML.safe_load_file('graphics/menues/menues.yml', symbolize_names: true)[:character_skills]
    a_name = menu[3].gsub(/[^A]/,'').size
    a_desc = menu[4].gsub(/[^B]/,'').size
    p_name = menu[6].gsub(/[^P]/,'').size
    p_desc = menu[7].gsub(/[^R]/,'').size
    c_name = menu[9].gsub(/[^C]/,'').size
    c_desc = menu[10].gsub(/[^D]/,'').size
    res = InfoBlock.length_updater A: [a_name, hero.active_skill.name, :s],
                                   B: [a_desc, hero.active_skill.description, :s],
                                   P: [p_name, hero.passive_skill.name, :s],
                                   R: [p_desc, hero.passive_skill.description, :s],
                                   C: [c_name, hero.camp_skill.name, :s],
                                   D: [c_desc, hero.camp_skill.description, :s]
    [3,4,6,7,9,10].each do |i|
      menu[i] = InfoBlock.incerter(menu[i], res)
    end
    menu
  end

  def InfoBlock.enemy_name(enemy)
    menu = YAML.safe_load_file('graphics/menues/menues.yml', symbolize_names: true)[:enemy_name]
    res = InfoBlock.length_updater E: [menu[1].gsub(/[^E]/,'').size, enemy.name, :m]
    menu[1] = InfoBlock.incerter(menu[1], res)
    menu
  end

  # def InfoBlock.character_stats#(character)
  #   code = YAML.safe_load_file('graphics/menues/character_codes.yml', symbolize_names: true)
  #   menu = YAML.safe_load_file('graphics/menues/menues.yml', symbolize_names: true)[:character_stats]
  #   InfoBlock.find_codes_in_menu(menu, code.keys)
  # end

  private

  # def InfoBlock.find_codes_in_menu(menu, code_keys)
  #   menu.map do |str|
  #     code_keys.each do |k|
  #       if str.match?(/#{k}{3,}/)
  #       end
  #     end
  #     str
  #   end
  # end

  def InfoBlock.length_updater(hh)
    hh.each do |k, (size, v, option)|
      if option == :m
        half_min = (size - v.size) / 2
        half_max = size - v.size - half_min
        hh[k] = ' ' * half_max + v + ' ' * half_min
      elsif option == :s
        hh[k] = v + ' ' * (size - v.size)
      elsif option == :e
        hh[k] = ' ' * (size - v.size) + v
      end
    end
  end

  def InfoBlock.incerter(str, hh)
    hh.each do |k, v|
      str = str.sub(/#{k}+/, v)
    end
    str
  end

  private

  def InfoBlock.old_hero_stats_info(hero)
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
  end

  def InfoBlock.old_enemy_start_stats_info(enemy)
    puts "В бой! Ваш противник #{enemy.name}"
    puts "HP #{enemy.hp}"
    puts "Damage #{enemy.min_dmg}-#{enemy.max_dmg} = #{enemy.min_dmg_base}-#{enemy.max_dmg_base} + #{enemy.weapon.min_dmg}-#{enemy.weapon.max_dmg}(#{enemy.weapon.name})"
    puts "Armor #{enemy.armor} = #{enemy.armor_base} + #{enemy.body_armor.armor}(#{enemy.body_armor.name}) + #{enemy.head_armor.armor}(#{enemy.head_armor.name}) + #{enemy.arms_armor.armor}(#{enemy.arms_armor.name}) + #{enemy.shield.armor}(#{enemy.shield.name})"
    puts "Accurasy #{enemy.accuracy} = #{enemy.accuracy_base} + #{enemy.arms_armor.accuracy}(#{enemy.arms_armor.name})"
    puts "Block #{enemy.block_chance} = #{enemy.shield.block_chance}(#{enemy.shield.name})"
  end

end

# p InfoBlock.character_stats

# class TestHero
#   attr_reader :name, :exp, :lvl, :exp_lvl
#   def initialize
#     @name = 'Vasya'
#     @exp = rand(0..199)
#     @lvl = rand(0..15)
#     @exp_lvl = [0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200]
#   end
#   def active_skill; self end
#   def passive_skill; self end
#   def camp_skill; self end
#   def description
#     "Ya Kroker i ya ogromen i y menya ogromniy mech"
#   end
# end
# puts InfoBlock.hero_name_level_exp(TestHero.new)
# puts InfoBlock.character_skills(TestHero.new)














#
