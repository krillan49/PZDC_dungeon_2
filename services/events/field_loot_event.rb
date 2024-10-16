class FieldLootEvent
  include DisplayScreenConcern
  include GameEndConcern

  PATH_ART = "events/_loot_field"

  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @path_art = PATH_ART

    @name = 'Some scrub'
    @description1 = 'In this pile of scrub...'
    @description2 = '...you might find some'
    @description3 = ''
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new

    @basic_loot_chanse = rand(1..200)
    @loot_chanse = @basic_loot_chanse + (@hero.camp_skill.code == 'treasure_hunter' ? @hero.camp_skill.coeff_lvl : 0)
  end

  def start
    @messages.main = 'To continue press Enter'
    @messages.log << "Search everything around..."
    if @hero.camp_skill.code == 'treasure_hunter'
      @messages.log << "Random luck is #{@basic_loot_chanse} + treasure hunter #{@hero.camp_skill.coeff_lvl} = #{@loot_chanse}..."
    else
      @messages.log << "Random luck is #{@loot_chanse}..."
    end
    if @loot_chanse > 140
      @messages.log << "...more then 140"
      potion()
    elsif @loot_chanse > 70
      @messages.log << "...lower then 140"
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
    gets
  end

  def potion
    @hero.hp += [20, @hero.hp_max - @hero.hp].min
    @messages.log << "Found a potion that restores 20 HP, now you have it #{@hero.hp.round}/#{@hero.hp_max} HP"
    display_message_screen()
    gets
  end

  def rat
    @hero.hp -= 5
    @messages.main = 'You died from a rat bite. A miserable death. To continue press Enter'
    @messages.log << "While you were rummaging around the corners, you were bitten by a rat (-5 HP), now you have #{@hero.hp.round}/#{@hero.hp_max} HP"
    display_message_screen()
    gets
    end_game_and_hero_died() if hero_died?()
  end

end












#
