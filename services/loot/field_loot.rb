class FieldLoot
  def initialize(hero, messages)
    @hero = hero
    @messages = messages

    @field_loot = ['potion', 'rat', 'nothing']
  end

  def looting
    @messages.log << 'Обыскиваем все вокруг... '
    send(@field_loot.sample)
  end

  private

  def nothing
    @messages.log << "Рядом нет ничего ценного"
  end

  def potion
    @hero.hp += [20, @hero.hp_max - @hero.hp].min
    @messages.log << "Нашел зелье восстанавливающее 20 жизней, теперь у тебя #{@hero.hp.round}/#{@hero.hp_max} жизней"
  end

  def rat
    @hero.hp -= 5
    @messages.log << "Пока ты шарил по углам, тебя укусила крыса(-5 жизней), теперь у тебя #{@hero.hp.round}/#{@hero.hp_max} жизней"
    if @hero.hp <= 0
      @messages.main = "Нажми Enter, чтобы закончть игру"
      @messages.log << "Ты подох от укуса крысы. Жалкая смерть"
      MainRenderer.new(:messages_screen, entity: @messages, arts: [{ game_over: :game_over }]).display
      gets
      exit
    end
  end
end












#
