![PZDC_dungeon_2_title](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/title_2.png)

## What is it?

__PZDC dungeon 2__ is a terminal based roguelike game.

The combat system is turn-based, with alternating actions of the player and the enemy.

The main objective is to complete all 3 available dungeons, defeating the boss of each of them and then defeat the main boss of the game.

The player is not tied to one character, each new dungeon is an almost independent episode with a separate leveling of a separate character and regardless of victory or death halfway through, the next game will start anew, with a new character. But between the almost isolated passage of dungeons, there is a meta-leveling of the camp for points earned in dungeons, which strengthens each new character, acting as a continuous progression in the game. This approach allows for improved gameplay variety, allowing for different builds to be used throughout the game through a combination of backgrounds, skills, and equipment.

__The game currently has:__
* __3 dungeons__
* __4 buildings in the camp that perform meta-leveling__
* __9 types of starting characters__
* __11 skills__
* __10 types of random events/quests__
* __22 unique enemies__
* __40+ types of equipment with the ability to modify it__


## SCREENS (open to view)

<details>
  <summary>Bandits</summary>
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/rabid_dog.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/bandits_choose.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/poacher.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/poacher_damaged.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/poacher_attacks.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/bandit_leader.png" />
</details>
<details>
  <summary>Undeads</summary>
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/undead_choose_2.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/fat_gull.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/fat_gull_attacks.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/skeleton_attacks.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/skeleton_soldier.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/ghost.png" />
</details>
<details>
  <summary>Swamp</summary>
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/swamb_choose.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/snake_worm.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/ancient_snail.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/ancient_snail_attacks.png" />
</details>
<details>
  <summary>Ammunition</summary>
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/body_armor_choose_1.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/head_armor_choose_1.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/shield_choose_1.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/axe.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/weapon_choose_1.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/weapon_choose_2.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/living_whip.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/rusty_mail_gloves.png" />
</details>
<details>
  <summary>Events</summary>
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/events/event_choose_1.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/events/event_choose_4.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/events/altar_of_blood_2.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/events/field_loot.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/events/gambler.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/events/pig_with_saucepan.png" />
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/events/warriors_grave_2.png" />
</details>


## Gameplay demo on YouTube

<a href="https://www.youtube.com/watch?v=3x4cA5XCh9I" target="_blank">
  <img src="https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/gif/load_game_youtube.gif" alt="Demo" width="100%" border="10px">
</a>


## Requirements

The only requirement for _PZDC dungeon 2_ is `Ruby 3+`

Recommended terminal dimensions: width `120+`, height `36+`

## Run

```shell
ruby pzdc_dungeon_2.rb
```

## Options

In Options menu you can set up:

* Animation speed (screen change) during the battle
* Escape code with which the screen is changed: `\x1bc` - set by default, more convenient for the game; `\e[H\e[2J` - will be more convenient for contributors to be able to see previous screens


![snake_worm_attacks_min](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/snake_worm_attacks_min.png)


## How to play

Start new dungeon: `DUNGEON` -> `NEW DUNGEON`

Select a dungeon, create a new character, choose a class and skills, kill enemies, complete quests, level up - to pass the dungeon.

It's okay if the character dies, as there is meta-leveling in _PZDC dungeon 2_, in the `CAMP` menu you can distribute meta-leveling points so that the new character has more opportunities for a new attempt to complete the dungeon.

* Different dungeons vary in difficulty
* The battles are step-by-step, you can choose from several types of attacks
* Between battles, random events occur during which you can receive buffs or take quests
* When you get a new level, you can upgrade your characteristics and skills
* There is equipment that is knocked out of opponents
* The further you go into the dungeon, the greater the chance to meet stronger opponents

If you want an easy game, then create a character named `BAMBUGA`, then you will get a strong weapon for this torture, but you will not get meta points.


![rabid_dog_attacks_min](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/rabid_dog_attacks_min.png)


## Campfire menu

Campfire menu appears at the very beginning of a dungeon and between each fight or event. It contains all the options you can take before moving on to the next fight or event:

* __Show hero info__ - in this menu you can view information about the characteristics, skills and equipment of the character and some other data.
* __Spend stat points__ - in this menu you can distribute character attribute points, if there are any available, and also view information about the character.
* __Spend skill points__ - in this menu you can distribute skill points, if there are any available, and also view information about the character.
* __Use camp skill__ - in this menu you can use an active non-combat skill if you have one.
* __Enhance ammunition__ - in this menu you can improve your equipment using magic recipes purchased in the _Occult Library_ and body parts of defeated enemies.
* __Show event quests__ - contains information about active quests
* __Save & exit game__ - You can save game and exit from dungeon to continue it at another time. But there is only 1 save slot and if you start a new dungeon and save it, the data of the previous unfinished dungeon will be deleted.


