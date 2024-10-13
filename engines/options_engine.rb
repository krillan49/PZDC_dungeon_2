class OptionsEngine
  def initialize
    @options = Options.new
  end

  def main
    choose = nil
    until ['', '0'].include?(choose)
      MainRenderer.new(:options_choose_screen).display
      choose = gets.strip
      if choose == '1'
        animation_speed()
      elsif choose == '2'
        screen_replacement_type()
      end
    end
  end

  def animation_speed
    choose = nil
    until ['', '0'].include?(choose)
      MainRenderer.new(:options_animation_speed_screen, entity: @options).display
      choose = gets.strip
      if ('1'..'5').include?(choose)
        @options.set_enemy_actions_animation_speed_to(choose.to_i-1)
      end
    end
  end

  def screen_replacement_type
    choose = nil
    until ['', '0'].include?(choose)
      MainRenderer.new(:options_screen_replacement_type_screen, entity: @options).display
      choose = gets.strip
      if ('1'..'3').include?(choose)
        @options.set_screen_replacement_type_to(choose.to_i-1)
      end
    end
  end

end
