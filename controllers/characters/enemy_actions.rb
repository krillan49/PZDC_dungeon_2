module EnemyActions
  def self.regeneration_hp_mp(enemy, messages) # регенерация в бою
    if enemy.regen_hp > 0 && enemy.hp_max > enemy.hp
      enemy.hp += [enemy.regen_hp, enemy.hp_max - enemy.hp].min
      messages.log << "#{enemy.name} regenerating #{enemy.regen_hp} hp"
    end
    # if enemy.regen_mp > 0 && enemy.mp_max > enemy.mp
    #   enemy.mp += [enemy.regen_mp, enemy.mp_max - enemy.mp].min
    #   if messages.log[-1].include?('regenerating')
    #     messages.log[-1] += ". #{enemy.name} regenerating #{hero.regen_mp} mp"
    #   else
    #     messages.log << "#{enemy.name} regenerating #{enemy.regen_hp} mp"
    #   end
    # end
  end
end
