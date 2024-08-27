class CampEngine
  def initialize
    @messages = MainMessage.new

    @pzdc_monolith = PzdcMonolith.new
    @shop = Shop.new
  end

  def camp
    choose = nil
    until choose == 0
      MainRenderer.new(:camp_screen, entity: @messages).display
      choose = gets.to_i
      if choose == 1
        pzdc_monolith()
      elsif choose == 2
        shop()
      end
    end
  end

  def pzdc_monolith
    choose = nil
    until choose == 0
      MainRenderer.new(:camp_monolith_screen, entity: @pzdc_monolith, arts: [{ camp: :pzdc_monolith }]).display
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
    until choose == '0'
      MainRenderer.new(:camp_shop_screen, entity: @shop).display
      choose = gets.strip
      if choose == '0'
        break
      elsif %w[A B C D E F G H I J K L M N O V W X Y Z].include?(choose.upcase)
        ammunition_type, ammunition_code = Shop.new.get_item_type_and_code_name(choose)
        AmmunitionShow.show(ammunition_type, ammunition_code) if ammunition_code != 'without'
      elsif choose.to_i > 0 && choose.to_i <= 15
        @shop = Shop.new
        @shop.sell_amunition(choose.to_i)
      end
    end
  end

end
