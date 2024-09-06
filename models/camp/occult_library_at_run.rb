class OccultLibraryAtRun
  def initialize(hero)
    @hero = hero
    @accessible_recipes = accessible_recipes()
  end

  def find_recipe(i)
    @accessible_recipes[i]
  end

  def has_ingredients?(i)
    @accessible_recipes[i][1]['recipe'].all? do |ingredient_name, count|
      @hero.ingredients[ingredient_name] && @hero.ingredients[ingredient_name] >= count
    end
  end

  def accessible_recipes
    occult_library = YAML.safe_load_file('data/camp/occult_library.yml')
    recipes = YAML.safe_load_file('saves/occult_library.yml')
    occult_library.select{|k,_| recipes[k]}.to_a.sort{|a, b| a[0] <=> b[0]}
  end

  # Wiew:

  def method_missing(method_name)
    method_args = method_name.to_s.split('__')
    name, i = method_args
    recipe = @accessible_recipes[i.to_i-1]
    return '' unless recipe
    if name == 'has_ingredients'
      has_ingredients?(i.to_i-1) ? 'YES' : 'NO'
    elsif name == 'show'
      "[Enter #{(i.to_i+64).chr}]"
    else
      recipe[1][name]
    end
  end

end
