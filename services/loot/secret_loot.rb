class SecretLoot
  def initialize(hero, messages)
    @hero = hero
    @messages = messages

    basic_loot_chanse = rand(1..200)
    @loot_chanse = basic_loot_chanse + (@hero.camp_skill.name == "Кладоискатель" ? @hero.camp_skill.coeff_lvl : 0)

    @messages.log << "#{basic_loot_chanse} + treasure hunter(#{@hero.camp_skill.coeff_lvl}) = #{@loot_chanse}"
  end

  def looting
    return if @loot_chanse < 180
    @messages.log << "Осмотревшись вы заметили тайник мага, а в нем... "
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
  end

  private

  def hp_elixir
    bonus_hp = rand(1..3)
    @messages.log << "Эликсир здоровья. Ваши жизни #{@hero.hp.round}/#{@hero.hp_max} увеличиваются на #{bonus_hp}"
    @hero.hp_max += bonus_hp
    @hero.hp += bonus_hp
    @messages.log << "Теперь у вас #{@hero.hp.round}/#{@hero.hp_max} жизней"
  end

  def mp_elixir
    bonus_mp = rand(1..3)
    @messages.log << "Эликсир выносливости. Ваша выносливость #{@hero.mp.round}/#{@hero.mp_max} увеличивается на #{bonus_mp}"
    @hero.mp_max += bonus_mp
    @hero.mp += bonus_mp
    @messages.log << "Теперь у вас #{@hero.mp.round}/#{@hero.mp_max} выносливости"
  end

  def accuracy_elixir
    bonus_accuracy = rand(1..2)
    @messages.log << "Эликсир точности. Ваша точность #{@hero.accuracy_base} увеличивается на #{bonus_accuracy}"
    @hero.accuracy_base += bonus_accuracy
    @messages.log << "Теперь у вас #{@hero.accuracy_base} точности"
  end

  def book_of_knowledge
    bonus_points = 1
    @messages.log << "Книга знаний. Ваши очки характеристик увеличились на #{bonus_points}"
    @hero.stat_points += bonus_points
  end

  def book_of_skills
    skill_bonus_points = 1
    @messages.log << "Книга умений. Ваши очки умений увеличились на #{skill_bonus_points}"
    @hero.skill_points += skill_bonus_points
  end

  def stone_elixir
    bonus_armor = 1
    @messages.log << "Эликсир камня. Ваша броня #{@hero.armor_base} увеличивается на #{bonus_armor}"
    @hero.armor_base += bonus_armor
    @messages.log << "Теперь у вас #{@hero.armor_base} брони"
  end

  def troll_elixir
    bonus_hp_regen = 1
    @messages.log << "Эликсир троля. Регенерация жизней #{@hero.regen_hp_base} увеличивается на #{bonus_hp_regen}"
    @hero.regen_hp_base += bonus_hp_regen
    @messages.log << "Теперь у вас #{@hero.regen_hp_base} регенерации жизней"
  end

  def unicorn_elixir
    bonus_mp_regen = 1
    @messages.log << "Эликсир единорога. Регенерация выносливости #{@hero.regen_mp_base} увеличивается на #{bonus_mp_regen}"
    @hero.regen_mp_base += bonus_mp_regen
    @messages.log << "Теперь у вас #{@hero.regen_mp_base} регенерации выносливости"
  end
end















#
