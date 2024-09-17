class ExitRunEvent
  PATH_ART = "events/_exit_run"

  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @path_art = PATH_ART

    @name = 'Exit from dugeon'
    @description1 = 'Looks like an exit...'
    @description2 = '...but be careful...'
    @description3 = '...you might fall'

    @messages = MainMessage.new

    @basic_exit_chanse = rand(1..200)
    @exit_chanse = @basic_exit_chanse + (@hero.camp_skill.code == 'treasure_hunter' ? @hero.camp_skill.coeff_lvl : 0)
  end

  def start
    @messages.log << "You see an old staircase leading up, it looks like it's the exit from the dungeon..."
    if @hero.camp_skill.code == 'treasure_hunter'
      @messages.log << "Random luck is #{@basic_exit_chanse} + treasure hunter(#{@hero.camp_skill.coeff_lvl}) = #{@exit_chanse}..."
    else
      @messages.log << "Random luck is #{@exit_chanse}..."
    end
    if @exit_chanse > 160
      @messages.log << "...more then 160"
      can_exit()
      'exit_run'
    elsif @exit_chanse > 70
      @messages.log << "...more then 70"
      nothing()
    else
      @messages.log << "...lower then 70"
      fell_down()
    end
  end

  private

  def can_exit
    @messages.log << "...#{@hero.name} managed to climb the old stairs, hurray, exit"
    display_message_screen()
    @messages.main = 'You survived. To continue press Enter'
    MainRenderer.new(:run_end_screen, entity: @messages, arts: [{ end: :run_end_art }]).display
    gets
    DeleteHeroInRun.new(@hero).add_camp_loot_and_delete_hero_file
  end

  def nothing
    @messages.log << "...unfortunately it is impossible to reach the stairs"
    display_message_screen()
  end

  def fell_down
    @hero.hp -= @hero.hp_max * 0.1
    @messages.log << "...#{@hero.name} climbed the old ladder, the exit was already close, but the ladder broke..."
    @messages.log << "...#{@hero.name} fell and lost #{(@hero.hp_max * 0.1).round} HP. #{@hero.hp.round}/#{@hero.hp_max} HP left"
    display_message_screen()
    if @hero.hp <= 0
      @messages.main = "Press Enter to end the game"
      @messages.log << "You you died and the exit was so close"
      MainRenderer.new(:messages_screen, entity: @messages, arts: [{ game_over: :game_over }]).display
      gets
      MainRenderer.new(:run_end_screen, entity: @messages, arts: [{ end: :run_end_art }]).display
      gets
      DeleteHeroInRun.new(@hero).add_camp_loot_and_delete_hero_file
    end
  end

  def display_message_screen
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    gets
  end

end
