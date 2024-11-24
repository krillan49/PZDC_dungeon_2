class WarriorsGraveEvent
  include DisplayScreenConcern
  include AmmunitionConcern

  attr_reader :entity_type, :code_name, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @code_name = 'wariors_grave'
    @path_art = "events/_warriors_grave"

    @name = "Warior's Grave"
    @description1 = 'Old grave...'
    @description2 = '...warrior is buried here...'
    @description3 = '...maybe with ammunition?'
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new
  end

  def start
    if @hero.events_data['wariors_grave'] && @hero.events_data['wariors_grave']['taken'] == 1
      with_taken_quest()
    else
      no_taken_quest()
    end
  end

  private

  def with_taken_quest
    @hero.add_hp_not_higher_than_max(5)
    @hero.add_mp_not_higher_than_max(5)
    @messages.log << "Warrior's spirit restored you 5 HP and 5 MP"
    enemy = @hero.events_data['wariors_grave']['enemy']
    enemy_name = enemy.capitalize.split('_').join(' ')
    statistics_enemy_count = @hero.statistics.data[@hero.dungeon_name][enemy]
    event_enemy_count = @hero.events_data['wariors_grave']['count']
    if statistics_enemy_count >= event_enemy_count
      reward(event_enemy_count, enemy_name)
      @messages.log << "\"Good luck, brother. With people like you, we will cleanse these lands.\""
    else
      count = event_enemy_count - statistics_enemy_count
      @messages.log << "\"Keep up the good work you still have to kill #{count} #{enemy_name}s\""
    end
    @messages.main = "Leave [Enter 0]"
    display_message_screen(:clean)
    gets
  end

  def reward(event_enemy_count, enemy_name)
    @hero.events_data['wariors_grave']['taken'] = 0
    message = "\"You did a great job #{event_enemy_count} #{enemy_name}s is killed, here is your reward\""
    random_weapon_code = if @hero.events_data['wariors_grave']['level'] == 1
      (['sword']*4 + ['hatchet']).sample
    else
      ['falchion', 'pernach', 'axe', 'flail'].sample
    end
    ammunition_loot(ammunition_type: 'weapon', ammunition_code: random_weapon_code, message: message)
  end


  def no_taken_quest
    @messages.main = "Dig up the grave [Enter 1]    Clean the grave from dirt [Enter 2]    Leave [Enter 0]"
    @messages.log << "You see an old grave, judging by the inscription a warrior is buried there."
    display_message_screen()
    choose = gets.strip
    @messages.clear_log
    dig_grave() if choose == '1'
    clean_grave() if choose == '2'
  end

  def dig_grave
    base_loot_chance = rand(0..200)
    loot_chance = base_loot_chance + (@hero.camp_skill.code == 'treasure_hunter' ? @hero.camp_skill.coeff_lvl : 0)
    if loot_chance > 220
      random_weapon_code = 'rusty_falchion'
      message = dig_chance_message(220, random_weapon_code, base_loot_chance, loot_chance)
    elsif loot_chance > 150
      random_weapon_code = 'rusty_sword'
      message = dig_chance_message(150, random_weapon_code, base_loot_chance, loot_chance)
    elsif loot_chance > 80
      random_weapon_code = 'rusty_hatchet'
      message = dig_chance_message(80, random_weapon_code, base_loot_chance, loot_chance)
    else
      random_weapon_code = 'without'
      if @hero.camp_skill.code == 'treasure_hunter'
        @messages.log << "Random luck is #{base_loot_chance} + treasure hunter #{@hero.camp_skill.coeff_lvl} = #{loot_chance} <= 80. You dug up a grave and nothing there"
      else
        @messages.log << "Random luck is #{loot_chance} <= 80. You dug up a grave and nothing there"
      end
    end
    if random_weapon_code == 'without'
      change = true
    else
      change = ammunition_loot(ammunition_type: 'weapon', ammunition_code: random_weapon_code, message: message)
    end
    if change
      mp = rand(20..100)
      @hero.reduce_mp_not_less_than_zero(mp)
      @messages.log << "The warrior's spirit is furious, he took #{mp} MP from you"
    else
      mp = rand(5..20)
      @hero.reduce_mp_not_less_than_zero(mp)
      @messages.log << "The warrior spirit is not happy, he took #{mp} MP from you"
    end
    @messages.main = "Leave [Enter 0]"
    display_message_screen(:diged)
    gets
  end

  def dig_chance_message(n, random_weapon_code, base_loot_chance, loot_chance)
    weapon_name = random_weapon_code.split('_').join(' ').capitalize
    if @hero.camp_skill.code == 'treasure_hunter'
      "Random luck is #{base_loot_chance} + treasure hunter #{@hero.camp_skill.coeff_lvl} = #{loot_chance} > #{n}. You dug up #{weapon_name}, take it or bury it back?"
    else
      "Random luck is #{loot_chance} > #{n}. You dug up a grave and #{weapon_name} there, take it or bury it back?"
    end
  end

  def clean_grave
    @hero.add_hp_not_higher_than_max(5)
    @hero.add_mp_not_higher_than_max(5)
    count = 3
    level = @hero.lvl < 5 ? 1 : 2
    enemy = enemy_choose(level-1)
    enemy_name = enemy.capitalize.split('_').join(' ')
    @messages.main = "Take quest [Enter 1]                 Leave [Enter 0]"
    @messages.log << "After cleaning the grave you felt better, the warrior's spirit restored you 5 HP and 5 MP"
    @messages.log << "\"I see that you are also a warrior and could continue my work and cleanse these lands\""
    @messages.log << "\"If you kill #{count} #{enemy_name}s and go to any warrior's grave, you will receive a reward\""
    display_message_screen(:clean)
    choose = gets.strip
    take_quest(enemy, count, level, enemy_name) if choose == '1'
  end

  def enemy_choose(i)
    if @hero.dungeon_name == 'bandits'
      ['poacher', 'deserter']
    elsif @hero.dungeon_name == 'undeads'
      ['skeleton', 'skeleton_soldier']
    elsif @hero.dungeon_name == 'swamp'
      ['goblin', 'orc']
    end[i]
  end

  def take_quest(enemy, count, level, enemy_name)
    statistics_enemy_count = @hero.statistics.data[@hero.dungeon_name][enemy]
    @hero.events_data['wariors_grave'] = {
      'taken' => 1,
      'enemy' => enemy,
      'count' => statistics_enemy_count + count,
      'level' => level,
      'description' => "Warrior spirit asked to kill #{count} #{enemy_name}s"
    }
    @messages.clear_log
    @messages.main = "Leave [Enter 0]"
    @messages.log << "\"I immediately realized that you are one of us, let's cleanse these lands\""
    display_message_screen(:clean)
    gets
  end

end













#
