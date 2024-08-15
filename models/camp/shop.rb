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

  def sell_amunition(n)
    ammunition_type, i = [
      ['weapon', 0], ['weapon', 1], ['weapon', 2],
      ['body_armor', 0], ['body_armor', 1], ['body_armor', 2],
      ['head_armor', 0], ['head_armor', 1], ['head_armor', 2],
      ['arms_armor', 0], ['arms_armor', 1], ['arms_armor', 2],
      ['shield', 0], ['shield', 1], ['shield', 2]
    ][n-1]
    ammunition_code = @shop['shop'][ammunition_type][i]
    ammunition_price = YAML.safe_load_file("data/ammunition/#{ammunition_type}.yml")[ammunition_code]['price']
    if @shop['coins'] >= ammunition_price && ammunition_code != 'without'
      @shop['coins'] -= ammunition_price
      @shop[ammunition_type] = @shop['shop'][ammunition_type][i]
      @shop['shop'][ammunition_type][i] = 'without'
      update()
    end
  end

  # Wiew:

  def coins
    @shop['coins']
  end

  def method_missing(method_name)
    if method_name.to_s.include?('__') # shop goods & prices
      method_args = method_name.to_s.split('__')
      ammunition_type, i = method_args
      ammunition_code = @shop['shop'][ammunition_type][i.to_i]
      ammunition_hh = YAML.safe_load_file("data/ammunition/#{ammunition_type}.yml")[ammunition_code]
      method_args.length == 3 ? ammunition_hh['price'] : ammunition_hh['name']
    else # in your warehouse ammunition
      ammunition_code = @shop[method_name.to_s]
      ammunition_hh = YAML.safe_load_file("data/ammunition/#{method_name.to_s}.yml")[ammunition_code]['name']
    end
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
        'weapon' => %w[without without without],
        'body_armor' => %w[without without without],
        'head_armor' => %w[without without without],
        'arms_armor' => %w[without without without],
        'shield' => %w[without without without]
      },
      'coins' => 0,
      'weapon' => 'without',
      'body_armor' => 'without',
      'head_armor' => 'without',
      'arms_armor' => 'without',
      'shield' => 'without'
    }
  end
end
