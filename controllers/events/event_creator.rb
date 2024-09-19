class EventCreator
  STANDART_EVENT_CONSTANS = [FieldLootEvent, SecretLootEvent, ExitRunEvent, BoatmanEugeneEvent]
  # STANDART_EVENT_CONSTANS = [BoatmanEugeneEvent]

  def initialize(leveling, dungeon_name)
    @dungeon_name = dungeon_name
    # event_data = YAML.safe_load_file("data/events/#{dungeon_name}.yml")
  end

  def create_new_event(n=1)
    specific_dungeon_event?() ? specific_dungeon_event_constant() : standart_event_constant(n)
  end

  private

  def specific_dungeon_event?
    false # потом создать логику для уникальных ивентов каждого подземелья
  end

  def specific_dungeon_event_constant
    # потом создать логику для уникальных ивентов каждого подземелья
  end

  def standart_event_constant(n)
    STANDART_EVENT_CONSTANS.sample(n)
  end

end














#
