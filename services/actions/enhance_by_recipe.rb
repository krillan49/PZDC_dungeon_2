class EnhanceByRecipe
  def initialize(hero)
    @hero = hero
    @accessible_recipes = accessible_recipes()
  end

  def has_ingredients?(recipe)
    recipe.all?{|recipe_name, count| @hero.ingredients[recipe_name] && @hero.ingredients[recipe_name] >= count}
  end

  # Wiew:

  def method_missing(method_name)
    method_args = method_name.to_s.split('__')
    name, i = method_args
    recipe = @accessible_recipes[i.to_i]
    return '' unless recipe
    if name == 'has_ingredients'
      # @recipes[recipe[0]] ? 'IN YOUR WAREHOUSE' : "[Enter #{i}]"
    elsif name == 'show'
      "[Enter #{(i.to_i+64).chr}]"
    else
      recipe[1][name]
    end
  end

  private

  def accessible_recipes
    occult_library = YAML.safe_load_file('data/camp/occult_library.yml')
    recipes = YAML.safe_load_file('saves/occult_library.yml')
    occult_library.select{|k,_| recipes[k]}.to_a.sort{|a, b| a[0] <=> b[0]}
  end

end
