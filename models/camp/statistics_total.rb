class StatisticsTotal
  PATH = 'saves/statistics_total.yml'
  # show:
  BOSES = %w[bandit_leader zombie_knight ancient_snail]
  DESCRIPTIONS = {
    'rabble' => {'kill' => 50, 'get' => 'Permanent weapon "Stick"'},
    'rabid_dog' => {'kill' => 50, 'get' => '+2 HP'},
    'poacher' => {'kill' => 50, 'get' => '+1 accuracy'},
    'thug' => {'kill' => 50, 'get' => '+5 HP'},
    'deserter' => {'kill' => 50, 'get' => '+1 stat point'},
    'bandit_leader' => {'kill' => 5, 'get' => '+1 skill point'},
    'zombie' => {'kill' => 50, 'get' => 'Permanent "Worn gloves"'},
    'skeleton' => {'kill' => 50, 'get' => '+3 MP'},
    'ghost' => {'kill' => 50, 'get' => '+1 accuracy'},
    'fat_ghoul' => {'kill' => 50, 'get' => '+7 HP'},
    'skeleton_soldier' => {'kill' => 50, 'get' => '+3 block chance'},
    'zombie_knight' => {'kill' => 5, 'get' => '+1 MP-regen'},
    'leech' => {'kill' => 50, 'get' => '+3 MP'},
    'goblin' => {'kill' => 50, 'get' => 'Permanent "Holey wicker buckler"'},
    'sworm' => {'kill' => 50, 'get' => '+3 HP'},
    'spider' => {'kill' => 50, 'get' => '+1 accuracy'},
    'orc' => {'kill' => 50, 'get' => '+1 max damage'},
    'ancient_snail' => {'kill' => 5, 'get' => '+1 armor'}
  }

  attr_reader :data

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
    return @dungeon_code.capitalize.split('_').join(' ') if method_name.to_s == 'name'
    i = method_name.to_s.split('__')[1].to_i if method_name.to_s.include?('__')
    return '' if i >= @data_enemyes.length
    if method_name.to_s.include?('enemy_name__')
      @data_enemyes[i][0].capitalize.split('_').join(' ')
    elsif method_name.to_s.include?('enemy_count__')
      @data_enemyes[i][1]
    elsif method_name.to_s.include?('enemy_done__')
      @data_enemyes[i][1] >= 50 || (BOSES.include?(@data_enemyes[i][0]) && @data_enemyes[i][1] >= 5) ? 'DONE' : ''
    elsif method_name.to_s.include?('enemy_kill__')
      DESCRIPTIONS[@data_enemyes[i][0]]['kill']
    elsif method_name.to_s.include?('enemy_get__')
      DESCRIPTIONS[@data_enemyes[i][0]]['get']
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
