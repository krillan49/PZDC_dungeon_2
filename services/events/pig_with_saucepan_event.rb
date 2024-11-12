class PigWithSaucepanEvent
  include DisplayScreenConcern
  include AmmunitionConcern

  attr_reader :entity_type, :code_name, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @code_name = 'pig_with_saucepan'
    @path_art = "events/_pig_with_saucepan"

    @name = 'Pig with saucepan'
    @description1 = 'Pigman is eating something...'
    @description2 = '...smelly in his saucepan...'
    @description3 = '...the saucepan looks like...'
    @description4 = '...on a shiny helmet'
    @description5 = ''

    @messages = MainMessage.new
    @sallet = HeadArmor.new('sallet')
  end

  def start
    @messages.main = "Offer the pigman an acorn for his helmet [Enter 1]    Rob a pigman [Enter 2]    Leave [Enter 0]"
    @messages.log << "Looking closely you noticed that it was a new and shiny Sallet helmet, it would be nice to get it"
    display_message_screen()
    choose = gets.strip
    @messages.clear_log
    if choose == '1'
      buy()
    elsif choose == '2'
      rob()
    end
  end

  private

  def buy
    @messages.log << "Acorn? Do you think pigmen are idiots? You can eat from this saucepan and then shit in it"
    price = 15
    if @hero.camp_skill.code == 'treasure_hunter'
      discount = @hero.camp_skill.coeff_lvl * 0.5
      price = (price * (100 - discount) * 0.01).round
      @messages.log << "Treasure Hunter skill check #{@hero.camp_skill.coeff_lvl} => you get a #{discount.round}% discount"
    end
    @messages.log << "it’s healthy. I know it costs #{price} coins, pay up or get lost"
    if @hero.coins < price
      @messages.main = "Your coins: #{@hero.coins}    Сatch and rob [Enter 1]       Leave [Enter 0]"
      @messages.log << "You have no #{price} coins, and cant buy Sallet"
      display_message_screen(:buy)
      choose = gets.strip
      rob() if choose == '1'
    else
      @messages.main = "Your coins: #{@hero.coins}   Buy for #{price} coins [Enter 1]   Сatch and rob [Enter 2]   Leave [Enter 0]"
      display_message_screen(:buy)
      choose = gets.strip
      if choose == '1'
        @hero.coins -= price
        take_sallet()
      elsif choose == '2'
        rob()
      end
    end
  end

  def rob
    random = rand(1..100)
    catch_chanse = random + @hero.accuracy
    @messages.clear_log
    @messages.log << "Accuracy check: Random #{random} + Accuracy #{@hero.accuracy} = #{catch_chanse}"
    if catch_chanse >= 170
      @messages.log << "#{catch_chanse} >= 170. You caught the pigman"
      @messages.log << "Now Sallet is yours, and the pigman can be used for meat"
      mes = 'view Sallet'
      art = :catch
    elsif catch_chanse < 130 && @hero.coins > 0
      coins = rand(1..@hero.coins)
      @hero.coins -= coins
      @messages.log << "#{catch_chanse} < 130. You didn't catch the pigman"
      @messages.log << "The pigman not only run away, but also stole #{coins} coins"
      mes = 'leave'
      art = :run
    else
      @messages.log << "#{catch_chanse} < 170. You didn't catch the pigman"
      mes = 'leave'
      art = :run
    end
    @messages.main = "Press Enter to #{mes}"
    display_message_screen(art)
    gets
    take_sallet() if mes == 'view Sallet'
  end

  def take_sallet
    ammunition_loot(ammunition_obj: @sallet, message: "Sallet is yours, you want to equip it?")
  end

end
