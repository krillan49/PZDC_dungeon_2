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
      end
    end
  end

  def animation_speed
    choose = nil
    until ['', '0'].include?(choose)
      MainRenderer.new(:options_animation_speed_screen, entity: @options).display
      choose = gets.strip
      if ('1'..'5').include?(choose)
        @options.set_enemy_actions_animation_speed_to(choose.to_i)
      end
    end
  end
end
