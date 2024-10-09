require 'yaml'

# helpers -----------------------------
require_relative "helpers/ruby_version_fix_helper"

# engines -----------------------------
require_relative "engines/main"
require_relative "engines/camp_engine"
require_relative "engines/options_engine"
require_relative "engines/run"
require_relative "engines/attacks_round"
require_relative "engines/loot_round"
require_relative "engines/camp_fire_engine"

# renderers ---------------------------
require_relative "renderers/main_renderer"
require_relative "renderers/arts/arts"
require_relative "renderers/menues/menues"

# services ----------------------------
# saves
require_relative "services/saves/save_hero_in_run"
require_relative "services/saves/load_hero_in_run"
require_relative "services/saves/delete_hero_in_run"
# loot
require_relative "services/loot/pzdc_monolith_loot"
require_relative "services/loot/enemy_loot"
# actions
require_relative "services/actions/occult_library_enhance_service"
# events
require_relative "services/events/field_loot_event"
require_relative "services/events/secret_loot_event"
require_relative "services/events/exit_run_event"
require_relative "services/events/boatman_eugene_event"
require_relative "services/events/bridge_keeper_event"
require_relative "services/events/gambler_event"
require_relative "services/events/altar_of_blood_event"
require_relative "services/events/warriors_grave_event"

# controllers -------------------------
# ammunition
require_relative "controllers/ammunition/ammunition_creator"
require_relative "controllers/ammunition/ammunition_show"
# skills
require_relative "controllers/skills/skills_creator"
require_relative "controllers/skills/skills_show"
# characters
require_relative "controllers/characters/enemy_creator"
require_relative "controllers/characters/hero_creator"
require_relative "controllers/characters/hero_updator"
require_relative "controllers/characters/hero_actions"
require_relative "controllers/characters/enemy_actions"
require_relative "controllers/characters/hero_use_skill"
# events
require_relative "controllers/events/event_creator"
# actions
require_relative "controllers/actions/occult_library_enhance_controller"

# models ------------------------------
# options
require_relative "models/options/options"
# camp
require_relative "models/camp/warehouse"
require_relative "models/camp/pzdc_monolith"
require_relative "models/camp/shop"
require_relative "models/camp/occult_library"
require_relative "models/camp/occult_library_at_run"
require_relative "models/camp/occult_library_recipe"
require_relative "models/camp/statistics_total"
require_relative "models/camp/statistics_run"
# ammunition
require_relative "models/ammunition/arms_armor"
require_relative "models/ammunition/body_armor"
require_relative "models/ammunition/head_armor"
require_relative "models/ammunition/shield"
require_relative "models/ammunition/weapon"
# skills
require_relative "models/skills/ascetic_strike"
require_relative "models/skills/precise_strike"
require_relative "models/skills/strong_strike"
require_relative "models/skills/traumatic_strike"
require_relative "models/skills/berserk"
require_relative "models/skills/concentration"
require_relative "models/skills/dazed"
require_relative "models/skills/shield_master"
require_relative "models/skills/bloody_ritual"
require_relative "models/skills/first_aid"
require_relative "models/skills/treasure_hunter"
# characters
require_relative "models/characters/enemy"
require_relative "models/characters/hero"
# messages
require_relative "models/messages/attacks_round_message"
require_relative "models/messages/main_message"



Main.new.start_game












#
