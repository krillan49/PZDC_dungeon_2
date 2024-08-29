class AttacksRound
  def initialize(hero, enemy, messages)
    @hero = hero
    @hero_damage = rand(hero.min_dmg..hero.max_dmg)
    @hero_accuracy = @hero.accuracy
    @hero_block_successful = @hero.block_chance >= rand(1..100)

    @enemy = enemy
    @enemy_damage = rand(enemy.min_dmg..enemy.max_dmg)
    @enemy_accuracy = @enemy.accuracy
    @enemy_block_successful = @enemy.block_chance >= rand(1..100)

    @messages = messages
  end

  def action
    hero_select_type_of_attack()
    enemy_select_type_of_attack()
    count_hero_final_damage()
    count_enemy_final_damage()
    hero_attack_effects()
    enemy_attack_effects() if @enemy.hp > 0
    HeroActions.regeneration_hp_mp(@hero, @messages)
    EnemyActions.regeneration_hp_mp(@enemy, @messages) if @enemy.hp > 0
    round_result()
  end

  def hero_run?
    if @hero.hp < (@hero.hp_max * 0.15) && @hero.hp > 0 && @enemy.hp > 0
      @messages.main = 'You are on the threshold of death'
      @messages.actions = 'Try to escape? (y/N)'
      MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ normal: @enemy }]).display
      run_select = gets.strip.upcase
      if run_select == 'Y'
        if rand(0..2) >= 10
          @messages.actions = 'Managed to escape'
          @messages.log << "The coward ran away"
          MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ attack: @enemy }]).display
          return true
        else
          @hero.hp -= @enemy_damage
          @messages.main = 'Failed to escape'
          @messages.actions = 'To continue press Enter'
          @messages.log << "#{@enemy.name} dealt #{@enemy_damage.round} damage"
          MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ attack: @enemy }]).display
          gets
          if @hero.hp <= 0
            @messages.log << "You are dead - you cowardly dog!"
            MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ game_over: :game_over }]).display
            gets
            MainRenderer.new(:run_end_screen, entity: @messages, arts: [{ end: :run_end_art }]).display
            gets
            DeleteHeroInRun.new(@hero).add_camp_loot_and_delete_hero_file
          end
        end
      end
    end
    false
  end

  def hero_dead?
    @hero.hp <= 0
  end

  private

  def hero_select_type_of_attack
    success = false # для проверки возможно ли проведение выбранной атаки
    until success
      @messages.main = "Attack #{@enemy.name}"
      @messages.actions = 'Hit body [enter 1]     Hit head [enter 2]     Hit legs [enter 3]     Use skill [enter 4]'
      MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ normal: @enemy }]).display
      @messages.clear_log
      selected_type = gets.strip.upcase
      success = case selected_type
      when '2'; hero_head_attack_type?()
      when '3'; hero_legs_attack_type?()
      when '4'; hero_skill_attack_type?()
      else; hero_body_attack_type?()
      end
    end
  end
  def hero_body_attack_type?
    @hero_attack_type = "to the body"
    true
  end
  def hero_head_attack_type?
    @hero_damage *= 1.5
    @hero_accuracy *= 0.7
    @hero_attack_type = "to the head"
    true
  end
  def hero_legs_attack_type?
    @hero_damage *= 0.7
    @hero_accuracy *= 1.5
    @hero_attack_type = "in the legs"
    true
  end
  def hero_skill_attack_type?
    if @hero.mp >= @hero.active_skill.mp_cost
      @hero_damage *= @hero.active_skill.damage_mod
      @hero_accuracy *= @hero.active_skill.accuracy_mod
      @hero_attack_type = @hero.active_skill.name
      @hero.mp -= @hero.active_skill.mp_cost
      true
    else
      @messages.log << "Not enough mp to #{@hero.active_skill.name}"
      false
    end
  end
  #
  def enemy_select_type_of_attack
    selected_type = rand(1..10)
    case selected_type
    when 1; enemy_head_attack_type()
    when 2; enemy_legs_attack_type()
    else; enemy_body_attack_type()
    end
  end
  def enemy_body_attack_type
    @enemy_attack_type = "to the body"
  end
  def enemy_head_attack_type
    @enemy_damage *= 1.5
    @enemy_accuracy *= 0.7
    @enemy_attack_type = "to the head"
  end
  def enemy_legs_attack_type
    @enemy_damage *= 0.7
    @enemy_accuracy *= 1.5
    @enemy_attack_type = "in the legs"
  end

  def count_hero_final_damage
    hero_before_hit_passive_slill_effects()
    hero_damage_reduced_by_enemy_block()
    hero_damage_reduced_by_enemy_armor()
  end
  def hero_before_hit_passive_slill_effects
    case @hero.passive_skill.name
    when "Berserk"
      @hero_damage *= @hero.passive_skill.damage_coef
    end
  end
  def hero_damage_reduced_by_enemy_block
    @hero_damage /= @enemy.block_power_coeff if @enemy_block_successful
  end
  def hero_damage_reduced_by_enemy_armor
    @hero_damage -= @enemy.armor
    @hero_damage = 0 if @hero_damage < 0
  end
  #
  def count_enemy_final_damage
    enemy_damage_reduced_by_hero_block()
    enemy_damage_reduced_by_hero_armor()
  end
  def enemy_damage_reduced_by_hero_block
    @enemy_damage /= @hero.block_power_coeff if @hero_block_successful
  end
  def enemy_damage_reduced_by_hero_armor
    @enemy_damage -= @hero.armor
    @enemy_damage = 0 if @enemy_damage < 0
  end

  def hero_attack_effects
    @hero_hit = @hero_accuracy >= rand(1..100)
    hero_hit_or_miss()
    hero_after_hit_passive_slill_effects()
    @messages.actions = ""
    MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ damaged: @enemy }]).display
  end
  def hero_hit_or_miss
    if @hero_hit
      block_message = @enemy_block_successful ? "#{@enemy.name} blocked #{@enemy.block_power_in_percents}% damage. " : ''
      @enemy.hp -= @hero_damage
      @messages.log << block_message + "You dealt #{@hero_damage.round} damage #{@hero_attack_type}"
    else
      @messages.log << "You missed #{@hero_attack_type}"
    end
  end
  def hero_after_hit_passive_slill_effects
    case @hero.passive_skill.name
    when "Concentration"
      damage_bonus = @hero.passive_skill.damage_bonus # чтобы далее был одинаковый
      if @hero_hit && damage_bonus > 0
        @enemy.hp -= damage_bonus
        @messages.log[-1] += ", additional damage from concentration #{damage_bonus.round(1)}"
      end
    when "Dazed"
      if @hero_hit && @hero_damage * @hero.passive_skill.accuracy_reduce_coef > (@enemy.hp + @hero_damage) / 2 # прибавляется дамаг который отнялся выше для подсчета эффекта ошеломления
        @enemy_accuracy *= 0.1 * rand(1..9)
        @messages.log[-1] += " and dazed the enemy, reducing his accuracy to #{(@enemy.accuracy * 0.1 * rand(1..9)).round}"
      end
    end
  end
  #
  def enemy_attack_effects
    sleep(1)
    @messages.main = "#{@enemy.name}'s move"
    @messages.actions = "#{@enemy.name} chooses the method of attack"
    MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ normal: @enemy }]).display
    enemy_hit_or_miss()
    sleep(1)
    @messages.main = "#{@enemy.name} attacks"
    @messages.actions = ""
    MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ attack: @enemy }]).display
  end
  def enemy_hit_or_miss
    enemy_hit = @enemy_accuracy >= rand(1..100)
    if enemy_hit
      block_message = @hero_block_successful ? "You have blocked #{@hero.block_power_in_percents}% damage. " : ''
      @hero.hp -= @enemy_damage
      @messages.log << block_message + "#{@enemy.name} dealt #{@enemy_damage.round} damage #{@enemy_attack_type}"
    else
      @messages.log << "#{@enemy.name} missed #{@enemy_attack_type}"
    end
  end

  def round_result
    if @hero.hp <= 0
      sleep(1)
      @messages.main = "You're dead!"
      @messages.actions = 'To continue press Enter'
      MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ game_over: :game_over }]).display
      gets
      MainRenderer.new(:run_end_screen, entity: @messages, arts: [{ end: :run_end_art }]).display
      gets
      DeleteHeroInRun.new(@hero).add_camp_loot_and_delete_hero_file
    elsif @enemy.hp <= 0
      sleep(1)
      @messages.main = "#{@enemy.name} dead, victory!"
      @messages.actions = 'To continue press Enter'
      MainRenderer.new(:battle_screen, @hero, @enemy, entity: @messages, arts: [{ dead: @enemy }]).display
      gets
    else
      sleep(1)
    end
  end

end
















#
