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
        @ebr = OccultLibraryAtRun.new(@hero) unless @ebr
        recipes_list()
      end
    end
  end

  private

  def recipes_list
    choose = nil
    buttons = 'A'..'X'
    until ['0', ''].include?(choose)
      MainRenderer.new(:enhance_by_recipe_screen, entity: @ebr).display
      choose = gets.strip.upcase
      show_recipe(choose.ord - 64 - 1) if buttons.include?(choose)
    end
  end

  def show_recipe(i)
    if @ebr.accessible_recipes.size > i && @ebr.has_ingredients?(i)
      recipe_data = @ebr.accessible_recipes[i]
      @recipe = OccultLibraryRecipe.new(recipe_data, @hero)
      show_or_enhance_ammunition()
    elsif @ebr.accessible_recipes.size > i
      recipe_data = @ebr.accessible_recipes[i]
      @recipe = OccultLibraryRecipe.new(recipe_data, @hero)
      MainRenderer.new(:camp_ol_recipe_screen, entity: @recipe).display
      gets
    end
  end

  def show_or_enhance_ammunition
    choose = nil
    show_buttons, enhance_buttons = 'A'..'E', '1'..'5'
    until ['0', ''].include?(choose)
      MainRenderer.new(:camp_ol_enhance_screen, entity: @recipe).display
      choose = gets.strip.upcase
      if show_buttons.include?(choose)
        show_ammunition(choose)
      elsif enhance_buttons.include?(choose)
        enhance_ammunition(choose.to_i-1)
      end
    end
  end

  def show_ammunition(char)
    ammunition_type = {'A'=>'weapon','B'=>'head_armor','C'=>'body_armor','D'=>'arms_armor','E'=>'shield'}[char]
    MainRenderer.new(:"ammunition_#{ammunition_type}_screen", entity: @hero.send(ammunition_type)).display
    gets
  end

  def enhance_ammunition(n)
    ammunition_type = %w[weapon head_armor body_armor arms_armor shield][n]
    ammunition_obj = @hero.send(ammunition_type)
    if ammunition_obj.code != 'without' && @recipe.hero_has_ingredients?
      OccultLibraryEnhanceService.new(@hero, ammunition_obj, ammunition_type, @recipe).enhance
    end
  end

end
