require 'yaml'

# helpers -----------------------------
require_relative "helpers/ruby_version_fix_helper"

# engines -----------------------------
require_relative "engines/main"
require_relative "engines/camp_engine"
require_relative "engines/run"
require_relative "engines/attacks_round"
require_relative "engines/loot_round"

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
require_relative "services/loot/field_loot"
require_relative "services/loot/secret_loot"

# controllers -------------------------
# ammunition
require_relative "controllers/ammunition/ammunition_creator"
# skills
require_relative "controllers/skills/skills_creator"
# characters
require_relative "controllers/characters/enemy_creator"
require_relative "controllers/characters/hero_creator"
require_relative "controllers/characters/hero_updator"
require_relative "controllers/characters/hero_actions"
require_relative "controllers/characters/enemy_actions"
require_relative "controllers/characters/hero_use_skill"

# models ------------------------------
# camp
require_relative "models/camp/pzdc_monolith"
# ammunition
require_relative "models/ammunition/arms_armor"
require_relative "models/ammunition/body_armor"
require_relative "models/ammunition/head_armor"
require_relative "models/ammunition/shield"
require_relative "models/ammunition/weapon"
# skills
require_relative "models/skills/concentration"
require_relative "models/skills/dazed"
require_relative "models/skills/first_aid"
require_relative "models/skills/precise_strike"
require_relative "models/skills/shield_master"
require_relative "models/skills/strong_strike"
require_relative "models/skills/treasure_hunter"
# characters
require_relative "models/characters/enemy"
require_relative "models/characters/hero"
# messages
require_relative "models/messages/attacks_round_message"
require_relative "models/messages/main_message"
require_relative "models/messages/load_hero_message"



Main.new.start_game


# TODO:
# Ошибки
# При создании нового перса(?когда нет фаила?) левелинг сразу 2
# ??При создании нового перса(или нет??) до сохранения берется левелинг старого сохраненного перса??
# Случайные события
# Герой прошел данжен(или часть данжена, если в случайных событиях попадется зона выхода), отдает половину собранного золота лагерю
# Торговец в лагере, у него появляются случайные вещи из тех, что принесли на себе предыдущие герои и продает их за золото.
# (АРТЫ и переделка вьюх):
# Лагерь, пока нет параметров. engines/new_main -> :camp_screen
# Картинка Экран выбора имени персонажа - controllers/hero_creator -> :messages_screen
# Выбор скилов - другой экран со всеми строками текста
# Картинка персонажа для :hero_update_screen. load_hero_run, engines/run
# Картинка обычного и секретного случайного лута. field_loot -> :messages_screen [y = 17, x <= 110]
# Картинка получения опыта. run -> after_battle -> :messages_screen [y = 17, x <= 110]
# Картинки для лута оружия, заменить видимо весь экран тк :messages_screen не подходит. enemy_loot












#
