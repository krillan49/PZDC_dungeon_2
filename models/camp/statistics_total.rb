class StatisticsTotal
  PATH = 'saves/statistics_total.yml'

  def initialize
    create()
    @data = YAML.safe_load_file(PATH)
  end

  def add_from_run(statistics_run)
    statistics_run.each do |section_name, section|
      @data[section_name] = {} unless @data[section_name]
      section.each do |data_name, value|
        if @data[section_name][data_name]
          @data[section_name][data_name] += value
        else
          @data[section_name][data_name] = value
        end
      end
    end
    update()
  end

  # subdatas for show
  def create_subdatas(params)
    @dungeon_code = params[:dungeon_code]
    @data_enemyes = @data[@dungeon_code].to_a if @dungeon_code
  end

  # show
  def method_missing(method_name)
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

  def create
    File.write(PATH, new_file_data().to_yaml) unless RubyVersionFixHelper.file_exists?(PATH) # File::exists?(PATH)
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
