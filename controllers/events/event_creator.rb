class EventCreator
  STANDART_EVENT_CONSTANS = [FieldLootEvent]

  def initialize(leveling, dungeon_name)
    @dungeon_name = dungeon_name
    # event_data = YAML.safe_load_file("data/events/#{dungeon_name}.yml")
  end

  def create_new_event
    specific_dungeon_event?() ? specific_dungeon_event_constant() : standart_event_constant()
  end

  private

  def specific_dungeon_event?
    false # потом создать логику для уникальных ивентов каждого подземелья
  end

  def specific_dungeon_event_constant
    # потом создать логику для уникальных ивентов каждого подземелья
  end

  def standart_event_constant
    STANDART_EVENT_CONSTANS.sample
  end

end














#
