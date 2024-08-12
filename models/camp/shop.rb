class Shop
  PATH = 'saves/shop.yml'
  SELL_CHANCE = 3
  MAX_CAPACITY = 5

  def initialize
    create()
    @shop = YAML.safe_load_file(PATH)
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
    choose = rand(@shop['ammunition'][ammunition_type].length)
    @shop['ammunition'][ammunition_type] = @shop['ammunition'][ammunition_type].reject.with_index{|_, i| i == choose}
  end

  def sell_amunition_to()
  end

  # getters:
  # def method_missing(method)
  #   @shop[method.to_s]
  # end

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
        'arms_armor' => nil,
        'body_armor' => nil,
        'head_armor' => nil,
        'shield' => nil,
        'weapon' => nil
      }
    }
  end
end
