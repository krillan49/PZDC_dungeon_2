class EnemyCreator
  BOSS_LEVEL = 20

  def initialize(leveling, dungeon_name)
    @dungeon_name = dungeon_name

    @boss = leveling >= BOSS_LEVEL
    @standart_chance = rand(12) + rand(0..leveling)

    @messages = MainMessage.new
  end

  def create_new_enemy
    @boss ? create_boss_enemy() : create_standart_enemy()
  end

  private

  def create_boss_enemy
    Enemy.new("boss", @dungeon_name)
  end

  def create_standart_enemy
    case @standart_chance
    when (..5); Enemy.new("e1", @dungeon_name)
    when (6..10); Enemy.new("e2", @dungeon_name)
    when (11..15); Enemy.new("e3", @dungeon_name)
    when (16..20); Enemy.new("e4", @dungeon_name)
    # when (21..25); Enemy.new("e5", @dungeon_name)
    # when (26..); Enemy.new("e6", @dungeon_name)
    else; Enemy.new("e5", @dungeon_name)
    end
  end

end















#
