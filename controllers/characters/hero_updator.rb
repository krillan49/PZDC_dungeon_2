class HeroUpdator

  def initialize(hero)
    @hero = hero

    @messages = MainMessage.new
  end

  def spend_stat_points
    while @hero.stat_points != 0
      distribution = ''
      until %w[1 2 3 4].include?(distribution)
        @messages.main = "Распределите очки характеристик. У вас осталось #{@hero.stat_points} очков" if @messages.main == ''
        @messages.log = [
          '+5 жизней                 (1)',
          '+5 выносливости           (2)',
          '+1 мин/макс случайно урон (3)',
          '+1 точность               (4)'
        ]
        MainRenderer.new(:hero_update_screen, @hero, @hero, entity: @messages).display
        distribution = gets.strip.upcase
        case distribution
        when '1'
          @hero.hp_max += 5
          @hero.hp += 5
          @messages.main = ''
        when '2'
          @hero.mp_max += 5
          @hero.mp += 5
          @messages.main = ''
        when '3'
          @hero.min_dmg_base < @hero.max_dmg_base && rand(0..1) == 0 ? @hero.min_dmg_base += 1 : @hero.max_dmg_base += 1
          @messages.main = ''
        when '4'
          @hero.accuracy_base += 1
          @messages.main = ''
        else
          @messages.main = "Вы ввели неверный символ, попробуйте еще раз. У вас осталось #{@hero.stat_points} очков"
        end
      end
      @hero.stat_points -= 1
    end
    @messages.main = ''
    @messages.clear_log
  end

  def spend_skill_points
    while @hero.skill_points != 0
      distribution = ''
      until %w[1 2 3].include?(distribution)
        @messages.main = "Распределите очки навыков. У вас осталось #{@hero.skill_points} очков" if @messages.main == ''
        @messages.log = [
          "+1 #{@hero.active_skill.name}   (1)",
          "+1 #{@hero.passive_skill.name}    (2)",
          "+1 #{@hero.camp_skill.name}  (3)"
        ]
        MainRenderer.new(:hero_update_screen, @hero, @hero, entity: @messages).display
        distribution = gets.strip.upcase
        case distribution
        when '1'
          @hero.active_skill.lvl += 1
          @messages.main = ''
        when '2'
          @hero.passive_skill.lvl += 1
          @messages.main = ''
        when '3'
          @hero.camp_skill.lvl += 1
          @messages.main = ''
        else
          @messages.main = "Вы ввели неверный символ, попробуйте еще раз. У вас осталось #{@hero.skill_points} очков"
        end
      end
      @hero.skill_points -= 1
    end
  end

end
