class SecretLootEvent
  include DisplayScreenConcern

  attr_reader :entity_type, :code_name, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @code_name = 'loot_secret'
    @path_art = "events/_loot_secret"

    @name = 'Secret something'
    @description1 = 'There might be something...'
    @description2 = '...unusual here'
    @description3 = ''
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new

    @basic_loot_chanse = rand(1..200)
    @loot_chanse = @basic_loot_chanse + (@hero.camp_skill.code == 'treasure_hunter' ? @hero.camp_skill.coeff_lvl : 0)
  end

  def start
    @messages.log << "Looking around, you noticed the magician's hiding place, and in it... "
    if @hero.camp_skill.code == 'treasure_hunter'
      @messages.log << "Random luck is #{@basic_loot_chanse} + treasure hunter #{@hero.camp_skill.coeff_lvl} = #{@loot_chanse}..."
    else
      @messages.log << "Random luck is #{@loot_chanse}..."
    end
    if @loot_chanse >= 180
      @messages.log << "...more then 180"
      stash_magic_treasure = rand(1..32)
      case stash_magic_treasure
      when (..10); hp_elixir()
      when (11..20); mp_elixir()
      when (21..25); accuracy_elixir()
      when (26..27); book_of_knowledge()
      when (28..29); book_of_skills()
      when 30; stone_elixir()
      when 31; troll_elixir()
      when 32; unicorn_elixir()
      end
    else
      @messages.log << "...lower then 180"
      nothing()
    end
    @messages.main = 'To continue press Enter'
    display_message_screen()
    gets
  end

  private

  def nothing
    @messages.log << "There is nothing valuable"
  end

  def hp_elixir
    bonus_hp = rand(1..3)
    @messages.log << "Elixir of Health. Your hp #{@hero.hp.round}/#{@hero.hp_max} increase by #{bonus_hp}"
    @hero.hp_max += bonus_hp
    @hero.hp += bonus_hp
    @messages.log << "Now you have #{@hero.hp.round}/#{@hero.hp_max} hp"
  end

  def mp_elixir
    bonus_mp = rand(1..3)
    @messages.log << "Elixir of Endurance. Your mp #{@hero.mp.round}/#{@hero.mp_max} increase by #{bonus_mp}"
    @hero.mp_max += bonus_mp
    @hero.mp += bonus_mp
    @messages.log << "Now you have #{@hero.mp.round}/#{@hero.mp_max} mp"
  end

  def accuracy_elixir
    bonus_accuracy = rand(1..2)
    @messages.log << "Elixir of Precision. Your accuracy #{@hero.accuracy_base} increase by #{bonus_accuracy}"
    @hero.accuracy_base += bonus_accuracy
    @messages.log << "Now you have #{@hero.accuracy_base} accuracy"
  end

  def book_of_knowledge
    bonus_points = 1
    @messages.log << "Book of Knowledge. Your stat points increase by #{bonus_points}"
    @hero.stat_points += bonus_points
  end

  def book_of_skills
    skill_bonus_points = 1
    @messages.log << "Book of Skills. Your skill points increase by #{skill_bonus_points}"
    @hero.skill_points += skill_bonus_points
  end

  def stone_elixir
    bonus_armor = 1
    @messages.log << "Elixir of Stone. Your armor #{@hero.armor_base} increase by #{bonus_armor}"
    @hero.armor_base += bonus_armor
    @messages.log << "Now you have #{@hero.armor_base} armor"
  end

  def troll_elixir
    bonus_hp_regen = 1
    @messages.log << "Elixir of the Troll. HP regeneration #{@hero.regen_hp_base} increase by #{bonus_hp_regen}"
    @hero.regen_hp_base += bonus_hp_regen
    @messages.log << "Now you have #{@hero.regen_hp_base} hp regeneration"
  end

  def unicorn_elixir
    bonus_mp_regen = 1
    @messages.log << "Unicorn Elixir. MP regeneration #{@hero.regen_mp_base} increase by #{bonus_mp_regen}"
    @hero.regen_mp_base += bonus_mp_regen
    @messages.log << "Now you have #{@hero.regen_mp_base} mp regeneration"
  end

end















#
