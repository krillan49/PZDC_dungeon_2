class OccultLibraryEnhanceService
  def initialize(hero, ammunition, ammunition_type, recipe)
    @hero = hero
    @ammunition = ammunition
    @ammunition_type = ammunition_type
    @recipe = recipe
  end

  def enhance
    @recipe.recipe_ingredients.each do |ingredient_name, value|
      @hero.ingredients[ingredient_name] -= value
    end
    @ammunition.enhance = true
    @ammunition.enhance_name = @recipe.code_name
    effect = @recipe.effect_of(@ammunition_type)
    effect.each do |stat_name, value|
      @ammunition.send("enhance_#{stat_name}=", value)
    end
  end
end
