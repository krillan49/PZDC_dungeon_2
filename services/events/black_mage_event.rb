class BlackMageEvent
  include DisplayScreenConcern
  include BattleConcern

  attr_reader :entity_type, :code_name, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @code_name = 'black_mage'
    @path_art = "events/_black_mage"

    @name = 'Black mage'
    @description1 = 'Casts spells...'
    @description2 = '...for your coins'
    @description3 = ''
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new
    @enemy = Enemy.new('black_mage', 'events')

    @adept = hero.camp_skill.code == 'bloody_ritual'
    @price = @adept && @hero.camp_skill.lvl > 5 ? 0 : @adept ? 1 : 2
    @b, @bp = @adept ? [4, 3] : [5, 1]
  end

  def start
    @messages.main = "You have #{@hero.coins} coins.    Buy spell [Enter 1]    Attack mage [Enter 2]    Leave [Enter 0]"
    if @adept
      @messages.log << "Hello brother, I see you also hear our Bloody God"
      @messages.log << "I give my brothers a discount and reduce the risks of negative effects"
    end
    @messages.log << "Black mage offers to cast an experimental spell on you for #{@price} coins"
    display_message_screen()
    choose = gets.strip
    if choose == '1'
      @hero.coins >= @price ? buy_spell() : cant_buy_spell()
    elsif choose == '2'
      attack_mage()
    end
  end

  private

  def cant_buy_spell
    @messages.clear_log
    @messages.main = "You have #{@hero.coins} coins.      Attack mage [Enter 1]      Leave [Enter 0]"
    @messages.log << "Not enough coins to buy a spell for #{@price}"
    display_message_screen()
    choose = gets.strip
    if choose == '1'
      attack_mage()
    end
  end

  def buy_spell
    @messages.clear_log
    @hero.coins -= @price
    @messages.main = "You have #{@hero.coins} coins.      Attack mage [Enter 1]      Leave [Enter 0]"
    @messages.log << "Black magician pronounces the magic words: 'Klaatu Verata Nikto'"
    bonus_give, bonus_take, bonus_give_power, bonus_take_power = rand(1..@b), rand(1..@b), rand(@bp..5), rand(1..5)
    bonus_take = rand(1..@b) while bonus_give + 1 == bonus_take
    if @adept && bonus_give_power < bonus_take_power
      bonus_give_power = bonus_take_power
    end
    if bonus_give == 1
      @hero.hp_max += bonus_give_power
      @hero.hp += bonus_give_power
      @messages.log << "You got #{bonus_give_power} Max HP, now you have #{@hero.hp.round}/#{@hero.hp_max} HP"
    elsif bonus_give == 2
      @hero.mp_max += bonus_give_power
      @hero.mp += bonus_give_power
      @messages.log << "You got #{bonus_give_power} Max MP, now you have #{@hero.mp.round}/#{@hero.mp_max} MP"
    elsif bonus_give == 3
      @hero.accuracy_base += 1
      @messages.log << "You got 1 accuracy, now you have #{@hero.accuracy} accuracy"
    elsif bonus_give == 4
      @hero.add_dmg_base
      @messages.log << "You got 1 damage, now you have #{@hero.min_dmg}-#{@hero.max_dmg} damage"
    else
      @messages.log << "You got nothing"
    end
    if bonus_take == 1
      @messages.log << "...and you lose nothing"
    elsif bonus_take == 2
      @hero.hp_max -= bonus_take_power
      @hero.hp = @hero.hp_max if @hero.hp > @hero.hp_max
      @messages.log << "...but you lose #{bonus_take_power} Max HP, now you have #{@hero.hp.round}/#{@hero.hp_max} HP"
    elsif bonus_take == 3
      @hero.mp_max -= bonus_take_power
      @hero.mp = @hero.mp_max if @hero.mp > @hero.mp_max
      @messages.log << "...but you lose #{bonus_take_power} Max MP, now you have #{@hero.mp.round}/#{@hero.mp_max} MP"
    elsif bonus_take == 4
      @hero.accuracy_base -= 1
      @messages.log << "...but you lose 1 accuracy, now you have #{@hero.accuracy} accuracy"
    else
      @hero.reduce_dmg_base
      @messages.log << "...but you lose 1 damage, now you have #{@hero.min_dmg}-#{@hero.max_dmg} damage"
    end
    display_message_screen(:action)
    choose = gets.strip
    if choose == '1'
      attack_mage()
    end
  end

  def attack_mage
    battle("Attack mage")
  end

end
