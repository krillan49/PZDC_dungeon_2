class EnemyCreator
  def initialize(leveling)
    @boss = rand(1..100) > 99 - leveling
    @standart_chance = rand(1..12) + rand(0..leveling)

    @messages = MainMessage.new
  end

  def create_new_enemy
    @boss ? create_boss_enemy() : create_standart_enemy()
  end

  private

  def create_boss_enemy
    Enemy.new("zombie_knight")
  end

  def create_standart_enemy
    case @standart_chance
    when (..5); Enemy.new("rabble")
    when (6..10); Enemy.new("rabid_dog")
    when (11..15); Enemy.new("goblin")
    when (16..20); Enemy.new("thug")
    when (21..25); Enemy.new("deserter")
    when (26..); Enemy.new("orc")
    end
  end

end















#
