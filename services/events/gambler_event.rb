class GamblerEvent
  include DisplayScreenConcern

  PATH_ART = "events/_gambler"

  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @path_art = PATH_ART

    @name = 'Gambler'
    @description1 = 'Little man...'
    @description2 = '...he juggling dice...'
    @description3 = '...easy way to get rich'
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new
  end

  def start
    play = @hero.coins > 0 ? 'Play [Enter 1]' : 'You cant play without coins'
    @messages.main = "#{play}    Сatch and rob [Enter 2]    Leave [Enter 0]"
    @messages.log << "You see a little man juggling dice"
    display_message_screen()
    choose = gets.strip
    @messages.clear_log
    if choose == '1' && @hero.coins > 0
      play()
    elsif choose == '2'
      rob()
    end
  end

  private

  def rob
    random = rand(1..100)
    catch_chanse = random + @hero.accuracy
    @messages.log << "Accuracy check: Random #{random} + Accuracy #{@hero.accuracy} = #{catch_chanse}"
    if catch_chanse >= 140
      coins = rand(1..10)
      @hero.coins += coins
      @messages.log << "#{catch_chanse} >= 140. You caught the little one"
      @messages.log << "He had #{coins} coins in his pocket. What was yours became mine!!!"
    elsif catch_chanse < 100 && @hero.weapon.code != 'without'
      old_weapon_name = @hero.weapon.name
      @hero.weapon = Weapon.new('without')
      @messages.log << "#{catch_chanse} < 100. You didn't catch the little one"
      @messages.log << "The little guy not only ran away, but also stole #{old_weapon_name}"
      @messages.log << "What a disgrace and now there is nothing to kill myself with"
    elsif catch_chanse < 120 && @hero.coins > 0
      coins = rand(1..@hero.coins)
      @hero.coins -= coins
      @messages.log << "#{catch_chanse} < 120. You didn't catch the little one"
      @messages.log << "The little guy not only ran away, but also stole #{coins} coins"
    else
      @messages.log << "#{catch_chanse} < 140. You didn't catch the little one"
    end
    @messages.main = "Press Enter to leave"
    display_message_screen()
    gets
  end

  def play
    choose = nil
    art = nil
    @messages.clear_log
    until choose == '0'
      if @hero.coins == 0
        @messages.main = "Сatch and rob [Enter 2]       Leave [Enter 0]"
        @messages.log << "You have 0 coin, and cant play more"
      else
        @messages.main = "Your coins: #{@hero.coins}   Roll the dice [Enter 1]    Сatch and rob [Enter 2]    Leave [Enter 0]"
        @messages.log << "Lets play?!"
      end
      display_message_screen(art)
      @messages.clear_log
      choose = gets.strip
      if choose == '1' && @hero.coins > 0
        y1, y2 = rand(1..6), rand(1..6)
        e1, e2 = rand(1..6), rand(1..7)
        @messages.log << "Your result is #{y1} + #{y2} = #{y1+y2}, the little one's result is #{e1} + #{e2} = #{e1+e2}"
        if y1+y2 > e1+e2
          @hero.coins += 1
          art = :win
          @messages.log << "You won 1 coin"
        elsif y1+y2 < e1+e2
          @hero.coins -= 1
          @messages.log << "You lose 1 coin"
          art = :loose
        else
          @messages.log << "Draw"
          art = :draw
        end
        if e2 == 7
          @messages.log << "7 on the dice? The little bastard is cheating!!!"
        end
      elsif choose == '2'
        rob()
        choose = '0'
      end
    end
  end

end



















#
