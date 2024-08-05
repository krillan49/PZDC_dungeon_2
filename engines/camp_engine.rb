class CampEngine
  def initialize
    @messages = MainMessage.new
    @pzdc_monolith = PzdcMonolith.new
  end

  def camp
    change_screen()
    MainRenderer.new(:camp_screen, entity: @messages).display
    choose = gets.to_i
    if choose == 1
      pzdc_monolith()
    end
  end

  def pzdc_monolith
    choose = nil
    until choose == 0
      change_screen()
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

  private

  def change_screen
    puts "\e[H\e[2J"
  end
end
