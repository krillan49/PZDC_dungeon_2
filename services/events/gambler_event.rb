class GamblerEvent
  PATH_ART = "events/_gambler"

  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    @hero = hero

    @entity_type = 'events'
    @path_art = PATH_ART

    @name = 'Gambler'
    @description1 = 'In this pile of scrub...'
    @description2 = '...you might find some'
    @description3 = ''
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new
  end
end
