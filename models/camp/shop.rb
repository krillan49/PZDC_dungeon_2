class Shop
  PATH = 'saves/shop.yml'
  SELL_CHANCE = 3
  MAX_CAPACITY = 3
  ITEMS_FOR_FILL = {
    'weapon' => %w[stick knife club],
    'body_armor' => %w[leather_jacket rusty_gambeson],
    'head_armor' => %w[rusty_quilted_helmet leather_helmet],
    'arms_armor' => %w[worn_gloves leather_gloves],
    'shield' => %w[holey_wicker_buckler braided_buckler wooden_buckler]
  }

  def initialize
    create()
    @shop = YAML.safe_load_file(PATH)
    @warehouse = Warehouse.new
  end

  def fill
    %w[weapon body_armor head_armor arms_armor shield].each do |ammunition_type|
      without_count = @shop['ammunition'][ammunition_type].count('without')
      n = without_count == 3 ? 2 : without_count == 2 ? 1 : 0
      n.times do
        i = @shop['ammunition'][ammunition_type].index('without')
        @shop['ammunition'][ammunition_type][i] = ITEMS_FOR_FILL[ammunition_type].sample
      end
    end
    update()
  end

  def add_ammunition_from(hero)
    %w[weapon body_armor head_armor arms_armor shield].each do |ammunition_type|
      ammunition_code = hero.send(ammunition_type).code
      if rand(SELL_CHANCE) == 0 && ammunition_code != 'without'
        @shop['ammunition'][ammunition_type] = [] unless @shop['ammunition'][ammunition_type]
        remove_random_item_of_type(ammunition_type) if @shop['ammunition'][ammunition_type].length >= MAX_CAPACITY
        @shop['ammunition'][ammunition_type] << ammunition_code
      end
    end
    update()
  end

  def remove_random_item_of_type(ammunition_type)
    choose = if @shop['ammunition'][ammunition_type].include?('without')
      @shop['ammunition'][ammunition_type].index('without')
    else
      rand(@shop['ammunition'][ammunition_type].length)
    end
    @shop['ammunition'][ammunition_type] = @shop['ammunition'][ammunition_type].reject.with_index{|_, i| i == choose}
  end

  # add ammunition to your warehouse

  def sell_amunition(n)
    ammunition_type, i = [
      ['weapon', 0], ['weapon', 1], ['weapon', 2],
      ['body_armor', 0], ['body_armor', 1], ['body_armor', 2],
      ['head_armor', 0], ['head_armor', 1], ['head_armor', 2],
      ['arms_armor', 0], ['arms_armor', 1], ['arms_armor', 2],
      ['shield', 0], ['shield', 1], ['shield', 2]
    ][n-1]
    ammunition_code = @shop['ammunition'][ammunition_type][i]
    ammunition_price = YAML.safe_load_file("data/ammunition/#{ammunition_type}.yml")[ammunition_code]['price']
    if @warehouse.show('coins') >= ammunition_price && ammunition_code != 'without'
      @warehouse.take_coins_from_warehouse(ammunition_price)
      @warehouse.add_ammunition_to_warehouse(ammunition_type, @shop['ammunition'][ammunition_type][i])
      @shop['ammunition'][ammunition_type][i] = 'without'
      update()
    end
  end

  # Wiew:

  def coins
    @warehouse.show('coins')
  end

  def method_missing(method_name)
    if method_name.to_s.include?('__') # shop goods & prices
      method_args = method_name.to_s.split('__')
      ammunition_type, i = method_args
      ammunition_code = @shop['ammunition'][ammunition_type][i.to_i]
      ammunition_hh = YAML.safe_load_file("data/ammunition/#{ammunition_type}.yml")[ammunition_code]
      method_args.length == 3 ? ammunition_hh['price'] : ammunition_hh['name']
    else # in your warehouse ammunition
      ammunition_code = @warehouse.show(method_name.to_s)
      ammunition_hh = YAML.safe_load_file("data/ammunition/#{method_name.to_s}.yml")[ammunition_code]['name']
    end
  end

  # return item_code for display item screen

  def get_item_type_and_code_name(char_code)
    {
      'a' => ['weapon', @shop['ammunition']['weapon'][0]],
      'b' => ['weapon', @shop['ammunition']['weapon'][1]],
      'c' => ['weapon', @shop['ammunition']['weapon'][2]],
      'd' => ['body_armor', @shop['ammunition']['body_armor'][0]],
      'e' => ['body_armor', @shop['ammunition']['body_armor'][1]],
      'f' => ['body_armor', @shop['ammunition']['body_armor'][2]],
      'g' => ['head_armor', @shop['ammunition']['head_armor'][0]],
      'h' => ['head_armor', @shop['ammunition']['head_armor'][1]],
      'i' => ['head_armor', @shop['ammunition']['head_armor'][2]],
      'j' => ['arms_armor', @shop['ammunition']['arms_armor'][0]],
      'k' => ['arms_armor', @shop['ammunition']['arms_armor'][1]],
      'l' => ['arms_armor', @shop['ammunition']['arms_armor'][2]],
      'm' => ['shield', @shop['ammunition']['shield'][0]],
      'n' => ['shield', @shop['ammunition']['shield'][1]],
      'o' => ['shield', @shop['ammunition']['shield'][2]],
      'v' => ['weapon', @warehouse.show('weapon')],
      'w' => ['body_armor', @warehouse.show('body_armor')],
      'x' => ['head_armor', @warehouse.show('head_armor')],
      'y' => ['arms_armor', @warehouse.show('arms_armor')],
      'z' => ['shield', @warehouse.show('shield')]
    }[char_code]
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
      'ammunition' => {
        'weapon' => %w[without without without],
        'body_armor' => %w[without without without],
        'head_armor' => %w[without without without],
        'arms_armor' => %w[without without without],
        'shield' => %w[without without without]
      }
    }
  end
end