![campfire_menu](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/campfire.png)


## CAMP and meta-leveling

In the camp menu, you can distribute meta-leveling points that you received for completing a dungeon or killing enemies:

* __PZDC Monolith__ - for monolith points you can permanently enhance the characteristics of all future characters. Monolith accumulates points for killing an enemy, the stronger the enemy, the greater the chance to get points. Monolith points are credited to your account in any case, even if the character dies.
* __Shop__ - here you can buy equipment for the next attempt to complete the dungeon for coins (you need to buy it separately for each attempt). Coins can be obtained for killing opponents or in random events, but they will be credited to your account only if the character has completed the dungeon or left the dungeon through a special exit. Also, if the character got out of the dungeon alive, then with some probability he can sell his things to the store, and you can buy them from the merchant for new heroes. By default, the store only has basic items.
* __Occult Library__ - sells magic recipes for coins that can be used to create living upgrades for weapons and armor from body parts of killed enemies in the campfire menu in the dungeon. It is recommended to buy recipes first, because unlike things from the store, they are bought once and for all.
* __Statistics__ - Here you can see how many enemies of each type you have killed in dungeons throughout the game, as well as how many enemies you still need to kill to get permanent bonuses for each of them.


![camp_menu](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/camp_menu.png)


## Characteristics and effects:

* __HP__ - your survivability, when it reaches 0 the hero will die
* __MP__ - your stamina reserve, which can be spent on active skills in combat or in the campfire menu
* __Damage__ - depends on the equipped weapon, and can also be upgraded additionally
* __Accuracy__ - chance to hit in %, some types of attacks are more accurate than others
* __Armor__ - simply subtracted from the damage inflicted
* __Armor penetration__ - shows how many units of armor your attacks ignore
* __Block chance__ - the probability in % to block some damage, the blocked damage depends on the current HP
* __Regeneration__ - restores HP or MP for each turn in battle
* __Recovery__ - restores HP or MP during rest between battles
* __Experience points__ - given for killing an enemy
* __Stat points__ and __skill points__ - given at the start and when leveling up


![hero_menu](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/hero_menu_3.png)


## Combat active skills:

Combat active skills can be used during battle, they consume some MP for each use.

* __Ascetic strike__ - significantly increases both damage and accuracy, costs a small amount of MP, but requires unspent attribute points in reserve and the more of them, the stronger the effect
* __Precise strike__ - greatly increases accuracy and a little damage
* __Strong strike__ - greatly increases damage
* __Traumatic strike__ - temporarily injures the enemy, causing them to deal reduced damage to you on their next attack


## Combat passive skills:

Combat passive skills are used permanently in combat and do not require MP expenditure.

* __Berserk__ - the less HP are left from the maximum, the more damage
* __Concentration__ - deals additional magic damage when attacking, which ignores armor and is not blocked. Damage depends on the maximum amount of MP, MP must be at least greater than 100.
* __Dazed__ - with a certain ratio of one-time damage inflicted to the enemy's remaining HP, you can reduce the accuracy of his next blow
* __Shield master__ - increases the chance block with a shield (but amount of damage blocked by the shield does not depend on the skill, but only on the character's current HP)


## Non-combat skills:

Non-combat skills are used in the campfire menu. They can be either active or passive.

* __Bloody ritual__ (_active_) - restores part of MP, restores more the greater the difference between the maximum MP and the remaining one. Spends some HP to activate. Additionally has a positive effect on random events related to sacrifices and black magic
* __First aid__ (_active_) - restores part of HP, the more the greater the difference between the maximum HP and the remaining. Spends MP to activate
* __Treasure hunter__ (_passive_) - positively affects many probabilities in the game, such as: chance to get loot, more options for choosing opponents and random events, more chance of positive outcomes in many random events, and so on.


![coins_add_min](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/coins_add_min.png)


## Planned to be added in future versions:

* More content: dungeons, buildings, characters, enemies, equipment, skills
* Additional status effects such as poison, bleeding, stun and others
* Skills for enemies
* In those places of the dungeon where your previous hero died, an enemy zombie hero with the same characteristics and weapons will appear
* If a large number of enemies of one type are killed, then it will be possible to play with this type of enemy as a new character class
* Translations
* Convenient functionality and documentation for contributors
