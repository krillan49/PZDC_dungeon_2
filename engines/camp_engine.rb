class CampEngine
  def initialize
    @messages = MainMessage.new
  end

  def camp
    choose = nil
    until choose == 0
      MainRenderer.new(:camp_screen).display
      choose = gets.to_i
      if choose == 1
        pzdc_monolith()
      elsif choose == 2
        shop()
      elsif choose == 3
        occult_library()
      elsif choose == 4
        statistics()
      end
    end
  end

  def pzdc_monolith
    @pzdc_monolith = PzdcMonolith.new
    choose = nil
    until choose == 0
      MainRenderer.new(:camp_monolith_screen, entity: @pzdc_monolith, arts: [{ camp: :pzdc_monolith }]).display
      choose = gets.to_i
      if choose > 0 && choose < 11
        characteristic = %w[hp mp accuracy damage stat_points skill_points armor regen_hp regen_mp armor_penetration][choose-1]
        @pzdc_monolith.take_points_to(characteristic)
      end
    end
  end

  def shop
    @shop = Shop.new
    @shop.fill
    choose = nil
    buttons = %w[A B C D E F G H I J K L M N O V W X Y Z]
    until ['0', ''].include?(choose)
      MainRenderer.new(:camp_shop_screen, entity: @shop).display
      choose = gets.strip
      if buttons.include?(choose.upcase)
        ammunition_type, ammunition_code = Shop.new.get_item_type_and_code_name(choose)
        if ammunition_code != 'without'
          ammunition_obj = AmmunitionCreator.create(ammunition_type, ammunition_code)
          AmmunitionShow.display(type: ammunition_type, code: ammunition_code, arts: [{normal: ammunition_obj}])
        end
      elsif choose.to_i > 0 && choose.to_i <= 15
        @shop = Shop.new
        @shop.sell_amunition(choose.to_i)
      end
    end
  end

  def occult_library
    @occult_library = OccultLibrary.new
    choose = nil
    buttons = 'A'..'X'
    until ['0', ''].include?(choose)
      MainRenderer.new(:camp_occult_library_screen, entity: @occult_library).display
      choose = gets.strip
      if buttons.include?(choose.upcase) && @occult_library.can_show_this_recipe?(choose.upcase)
        recipe_data = @occult_library.find_recipe(choose.upcase.ord - 64)
        @recipe = OccultLibraryRecipe.new(recipe_data)
        MainRenderer.new(:camp_ol_recipe_screen, entity: @recipe).display
        gets
      elsif choose.to_i > 0 && choose.to_i <= 24 && @occult_library.can_sell_this_recipe?(choose.to_i)
        @occult_library.sell(choose.to_i)
      end
    end
  end

  def statistics
    @statistics = StatisticsTotal.new
    choose = nil
    if boss?()
      dungeon_nums = (1..4)
      @messages.main = 'PZDC BOSS       [Enter 4]'
    else
      dungeon_nums = (1..3)
      @messages.main = ''
    end
    until choose == 0
      MainRenderer.new(:statistics_choose_screen, entity: @messages).display
      choose = gets.to_i
      if dungeon_nums.include?(choose)
        dungeon_code = %w[bandits undeads swamp pzdc][choose-1]
        @statistics.create_subdatas(dungeon_code: dungeon_code)
        MainRenderer.new(:statistics_enemyes_camp_screen, entity: @statistics).display
        gets
      end
    end
  end

  private

  def boss?
    sd = @statistics.data
    sd['bandits']['bandit_leader'] > 0 && sd['undeads']['zombie_knight'] > 0 && sd['swamp']['ancient_snail'] > 0
  end

end
