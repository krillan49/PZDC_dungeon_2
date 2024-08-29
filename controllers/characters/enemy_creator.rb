class EnemyCreator
  BOSS_LEVEL = 25
  CHANCE_STEP = 4

  def initialize(leveling, dungeon_name)
    @dungeon_name = dungeon_name

    enemyes_data = YAML.safe_load_file("data/characters/enemyes/#{dungeon_name}.yml")
    @standart_enemyes_count = enemyes_data.length + (enemyes_data.key?('boss') ? -1 : 0)

    @boss = leveling >= BOSS_LEVEL
    @standart_chance = rand(1..9) + rand(0..leveling)

    @messages = MainMessage.new
  end

  def create_new_enemy
    @boss ? create_boss_enemy() : create_standart_enemy()
  end

  private

  def create_boss_enemy
    Enemy.new("boss", @dungeon_name)
  end

  # depending on the number of enemies described in the data file of a specific dungeon, a number of ranges is assigned depending on the CHANCE_STEP constant and an enemy is selected in the corresponding range
  def create_standart_enemy
    (1..@standart_enemyes_count).each do |n|
      return Enemy.new("e#{n}", @dungeon_name) if @standart_chance <= n * CHANCE_STEP
    end
    Enemy.new("e#{@standart_enemyes_count}", @dungeon_name)
  end

end















#
