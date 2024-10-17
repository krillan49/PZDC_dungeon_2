class ExitRunEvent
  include DisplayScreenConcern
  include GameEndConcern

  PATH_ART = "events/_exit_run"

  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @path_art = PATH_ART

    @name = 'Exit from dugeon'
    @description1 = 'Looks like an exit...'
    @description2 = '...you can save life...'
    @description3 = '...you can save coins...'
    @description4 = '...but be careful...'
    @description5 = '...you might fall'

    @messages = MainMessage.new

    @basic_exit_chanse = rand(1..200)
    @exit_chanse = @basic_exit_chanse + (@hero.camp_skill.code == 'treasure_hunter' ? @hero.camp_skill.coeff_lvl : 0)
  end

  def start
    @messages.main = 'Climb the stairs [Enter 1]                Leave [Enter 0]'
    @messages.log << "You see an old staircase leading up, it looks like it's the exit from the dungeon..."
    display_message_screen()
    choose = gets.strip
    climb() if choose == '1'
  end

  private

  def climb
    if @hero.camp_skill.code == 'treasure_hunter'
      @messages.log << "Random luck is #{@basic_exit_chanse} + treasure hunter(#{@hero.camp_skill.coeff_lvl}) = #{@exit_chanse}..."
    else
      @messages.log << "Random luck is #{@exit_chanse}..."
    end
    if @exit_chanse > 140
      @messages.log << "...more then 140"
      can_exit()
      'exit_run'
    elsif @exit_chanse > 70
      @messages.log << "...lower then 140"
      nothing()
    else
      @messages.log << "...lower then 70"
      fell_down()
    end
  end

  def can_exit
    @messages.main = 'You survived. To continue press Enter'
    @messages.log << "...#{@hero.name} managed to climb the old stairs, hurray, exit"
    display_message_screen()
    gets
    end_game_and_hero_alive()
  end

  def nothing
    @messages.main = 'To continue press Enter'
    @messages.log << "...unfortunately it is impossible to reach the stairs"
    display_message_screen()
    gets
  end

  def fell_down
    @hero.hp -= @hero.hp_max * 0.1
    @messages.main = 'You died and the exit was so close. To continue press Enter'
    @messages.log << "...#{@hero.name} climbed the old ladder, the exit was already close, but the ladder broke..."
    @messages.log << "...#{@hero.name} fell and lost #{(@hero.hp_max * 0.1).round} HP. #{@hero.hp.round}/#{@hero.hp_max} HP left"
    display_message_screen()
    gets
    end_game_and_hero_died() if hero_died?()
  end

end
