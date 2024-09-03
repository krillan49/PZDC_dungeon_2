class OccultLibrary
  SAVE_PATH = 'saves/occult_library.yml'
  DATA_PATH = 'data/camp/occult_library.yml'

  def initialize
    @occult_library = YAML.safe_load_file(DATA_PATH)
    @warehouse = Warehouse.new
    create()
    @recipes = YAML.safe_load_file(SAVE_PATH)
    update()
  end

  def can_sell_this_recipe?(n)
    n <= @occult_library.keys.length && !@recipes[find_recipe(n)[0]]
  end

  def can_show_this_recipe?(char)
    char.ord - 64 <= @occult_library.keys.length
  end

  def sell(n)
    recipe = find_recipe(n)
    price = recipe[1]['price']
    has_money = @warehouse.take_coins_from_warehouse(price)
    if has_money
      @recipes[recipe[0]] = true
      update()
    end
  end

  # Wiew:

  def coins
    @warehouse.show('coins')
  end

  def method_missing(method_name)
    method_args = method_name.to_s.split('__')
    name, i = method_args
    recipe = find_recipe(i.to_i)
    return '' unless recipe
    if name == 'status'
      @recipes[recipe[0]] ? 'IN YOUR WAREHOUSE' : "[Enter #{i}]"
    elsif name == 'show'
      "[Enter #{(i.to_i+64).chr}]"
    elsif name == 'price' && @recipes[recipe[0]]
      'SOLD'
    else
      recipe[1][name]
    end
  end

  def find_recipe(n)
    @occult_library.find{|_,v| v['view_code'] == n}
  end

  private

  def create
    File.write(SAVE_PATH, new_file_data().to_yaml) unless RubyVersionFixHelper.file_exists?(SAVE_PATH) # File::exists?(SAVE_PATH)
  end

  def update
    not_all_keys = false
    @occult_library.keys.each do |k|
      unless @recipes[k]
        @recipes[k] = false
        not_all_keys = true
      end
    end
    File.write(SAVE_PATH, @recipes.to_yaml) if not_all_keys
  end

  def new_file_data
    @occult_library.keys.map{|k| [k, false]}.to_h
  end

end
