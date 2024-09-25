class StatisticsRun
  PATH = 'saves/statistics_run.yml'

  def initialize(new_obj=false)
    create(new_obj)
    @data = YAML.safe_load_file(PATH)
  end

  def add_enemy_to_data(dungeon_code, enemy_code)
    @data[dungeon_code][enemy_code] ? @data[dungeon_code][enemy_code] += 1 : @data[dungeon_code][enemy_code] = 1
    update()
  end

  private

  def create(new_obj)
    if !RubyVersionFixHelper.file_exists?(PATH) || new_obj
      File.write(PATH, new_file_data().to_yaml)
    end
  end

  def update
    File.write(PATH, @data.to_yaml)
  end

  def new_file_data
    {
      'bandits' => {
        'rabble' => 0,
        'rabid_dog' => 0,
        'poacher' => 0,
        'thug' => 0,
        'deserter' => 0,
        'bandit_leader' => 0
      },
      'undeads' => {
        'zombie' => 0,
        'skeleton' => 0,
        'ghost' => 0,
        'fat_ghoul' => 0,
        'skeleton_soldier' => 0,
        'zombie_knight' => 0
      },
      'swamp' => {
        'leech' => 0,
        'goblin' => 0,
        'sworm' => 0,
        'spider' => 0,
        'orc' => 0,
        'ancient_snail' => 0
      }
    }
  end
end
