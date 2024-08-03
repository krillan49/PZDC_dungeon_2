class NewMain
  def initialize

  end

  def start_game
    loop do
      puts'Войти в подземелье(1)    Войти в хаб(2)'
      choose = gets.to_i
      if choose == 2
        puts 'Вы вошли в хаб, нажмите энтер чтобы продолжить'
        gets
      else
        Run.new.start_game
      end
    end
  end

  private

  def display_message_screen_with_confirm_and_change_screen
    @messages.main = 'Чтобы продолжить нажмите Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    @messages.clear_log
    confirm_and_change_screen()
  end

  def confirm_and_change_screen
    gets
    change_screen()
  end

  def change_screen
    puts "\e[H\e[2J"
  end
end

















#
