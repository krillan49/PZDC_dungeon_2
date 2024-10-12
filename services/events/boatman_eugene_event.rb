class BoatmanEugeneEvent
  PATH_ART = "events/_boatman_eugene"

  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @path_art = PATH_ART

    @name = 'Who are you and who am i...'
    @description1 = 'Boatman will take you...'
    @description2 = '...will ask for something...'
    @description3 = '...path will be shorter?'
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new

    @random_chanse = rand(1..150)
    @success = @random_chanse < @hero.accuracy
  end

  def start
    @messages.main = 'Agree to teach Eugene [Enter 1]            Go away [Enter 0]'
    @messages.log << "You are greeted by the boatman Evgeny. \"I'll take you the short way\" - he offers"
    @messages.log << "\"You are such a skilled and strong warrior, help me become like that too\" - Evgeniy asks you"
    display_message_screen()
    choose = gets.strip
    if choose == '1'
      teach()
    end
  end

  def teach
    @messages.clear_log
    @messages.main = 'To continue press Enter'
    @messages.log << "You offer to teach Evgeniy the art of war while you are sailing"
    @messages.log << "But Eugene doesn't even try to learn, he just counts cockroaches"
    @messages.log << "Test for attentiveness, random #{@random_chanse} #{@success ? '<' : '>='} your accuracy #{@hero.accuracy}"
    if @success
      @hero.mp -= [20, @hero.mp].min
      @hero.accuracy_base += 1
      @messages.log << "You quickly noticed this and stopped wasting time. You lost 20 MP, but gained 1 accuracy"
    else
      @hero.mp -= [40, @hero.mp].min
      @messages.log << "But you didn't notice it right away and kept trying to teach him. You lost 40 MP"
    end
    @messages.log << "You sailed to the same place. \"What's wrong with you?\" - you asked. \"Who are you and who am I\" - Evgeniy answered"
    display_message_screen()
    gets
  end

  private

  def display_message_screen
    MainRenderer.new(:messages_screen, entity: @messages).display
  end

end















#
