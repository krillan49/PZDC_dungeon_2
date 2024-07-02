class HeroUpdator

  def initialize(hero)
    @hero = hero
  end

  def spend_stat_points
    while @hero.stat_points != 0
      puts InfoBlock.hero_name_level_exp(@hero)
      Menu.new(:character_stats, @hero).display
      Menu.new(:character_skills, @hero).display
      distribution = ''
      until %w[H M X A].include?(distribution)
        puts "Распределите очки характеристик. У вас осталось #{@hero.stat_points} очков"
        print '+5 жизней(H). +5 выносливости(M). +1 мин/макс случайно урон(X). +1 точность(A)  '
        distribution = gets.strip.upcase
        case distribution
        when 'H'
          @hero.hp_max += 5
          @hero.hp += 5
        when 'M'
          @hero.mp_max += 5
          @hero.mp += 5
        when 'X'
          @hero.min_dmg_base < @hero.max_dmg_base && rand(0..1) == 0 ? @hero.min_dmg_base += 1 : @hero.max_dmg_base += 1
        when 'A'
          @hero.accuracy_base += 1
        else
          puts 'Вы ввели неверный символ, попробуйте еще раз'
        end
      end
      @hero.stat_points -= 1
    end
  end

  def spend_skill_points
    while @hero.skill_points != 0
      puts InfoBlock.hero_name_level_exp(@hero)
      Menu.new(:character_stats, @hero).display
      Menu.new(:character_skills, @hero).display
      distribution = ''
      until %w[S P N].include?(distribution)
        puts "Распределите очки навыков. У вас осталось #{@hero.skill_points} очков"
        print "+1 #{@hero.active_skill.name}(S). +1 #{@hero.passive_skill.name}(P). +1 #{@hero.camp_skill.name}(N) "
        distribution = gets.strip.upcase
        case distribution
        when 'S'; @hero.active_skill.lvl += 1
        when 'P'; @hero.passive_skill.lvl += 1
        when 'N'; @hero.camp_skill.lvl += 1
        else
          puts 'Вы ввели неверный символ, попробуйте еще раз'
        end
      end
      @hero.skill_points -= 1
    end
  end

end
