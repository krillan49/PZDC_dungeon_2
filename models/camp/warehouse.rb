class Warehouse
  PATH = 'saves/warehouse.yml'

  attr_accessor :warehouse

  def initialize
    create()
    @warehouse = YAML.safe_load_file(PATH)
  end

  def add_coins_from(hero)
    @warehouse['coins'] += hero.coins
    update()
  end

  private

  def create
    File.write(PATH, new_file_data().to_yaml) unless RubyVersionFixHelper.file_exists?(PATH) # File::exists?(PATH)
  end

  def update
    File.write(PATH, @warehouse.to_yaml)
  end

  def new_file_data
    {
      'coins' => 0,
      'weapon' => 'without',
      'body_armor' => 'without',
      'head_armor' => 'without',
      'arms_armor' => 'without',
      'shield' => 'without'
    }
  end
end
