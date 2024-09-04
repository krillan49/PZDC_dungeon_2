class OccultLibraryRecipe
  attr_reader :code_name, :view_code, :name, :price
  # attr_reader :recipe, :weapon, :head_armor, :body_armor, :arms_armor, :shield

  def initialize(data, hero=nil)
    @data = data
    @hero = hero

    @code_name = data[0]
    @view_code = data[1]['view_code']
    @name = data[1]['name']
    @price = data[1]['price']

    # hashes:
    # @recipe = data[1]['recipe']
    # @weapon = data[1]['effect']['weapon']
    # @head_armor = data[1]['effect']['head_armor']
    # @body_armor = data[1]['effect']['body_armor']
    # @arms_armor = data[1]['effect']['arms_armor']
    # @shield = data[1]['effect']['shield']
  end

  # show
  def method_missing(method_name)
    if method_name.to_s == 'ingredients'
      @hero ? "Your ingredients:     #{hh_data_to_s(@hero.ingredients)}" : ''
    else
      result_data = method_name.to_s == 'recipe' ? @data[1]['recipe'] : @data[1]['effect'][method_name.to_s]
      hh_data_to_s(result_data)
    end
  end

  private

  def hh_data_to_s(hh_data)
    hh_data.map{|name, value| "#{name.capitalize.tr('_',' ')}: #{value}"}.join(';   ')
  end

end
