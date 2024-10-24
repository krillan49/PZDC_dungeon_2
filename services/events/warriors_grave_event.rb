class WariorsGraveEvent
  include DisplayScreenConcern
  include AmmunitionConcern

  PATH_ART = "events/_wariors_grave"

  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @path_art = PATH_ART

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
    display_message_screen()
    gets
  end

  def reward(event_enemy_count, enemy_name)
    @hero.events_data['wariors_grave']['taken'] = 0
    message = "\"You did a great job #{event_enemy_count} #{enemy_name}s is killed, here is your reward\""
    random_weapon_code = if @hero.events_data['wariors_grave']['level'] == 1
      (['sword']*4 + ['hatchet'] + ['falchion']).sample
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
    random_weapon_code = (['rusty_hatchet']*4 + ['rusty_sword']*2 + ['rusty_falchion']).sample
    weapon_name = random_weapon_code.split('_').join(' ').capitalize
    message = "You dug up a grave and #{weapon_name} there, should we take it or bury it back?"
    change = ammunition_loot(ammunition_type: 'weapon', ammunition_code: random_weapon_code, message: message)
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
    display_message_screen()
    gets
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
    display_message_screen()
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
    display_message_screen()
    gets
  end

end













#
