class Warehouse
  PATH = 'saves/warehouse.yml'

  def initialize
    create()
    @warehouse = YAML.safe_load_file(PATH)
  end

  def add_coins_from(hero)
    @warehouse['coins'] += hero.coins
    update()
  end

  def take_coins_from_warehouse(n)
    if @warehouse['coins'] >= n
      @warehouse['coins'] -= n
      update()
      true
    else
      false
    end
  end

  def add_ammunition_to_warehouse(ammunition_type, ammunition_code)
    @warehouse[ammunition_type] = ammunition_code
    update()
  end

  # add ammunition to hero from warehouse
  def take_ammunition_by(hero)
    if @warehouse['weapon'] != 'without'
      hero.weapon = Weapon.new(@warehouse['weapon'])
      @warehouse['weapon'] = 'without'
    end
    if @warehouse['body_armor'] != 'without'
      hero.body_armor = BodyArmor.new(@warehouse['body_armor'])
      @warehouse['body_armor'] = 'without'
    end
    if @warehouse['head_armor'] != 'without'
      hero.head_armor = HeadArmor.new(@warehouse['head_armor'])
      @warehouse['head_armor'] = 'without'
    end
    if @warehouse['arms_armor'] != 'without'
      hero.arms_armor = ArmsArmor.new(@warehouse['arms_armor'])
      @warehouse['arms_armor'] = 'without'
    end
    if @warehouse['shield'] != 'without'
      hero.shield = Shield.new(@warehouse['shield'])
      @warehouse['shield'] = 'without'
    end
    update()
  end

  # maybe this method dont need more ? or may be used in the future instead take_ammunition_by(hero) method
  def take_ammunition_from_warehouse(ammunition_type)
    ammunition_code = @warehouse[ammunition_type]
    @warehouse[ammunition_type] = 'without'
    update()
    ammunition_code
  end

  # getters

  def show(type)
    @warehouse[type]
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
