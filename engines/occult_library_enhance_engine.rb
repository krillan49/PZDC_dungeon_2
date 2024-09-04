class OccultLibraryEnhanceEngine
  def initialize(hero)
    @hero = hero

    @messages = MainMessage.new
  end

  def start
    @messages.main = 'Continue: [Enter 0]            Echace ammunition: [Enter 1]'
    choose = nil
    until ['0', ''].include?(choose)
      MainRenderer.new(:messages_screen, entity: @messages, arts: [{ camp_fire: :rest }]).display
      choose = gets.strip.upcase
      if choose == '1'
        @ebr = EnhanceByRecipe.new(@hero) unless @ebr
        occult_library_recipe()
      end
    end
  end

  def occult_library_recipe
    choose = nil
    buttons = 'A'..'X'
    until ['0', ''].include?(choose)
      MainRenderer.new(:enhance_by_recipe_screen, entity: @ebr).display
      choose = gets.strip.upcase
      if buttons.include?(choose)
        i = choose.ord - 64 - 1
        if @ebr.accessible_recipes.size >= i && @ebr.has_ingredients?(i)
          recipe_data = @ebr.accessible_recipes[i]
          @recipe = OccultLibraryRecipe.new(recipe_data, @hero)
          MainRenderer.new(:camp_ol_recipe_screen, entity: @recipe).display
          gets
        elsif @ebr.accessible_recipes.size >= i
          recipe_data = @ebr.accessible_recipes[i]
          @recipe = OccultLibraryRecipe.new(recipe_data, @hero)
          MainRenderer.new(:camp_ol_recipe_screen, entity: @recipe).display
          gets
        end
      end
    end
  end

end
