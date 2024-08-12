class PzdcMonolith
  PATH = 'saves/pzdc_monolith.yml'
  PRICES = {
    'hp' => 1,
    'mp' => 1,
    'accuracy' => 5,
    'damage' => 5,
    'stat_points' => 7,
    'skill_points' => 15,
    'armor' => 30,
    'regen_hp' => 100,
    'regen_mp' => 100
  }

  attr_reader :hp_p, :mp_p, :accuracy_p, :damage_p, :stat_points_p, :skill_points_p, :armor_p, :regen_hp_p, :regen_mp_p

  def initialize
    create()
    @monolith = YAML.safe_load_file(PATH)

    # prices in @points for view
    @hp_p = PRICES['hp']
    @mp_p = PRICES['mp']
    @accuracy_p = PRICES['accuracy']
    @damage_p = PRICES['damage']
    @stat_points_p = PRICES['stat_points']
    @skill_points_p = PRICES['skill_points']
    @armor_p = PRICES['armor']
    @regen_hp_p = PRICES['regen_hp']
    @regen_mp_p = PRICES['regen_mp']
  end

  def add_points(n)
    @monolith['points'] += n
    update()
  end

  def take_points_to(characteristic)
    if @monolith['points'] >= PRICES[characteristic]
      @monolith['points'] -= PRICES[characteristic]
      @monolith[characteristic] += 1
      update()
    end
  end

  # getters:
  def method_missing(method)
    @monolith[method.to_s]
  end

  private

  def create
    File.write(PATH, new_file_data().to_yaml) unless RubyVersionFixHelper.file_exists?(PATH) # File::exists?(PATH)
  end

  def update
    File.write(PATH, @monolith.to_yaml)
  end

  def new_file_data
    {
      'points' => 0,
      # bonuses
      'hp' => 0,
      'mp' => 0,
      'accuracy' => 0,
      'damage' => 0,
      'stat_points' => 0,
      'skill_points' => 0,
      'armor' => 0,
      'regen_hp' => 0,
      'regen_mp' => 0
    }
  end
end
