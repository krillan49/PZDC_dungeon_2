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
    choose = rand(@shop['shop'][ammunition_type].length)
    @shop['shop'][ammunition_type] = @shop['shop'][ammunition_type].reject.with_index{|_, i| i == choose}
  end

  def sell_amunition()
  end

  # getters for screen: weapon__0__name, body_armor__0__, head_armor__0, arms_armor__0, shield__0
  # Или ппросто выводить название, а чтобы посмотреть статы амуниции открывать окно от ее сущности
  def method_missing(method)
    ammunition_type, i = method.split('__')
    # @shop['shop'][ammunition_type][i]
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
        'arms_armor' => nil,
        'body_armor' => nil,
        'head_armor' => nil,
        'shield' => nil,
        'weapon' => nil
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
