class FieldLoot
  def initialize(hero)
    @hero = hero
    @field_loot = ['potion', 'rat', 'nothing']
  end

  def looting
    print 'Обыскиваем все вокруг... '
    send(@field_loot.sample)
    puts '---------------------------------------------------------------------'
  end

  private

  def nothing
    puts "Рядом нет ничего ценного"
  end

  def potion
    @hero.hp_pl += [20, @hero.hp_max_pl - @hero.hp_pl].min
    puts "Нашел зелье восстанавливающее 20 жизней, теперь у тебя #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней"
  end

  def rat
    @hero.hp_pl -= 5
    puts "Пока ты шарил по углам, тебя укусила крыса(-5 жизней), теперь у тебя #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней"
    if @hero.hp_pl <= 0
      puts "Ты подох от укуса крысы. Жалкая смерть"
      exit
    end
  end
end


class SecretLoot
  def initialize(hero)
    @hero = hero
    basic_loot_chanse = rand(1..200)
    @loot_chanse = basic_loot_chanse + (@hero.camp_skill.name == "Кладоискатель" ? @hero.camp_skill.coeff_lvl : 0)
    puts "#{basic_loot_chanse} + treasure hunter(#{@hero.camp_skill.coeff_lvl}) = #{@loot_chanse}"
  end

  def looting
    return if @loot_chanse < 180
    puts "Осмотревшись вы заметили тайник мага, а в нем... "
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
    puts '---------------------------------------------------------------------'
  end

  private

  def hp_elixir
    bonus_hp = rand(1..3)
    puts "Эликсир здоровья. Ваши жизни #{@hero.hp_pl.round}/#{@hero.hp_max_pl} увеличиваются на #{bonus_hp}"
    @hero.hp_max_pl += bonus_hp
    @hero.hp_pl += bonus_hp
    puts "Теперь у вас #{@hero.hp_pl.round}/#{@hero.hp_max_pl} жизней"
  end

  def mp_elixir
    bonus_mp = rand(1..3)
    puts "Эликсир выносливости. Ваша выносливость #{@hero.mp_pl.round}/#{@hero.mp_max_pl} увеличивается на #{bonus_mp}"
    @hero.mp_max_pl += bonus_mp
    @hero.mp_pl += bonus_mp
    puts "Теперь у вас #{@hero.mp_pl.round}/#{@hero.mp_max_pl} выносливости"
  end

  def accuracy_elixir
    bonus_accuracy = rand(1..2)
    puts "Эликсир точности. Ваша точность #{@hero.accuracy_base_pl} увеличивается на #{bonus_accuracy}"
    @hero.accuracy_base_pl += bonus_accuracy
    puts "Теперь у вас #{@hero.accuracy_base_pl} точности"
  end

  def book_of_knowledge
    bonus_points = 1
    puts "Книга знаний. Ваши очки характеристик увеличились на #{bonus_points}"
    @hero.stat_points += bonus_points
  end

  def book_of_skills
    skill_bonus_points = 1
    puts "Книга умений. Ваши очки умений увеличились на #{skill_bonus_points}"
    @hero.skill_points += skill_bonus_points
  end

  def stone_elixir
    bonus_armor = 1
    puts "Эликсир камня. Ваша броня #{@hero.armor_base_pl} увеличивается на #{bonus_armor}"
    @hero.armor_base_pl += bonus_armor
    puts "Теперь у вас #{@hero.armor_base_pl} брони"
  end

  def troll_elixir
    bonus_hp_regen = 1
    puts "Эликсир троля. Регенерация жизней #{@hero.regen_hp_base_pl} увеличивается на #{bonus_hp_regen}"
    @hero.regen_hp_base_pl += bonus_hp_regen
    puts "Теперь у вас #{@hero.regen_hp_base_pl} регенерации жизней"
  end

  def unicorn_elixir
    bonus_mp_regen = 1
    puts "Эликсир единорога. Регенерация выносливости #{@hero.regen_mp_base_pl} увеличивается на #{bonus_mp_regen}"
    @hero.regen_mp_base_pl += bonus_mp_regen
    puts "Теперь у вас #{@hero.regen_mp_base_pl} регенерации выносливости"
  end
end


class EnemyLoot
  def initialize(hero, enemy)
    @hero = hero
    @enemy = enemy
  end

  def looting
    weapon_loot() if rand(0..1) == 1 && @enemy.weapon.name != "без оружия"
    body_armor_loot() if rand(0..1) == 1 && @enemy.body_armor.name != "без нагрудника"
    head_armor_loot() if rand(0..1) == 1 && @enemy.head_armor.name != "без шлема"
    arms_armor_loot() if rand(0..1) == 1 && @enemy.arms_armor.name != "без перчаток"
    shield_loot() if rand(0..1) == 1 && @enemy.shield.name != "без щита"
    puts '------------------------------------------------------------------------'
  end

  private

  def weapon_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.weapon.name}"
    print "Поменяем #{@hero.weapon.name}(#{@hero.weapon.min_dmg}-#{@hero.weapon.max_dmg}) на #{@enemy.weapon.name}(#{@enemy.weapon.min_dmg}-#{@enemy.weapon.max_dmg}) y/N? "
    @hero.weapon = @enemy.weapon if gets.strip.upcase == 'Y'
  end

  def body_armor_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.body_armor.name}"
    print "Поменяем #{@hero.body_armor.name}(#{@hero.body_armor.armor}) на #{@enemy.body_armor.name}(#{@enemy.body_armor.armor}) y/N? "
    @hero.body_armor = @enemy.body_armor if gets.strip.upcase == 'Y'
  end

  def head_armor_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.head_armor.name}"
    print "Поменяем #{@hero.head_armor.name}(#{@hero.head_armor.armor}) на #{@enemy.head_armor.name}(#{@enemy.head_armor.armor}) y/N? "
    @hero.head_armor = @enemy.head_armor if gets.strip.upcase == 'Y'
  end

  def arms_armor_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.arms_armor.name}"
    print "Поменяем #{@hero.arms_armor.name}(бр-#{@hero.arms_armor.armor} точ-#{@hero.arms_armor.accuracy}) на #{@enemy.arms_armor.name}(бр-#{@enemy.arms_armor.armor} точ-#{@enemy.arms_armor.accuracy}) y/N? "
    @hero.arms_armor = @enemy.arms_armor if gets.strip.upcase == 'Y'
  end

  def shield_loot
    puts "Обыскав труп #{@enemy.name} ты нашел #{@enemy.shield.name}"
    print "Поменяем #{@hero.shield.name}(бр-#{@hero.shield.armor} блок-#{@hero.shield.block_chance}) на #{@enemy.shield.name}(бр-#{@enemy.shield.armor} блок-#{@enemy.shield.block_chance}) y/N? "
    @hero.shield = @enemy.shield if gets.strip.upcase == 'Y'
  end
end

# class TestHero
#   attr_accessor :hp_pl, :hp_max_pl, :mp_pl, :mp_max_pl, :regen_hp_base_pl, :regen_mp_base_pl
#   attr_accessor :accuracy_base_pl, :stat_points, :skill_points, :armor_base_pl
#   def initialize
#     @hp_max_pl, @mp_max_pl = 100, 100
#     @hp_pl, @mp_pl = rand(1..100), rand(1..100)
#     @accuracy_base_pl = @stat_points = @skill_points = @armor_base_pl = @regen_hp_base_pl = @regen_mp_base_pl = 0
#   end
# end
# 10.times do
#   p h = TestHero.new
#   FieldLoot.new(h).looting
#   p h
#   SecretLoot.new(h).looting
#   p h
#   p '================================================'
# end











#
