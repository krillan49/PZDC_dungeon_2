class PzdcMonolithLoot
  def initialize(hero, enemy, messages)
    @hero = hero
    @enemy = enemy
    @messages = messages
  end

  def looting
    count_points()
    if @points > 0
      PzdcMonolith.new.add_points(@points)
      display_screen()
    end
  end

  private

  def count_points
    sum = 0
    stats = ['hp_max', 'mp_max', 'min_dmg', 'max_dmg', 'regen_hp', 'regen_mp', 'armor', 'accuracy']
    stats.each do |stat|
      enemy_stat = @enemy.send(stat).to_f
      hero_stat = @hero.send(stat).to_f
      sum += (hero_stat <= 1 ? enemy_stat : enemy_stat / hero_stat)
    end
    @probability = sum / stats.length
    @points = @probability.floor + ((@probability - @probability.floor) > rand() ? 1 : 0)
  end

  def display_screen
    @messages.main = "You hear PZDC Monolith. Press Enter to continue"
    @messages.log << "probability is #{@probability.round(2)}"
    @messages.log << "The death of the #{@enemy.name} filled the monolith on #{@points}"
    puts "\e[H\e[2J"
    MainRenderer.new(:messages_screen, entity: @messages).display
    gets
  end
end











#
