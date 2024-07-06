class FieldLoot
  def initialize(hero)
    @hero = hero
    @field_loot = ['potion', 'rat', 'nothing']
  end

  def looting
    print 'Обыскиваем все вокруг... '
    send(@field_loot.sample)
    puts '---------------------------------------------------------------------'
  end

  private

  def nothing
    puts "Рядом нет ничего ценного"
  end

  def potion
    @hero.hp += [20, @hero.hp_max - @hero.hp].min
    puts "Нашел зелье восстанавливающее 20 жизней, теперь у тебя #{@hero.hp.round}/#{@hero.hp_max} жизней"
  end

  def rat
    @hero.hp -= 5
    puts "Пока ты шарил по углам, тебя укусила крыса(-5 жизней), теперь у тебя #{@hero.hp.round}/#{@hero.hp_max} жизней"
    if @hero.hp <= 0
      puts "Ты подох от укуса крысы. Жалкая смерть"
      Art.display_art(:game_over)
      exit
    end
  end
end












# 
