class CampEngine
  def initialize
    @messages = MainMessage.new

    @pzdc_monolith = PzdcMonolith.new
    @shop = Shop.new
  end

  def camp
    MainRenderer.new(:camp_screen, entity: @messages).display
    choose = gets.to_i
    if choose == 1
      pzdc_monolith()
    elsif choose == 2
      shop()
    end
  end

  def pzdc_monolith
    choose = nil
    until choose == 0
      MainRenderer.new(:camp_monolith_screen, entity: @pzdc_monolith).display
      choose = gets.to_i
      if choose == 0
        break
      elsif choose > 0 && choose < 10
        characteristic = %w[hp mp accuracy damage stat_points skill_points armor regen_hp regen_mp][choose-1]
        @pzdc_monolith.take_points_to(characteristic)
      end
    end
  end

  def shop
    choose = nil
    until choose == 0
      MainRenderer.new(:camp_shop_screen, entity: @shop).display
      choose = gets.to_i
      if choose == 0
        break
      elsif choose > 0 && choose <= 15
        @shop = Shop.new
        @shop.sell_amunition(choose)
      end
    end
  end

end
