class HeroUpdator

  def initialize(hero)
    @hero = hero

    @messages = MainMessage.new
  end

  def spend_stat_points
    while @hero.stat_points != 0
      distribution = ''
      until %w[1 2 3 4].include?(distribution)
        @messages.main = "Distribute stat points. You have #{@hero.stat_points} points left" if @messages.main == ''
        @messages.log = [
          '+5 hp                     (1)',
          '+5 mp                     (2)',
          '+1 min/max(random) damage (3)',
          '+1 accuracy               (4)'
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
          @messages.main = "You entered an invalid character, please try again. You have #{@hero.stat_points} points remaining"
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
        @messages.main = "Distribute skill points. You have #{@hero.skill_points} points left" if @messages.main == ''
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
          @messages.main = "You entered an invalid character, please try again. You have #{@hero.skill_points} points remaining"
        end
      end
      @hero.skill_points -= 1
    end
  end

end
