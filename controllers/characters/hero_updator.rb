class HeroUpdator

  def initialize(hero)
    @hero = hero

    @messages = MainMessage.new
  end

  def spend_stat_points
    while @hero.stat_points != 0
      distribution = ''
      dice1, dice2 = rand(1..6), rand(1..6)
      strong_stat = dice1 + dice2
      loop do
        @messages.main = "Distribute stat points. You have #{@hero.stat_points} points left" if @messages.main == ''
        @messages.log = [
          "The dice showed: #{strong_stat} (#{dice1} + #{dice2})",
          '',
          '+5 hp                     [1]',
          '+5 mp                     [2]'
        ]
        @messages.log += [
          '+1 accuracy               [3]'
        ] if strong_stat >= 8
        @messages.log += [
          '+1 min/max(random) damage [4]'
        ] if strong_stat >= 11
        MainRenderer.new(:hero_update_screen, @hero, @hero, entity: @messages).display
        distribution = gets.strip.upcase
        AmmunitionShow.show_weapon_buttons_actions(distribution, @hero)
        if distribution == '1'
          @hero.hp_max += 5
          @hero.hp += 5
          @messages.main = ''
          break
        elsif distribution == '2'
          @hero.mp_max += 5
          @hero.mp += 5
          @messages.main = ''
          break
        elsif distribution == '3' && strong_stat >= 8
          @hero.accuracy_base += 1
          @messages.main = ''
          break
        elsif distribution == '4' && strong_stat >= 11
          @hero.add_dmg_base
          @messages.main = ''
          break
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
      dice1, dice2 = rand(1..6), rand(1..6)
      count_of_skill = dice1 + dice2 >= 10 ? 3 : dice1 + dice2 >= 6 ? 2 : 1
      skills = %w[active_skill passive_skill camp_skill].sample(count_of_skill)
        .sort_by{|e| {'active_skill' => 1, 'passive_skill' => 2, 'camp_skill' => 3}[e]}
      skiils_indexes = skills.map.with_index(1){|_,i| i}
      until skiils_indexes.include?(distribution.to_i)
        @messages.main = "Distribute skill points. You have #{@hero.skill_points} points left" if @messages.main == ''
        @messages.log = [
          "The dice showed: #{dice1 + dice2} (#{dice1} + #{dice2})",
          '',
          show_diced_skill(@hero.send(skills[0]).name, 1)
        ]
        @messages.log += [ show_diced_skill(@hero.send(skills[1]).name, 2) ] if count_of_skill >= 2
        @messages.log += [ show_diced_skill(@hero.send(skills[2]).name, 3) ] if count_of_skill >= 3
        MainRenderer.new(:hero_update_screen, @hero, @hero, entity: @messages).display
        distribution = gets.strip.upcase
        AmmunitionShow.show_weapon_buttons_actions(distribution, @hero)
        if skiils_indexes.include?(distribution.to_i)
          @hero.send(skills[distribution.to_i-1]).lvl += 1
          @messages.main = ''
        else
          @messages.main = "You entered an invalid character, please try again. You have #{@hero.skill_points} points remaining"
        end
      end
      @hero.skill_points -= 1
    end
  end

  private

  def show_diced_skill(skill_name, n)
    aligned_skill_name = skill_name + (' ' * (20 - skill_name.length))
    "#{aligned_skill_name} [#{n}]"
  end

end
