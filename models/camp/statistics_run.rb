class StatisticsRun
  PATH = 'saves/statistics_run.yml'

  attr_reader :data

  def initialize(dungeon_code, new_obj=false)
    @dungeon_code = dungeon_code
    create(new_obj)
    @data = YAML.safe_load_file(PATH)
  end

  def add_enemy_to_data(enemy_code)
    @data[@dungeon_code][enemy_code] ? @data[@dungeon_code][enemy_code] += 1 : @data[@dungeon_code][enemy_code] = 1
  end

  def update
    File.write(PATH, @data.to_yaml)
  end

  def delete
    File.delete(PATH) if RubyVersionFixHelper.file_exists?(PATH)
  end

  # show
  def method_missing(method_name)
    create_subdatas()
    if method_name.to_s == 'name'
      @dungeon_code.capitalize.split('_').join(' ')
    elsif method_name.to_s.include?('enemy_name__')
      i = method_name.to_s.split('__')[1].to_i
      i < @data_enemyes.length ? @data_enemyes[i][0].capitalize.split('_').join(' ') : ''
    elsif method_name.to_s.include?('enemy_count__')
      i = method_name.to_s.split('__')[1].to_i
      i < @data_enemyes.length ? @data_enemyes[i][1] : ''
    end
  end

  private

  def create_subdatas
    @data_enemyes = @data[@dungeon_code].to_a unless @data_enemyes
  end

  def create(new_obj)
    if !RubyVersionFixHelper.file_exists?(PATH) || new_obj
      File.write(PATH, new_file_data().to_yaml)
    end
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
