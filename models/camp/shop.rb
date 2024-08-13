class Shop
  PATH = 'saves/shop.yml'
  SELL_CHANCE = 3
  MAX_CAPACITY = 3

  def initialize
    create()
    @shop = YAML.safe_load_file(PATH)
  end

  def add_ammunition_from(hero)
    %w[weapon body_armor head_armor arms_armor shield].each do |ammunition_type|
      ammunition_code = hero.send(ammunition_type).code
      if rand(SELL_CHANCE) == 0 && ammunition_code != 'without'
        @shop['shop'][ammunition_type] = [] unless @shop['shop'][ammunition_type]
        remove_random_item_of_type(ammunition_type) if @shop['shop'][ammunition_type].length >= MAX_CAPACITY
        @shop['shop'][ammunition_type] << ammunition_code
      end
    end
    update()
  end

  def remove_random_item_of_type(ammunition_type)
    choose = if @shop['shop'][ammunition_type].include?('without')
      @shop['shop'][ammunition_type].index('without')
    else
      rand(@shop['shop'][ammunition_type].length)
    end
    @shop['shop'][ammunition_type] = @shop['shop'][ammunition_type].reject.with_index{|_, i| i == choose}
  end

  def sell_amunition()
  end

  # Wiew:

  def coins
    @shop['coins']
  end

  def method_missing(method)
    ammunition_type, i = method.to_s.split('__')
    ammunition_code = @shop['shop'][ammunition_type][i.to_i]
    YAML.safe_load_file("data/ammunition/#{ammunition_type}.yml")[ammunition_code]['name']
  end

  private

  def create
    File.write(PATH, new_file_data().to_yaml) unless RubyVersionFixHelper.file_exists?(PATH) # File::exists?(PATH)
  end

  def update
    File.write(PATH, @shop.to_yaml)
  end

  def new_file_data
    {
      'shop' => {
        'arms_armor' => %w[without without without],
        'body_armor' => %w[without without without],
        'head_armor' => %w[without without without],
        'shield' => %w[without without without],
        'weapon' => %w[without without without]
      },
      'coins' => 0,
      'arms_armor' => 'without',
      'body_armor' => 'without',
      'head_armor' => 'without',
      'shield' => 'without',
      'weapon' => 'without'
    }
  end
end
