class OccultLibraryRecipe
  attr_reader :code_name, :view_code, :name, :price, :recipe_ingredients

  def initialize(data, hero=nil)
    @data = data
    @hero = hero

    @code_name = data[0]
    @view_code = data[1]['view_code']
    @name = data[1]['name']
    @price = data[1]['price']

    # hashes:
    @recipe_ingredients = data[1]['recipe']
    # @weapon = data[1]['effect']['weapon']
    # @head_armor = data[1]['effect']['head_armor']
    # @body_armor = data[1]['effect']['body_armor']
    # @arms_armor = data[1]['effect']['arms_armor']
    # @shield = data[1]['effect']['shield']
  end

  def hero_has_ingredients?
    return false unless @hero
    @recipe_ingredients.all? do |ingredient_name, count|
      @hero.ingredients[ingredient_name] && @hero.ingredients[ingredient_name] >= count
    end
  end

  def effect_of(ammunition_type)
    @data[1]['effect'][ammunition_type]
  end

  # show
  def method_missing(method_name)
    if @hero && method_name.to_s.include?('hero__')
      ammunition_type, ammunition_method = method_name.to_s.split('__')[1..2]
      @hero.send(ammunition_type).send(ammunition_method)
    elsif method_name.to_s == 'ingredients'
      @hero ? "Your ingredients:     #{hh_data_to_s(@hero.ingredients)}" : ''
    else
      result_data = method_name.to_s == 'recipe' ? @data[1]['recipe'] : @data[1]['effect'][method_name.to_s]
      hh_data_to_s(result_data)
    end
  end

  private

  def hh_data_to_s(hh_data)
    hh_data.map{|name, value| "#{name.capitalize.tr('_',' ')}: #{value}"}.sort.join(';   ')
  end

end
