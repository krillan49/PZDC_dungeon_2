class FieldLootEvent
  PATH_ART = "events/_loot_field"

  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @path_art = PATH_ART

    @name = 'Some scrub'
    @description1 = 'In this pile of scrub...'
    @description2 = '...you might find some'
    @description3 = ''

    @messages = MainMessage.new

    @basic_loot_chanse = rand(1..200)
    @loot_chanse = @basic_loot_chanse + (@hero.camp_skill.code == 'treasure_hunter' ? @hero.camp_skill.coeff_lvl : 0)
  end

  def start
    @messages.log << "Search everything around..."
    if @hero.camp_skill.code == 'treasure_hunter'
      @messages.log << "Random luck is #{@basic_loot_chanse} + treasure hunter(#{@hero.camp_skill.coeff_lvl}) = #{@loot_chanse}..."
    else
      @messages.log << "Random luck is #{@loot_chanse}..."
    end
    if @loot_chanse > 160
      @messages.log << "...more then 160"
      potion()
    elsif @loot_chanse > 70
      @messages.log << "...more then 70"
      nothing()
    else
      @messages.log << "...lower then 70"
      rat()
    end
  end

  private

  def nothing
    @messages.log << "There is nothing valuable"
    display_message_screen()
  end

  def potion
    @hero.hp += [10, @hero.hp_max - @hero.hp].min
    @messages.log << "Found a potion that restores 10 HP, now you have it #{@hero.hp.round}/#{@hero.hp_max} HP"
    display_message_screen()
  end

  def rat
    @hero.hp -= 5
    @messages.log << "While you were rummaging around the corners, you were bitten by a rat (-5 HP), now you have #{@hero.hp.round}/#{@hero.hp_max} HP"
    display_message_screen()
    if @hero.hp <= 0
      @messages.main = "Press Enter to end the game"
      @messages.log << "You died from a rat bite. A miserable death"
      MainRenderer.new(:messages_screen, entity: @messages, arts: [{ game_over: :game_over }]).display
      gets
      MainRenderer.new(:run_end_screen, entity: @messages, arts: [{ end: :run_end_art }]).display
      gets
      DeleteHeroInRun.new(@hero).add_camp_loot_and_delete_hero_file
    end
  end

  private

  def display_message_screen
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages, arts: [{ normal: PATH_ART }]).display
    gets
  end

end












#
