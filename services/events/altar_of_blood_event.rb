class AltarOfBloodEvent
  include DisplayScreenConcern

  attr_reader :entity_type, :code_name, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @code_name = 'altar_of_blood'
    @path_art = "events/_altar_of_blood"

    @name = 'Altar of Blood'
    @description1 = 'Old Altar...'
    @description2 = '...its take your blood...'
    @description3 = '...and give you some'
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new

    @adept = hero.camp_skill.code == 'bloody_ritual'
  end

  def start
    return no_blood() if @hero.hp < 31
    @adept ? adept_sacrifice() : common_sacrifice()
  end

  private

  def no_blood
    @messages.main = "You have only #{@hero.hp} HP. Press Enter to exit"
    @messages.log << "The altar doesn't speak to you, maybe you don't have enough blood"
    display_message_screen()
    gets
  end

  def adept_sacrifice
    @messages.log << "This is the altar of your bloody god, he recognized his own and began to vibrate"
    @messages.log << "An inscription in blood appeared on the altar:"
    arr = %w[0 1 2 3]
    if @hero.camp_skill.lvl > 5
      @messages.main = "+5 max-HP [Enter 1]    +5 max-MP [Enter 2]    +1 Accuracy [Enter 3]    +1 Damage [Enter 4]    Exit [Enter 0]"
      @messages.log << "I see you are my prophet. Shed blood (-30 HP) and receive great gifts"
      arr << '4'
    else
      @messages.main = "+5 max-HP [Enter 1]     +5 max-MP [Enter 2]     +1 Accuracy [Enter 3]     Exit [Enter 0]"
      @messages.log << "I see you are my disciple. Spill blood (-30 HP) and receive gifts"
    end
    choose = nil
    until arr.include?(choose)
      display_message_screen(:adept)
      choose = gets.strip
    end
    if choose != '0'
      result(choose)
      display_message_screen(:adept_sacrifice)
      gets
    end
  end

  def common_sacrifice
    @messages.main = "Random Gift [Enter 1]                   Exit [Enter 0]"
    @messages.log << "This is the altar of bloody god"
    @messages.log << "An inscription in blood appeared on the altar:"
    @messages.log << "Spill blood (-30 HP) and receive gifts"
    display_message_screen()
    choose = gets.strip
    if choose == '1'
      random = %w[1 1 2 2 3].sample
      result(random)
      display_message_screen(:common_sacrifice)
      gets
    end
  end

  def result(choose)
    @messages.clear_log
    @messages.main = "Press Enter to exit"
    @hero.hp -= 30
    if choose == '1'
      gift = '5 max-HP'
      @hero.hp_max += 5
    elsif choose == '2'
      gift = '5 max-MP'
      @hero.mp_max += 5
    elsif choose == '3'
      gift = '1 Accuracy'
      @hero.accuracy_base += 1
    elsif choose == '4' && @hero.camp_skill.lvl > 5
      gift = '1 Damage'
      @hero.add_dmg_base
    end
    @messages.log << "Bloody god for your blood gives you: #{gift}"
  end

end
