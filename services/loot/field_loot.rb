class FieldLoot
  def initialize(hero, messages)
    @hero = hero
    @messages = messages

    @basic_loot_chanse = rand(1..200)
    @loot_chanse = @basic_loot_chanse + (@hero.camp_skill.name == "Treasure hunter" ? @hero.camp_skill.coeff_lvl : 0)
  end

  def looting
    @messages.log << "Search everything around... (#{@basic_loot_chanse} => #{@loot_chanse})"
    if @loot_chanse > 160
      potion()
    elsif @loot_chanse > 70
      nothing()
    else
      rat()
    end
  end

  def hero_dead?
    @hero.hp <= 0
  end

  private

  def nothing
    # @messages.log << "There is nothing valuable"
  end

  def potion
    @hero.hp += [10, @hero.hp_max - @hero.hp].min
    @messages.log << "Found a potion that restores 10 hp, now you have it #{@hero.hp.round}/#{@hero.hp_max} hp"
    display_message_screen()
  end

  def rat
    @hero.hp -= 5
    @messages.log << "While you were rummaging around the corners, you were bitten by a rat (-5 hp), now you have #{@hero.hp.round}/#{@hero.hp_max} hp"
    display_message_screen()
    if @hero.hp <= 0
      @messages.main = "Press Enter to end the game"
      @messages.log << "You died from a rat bite. A miserable death"
      MainRenderer.new(:messages_screen, entity: @messages, arts: [{ game_over: :game_over }]).display
      gets
      DeleteHeroInRun.new(@hero).add_camp_loot_and_delete_hero_file
    end
  end

  private

  def display_message_screen
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages, arts: [{ loot_field: :loot_field }]).display
    gets
  end

end












#
