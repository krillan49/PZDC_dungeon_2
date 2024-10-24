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
    @messages.main = "Dig up the grave [Enter 1]    Clean the grave from dirt [Enter 2]    Leave [Enter 0]"
    @messages.log << "You see an old grave, judging by the inscription a warrior is buried there."
    display_message_screen()
    choose = gets.strip
    @messages.clear_log
    dig_grave() if choose == '1'
    clean_grave() if choose == '2'
  end

  private

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
    enemy = 'goblin'
    @messages.main = "Take quest [Enter 1]                 Leave [Enter 0]"
    @messages.log << "After cleaning the grave you felt better, the warrior's spirit restored you 5 HP and 5 MP"
    @messages.log << "\"I see that you are also a warrior and could continue my work and cleanse these lands\""
    @messages.log << "\"If you kill 5 #{enemy}s and go to any warrior's grave, you will receive a reward\""
    display_message_screen()
    choose = gets.strip
    if choose == '1'
      @hero.events_data['wariors_grave'] = {
        'taken' => 1,
        'enemy' => enemy,
        'count' => 0
      }
      @messages.clear_log
      @messages.main = "Leave [Enter 0]"
      @messages.log << "\"I immediately realized that you are one of us, let's cleanse these lands\""
      display_message_screen()
      gets
    end
  end

end













#
