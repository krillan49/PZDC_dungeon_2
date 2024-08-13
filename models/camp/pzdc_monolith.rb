class PzdcMonolith
  PATH = 'saves/pzdc_monolith.yml'
  PRICES = {
    'hp' => 1,
    'mp' => 1,
    'accuracy' => 5,
    'damage' => 10,
    'stat_points' => 7,
    'skill_points' => 15,
    'armor' => 30,
    'regen_hp' => 70,
    'regen_mp' => 40
  }
  PRICE_MULTIPLER = {
    'hp' => 1.03,
    'mp' => 1.03,
    'accuracy' => 1.3,
    'damage' => 1.3,
    'stat_points' => 1.2,
    'skill_points' => 1.3,
    'armor' => 1.5,
    'regen_hp' => 2,
    'regen_mp' => 1.7
  }

  def initialize
    create()
    @monolith = YAML.safe_load_file(PATH)
  end

  def add_points(n)
    @monolith['points'] += n
    update()
  end

  def take_points_to(characteristic)
    price = real_price_with_multiplier(characteristic)
    if @monolith['points'] >= price
      @monolith['points'] -= price
      @monolith[characteristic] += 1
      update()
    end
  end

  def real_price_with_multiplier(characteristic)
    (PRICES[characteristic] * PRICE_MULTIPLER[characteristic]**@monolith[characteristic]).floor
  end

  # getters for views:
  def method_missing(method)
    if method.to_s.include?('__') # prices
      characteristic = method.to_s.split('__')[0]
      real_price_with_multiplier(characteristic)
    else # count has now
      @monolith[method.to_s]
    end
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
