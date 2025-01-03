class EventCreator
  STANDART_EVENT_CONSTANS = [
    FieldLootEvent, SecretLootEvent, ExitRunEvent, GamblerEvent, AltarOfBloodEvent, WarriorsGraveEvent,
    BlackMageEvent
  ]
  UNUSUAL_EVENT_CONSTANS = [BoatmanEugeneEvent, PigWithSaucepanEvent]
  RARE_EVENT_CONSTANS = [BridgeKeeperEvent]

  # STANDART_EVENT_CONSTANS = [WarriorsGraveEvent]*3

  def initialize(leveling, dungeon_name)
    @dungeon_name = dungeon_name
    # event_data = YAML.safe_load_file("data/events/#{dungeon_name}.yml")
  end

  def create_new_event(n=1)
    choose_event_constants().sample(n)
  end

  private

  def choose_event_constants
    events_constants = STANDART_EVENT_CONSTANS
    events_constants += UNUSUAL_EVENT_CONSTANS.sample(1) if rand(5) == 0
    events_constants += RARE_EVENT_CONSTANS.sample(1) if rand(30) == 0
    events_constants
  end

end














#
