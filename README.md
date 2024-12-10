![PZDC_dungeon_2_title](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/title_2.png)

## What is it?

"PZDC dungeon 2" is a terminal based roguelike game

## Requirements

The only requirement for "PZDC dungeon 2" is Ruby 3+

Recommended terminal dimensions: width - 120+, height - 36+

## Run

```shell
ruby pzdc_dungeon_2.rb
```

## Options

In Options menu you can set up:

* Animation speed (screen change) during the battle
* Escape code with which the screen is changed: x1bc - set by default, more convenient for the game; e[He[2J - will be more convenient for contributors to be able to see previous screens


![snake_worm_attacks_min](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/snake_worm_attacks_min.png)


## How to play

Start new dungeon: DUNGEON -> NEW DUNGEON

Select a dungeon, create a new character, choose a class and skills, kill enemies, complete quests, level up - to pass the dungeon.

It's okay if the character dies, as there is meta-leveling in "PZDC dungeon 2", in the CAMP menu you can distribute meta-leveling points so that the new character has more opportunities for a new attempt to complete the dungeon.

* Different dungeons vary in difficulty
* The battles are step-by-step, you can choose from several types of attacks
* Between battles, random events occur during which you can receive buffs or take quests
* When you get a new level, you can upgrade your characteristics and skills
* There is equipment that is knocked out of opponents
* The further you go into the dungeon, the greater the chance to meet stronger opponents

If you want an easy game, then create a character named "BAMBUGA", then you will get a strong weapon for this torture, but you will not get meta points.


![rabid_dog_attacks_min](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/rabid_dog_attacks_min.png)


## Campfire menu

Campfire menu appears at the very beginning of a dungeon and between each fight or event. It contains all the options you can take before moving on to the next fight or event:

* Show hero info - in this menu you can view information about the characteristics, skills and equipment of the character and some other data.
* Spend stat points - in this menu you can distribute character attribute points, if there are any available, and also view information about the character.
* Spend skill points - in this menu you can distribute skill points, if there are any available, and also view information about the character.
* Use camp skill - in this menu you can use an active non-combat skill if you have one.
* Enhance ammunition - in this menu you can improve your equipment using magic recipes purchased in the Occult Library and body parts of defeated enemies.
* Show event quests - contains information about active quests
* Save & exit game - You can save game and exit from dungeon to continue it at another time. But there is only 1 save slot and if you start a new dungeon and save it, the data of the previous unfinished dungeon will be deleted.


![campfire_menu](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/campfire.png)


## CAMP and meta-leveling

In the camp menu, you can distribute meta-leveling points that you received for completing a dungeon or killing enemies:

* PZDC Monolith - for monolith points you can permanently enhance the characteristics of all future characters. Monolith accumulates points for killing an enemy, the stronger the enemy, the greater the chance to get points. Monolith points are credited to your account in any case, even if the character dies.
* Shop - here you can buy equipment for the next attempt to complete the dungeon for coins (you need to buy it separately for each attempt). Coins can be obtained for killing opponents or in random events, but they will be credited to your account only if the character has completed the dungeon or left the dungeon through a special exit. Also, if the character got out of the dungeon alive, then with some probability he can sell his things to the store, and you can buy them from the merchant for new heroes. By default, the store only has basic items.
* Occult Library - sells magic recipes for coins that can be used to create living upgrades for weapons and armor from body parts of killed enemies in the campfire menu in the dungeon. It is recommended to buy recipes first, because unlike things from the store, they are bought once and for all.
* Statistics - Here you can see how many enemies of each type you have killed in dungeons throughout the game, as well as how many enemies you still need to kill to get permanent bonuses for each of them.


![camp_menu](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/camp_menu.png)


## Characteristics and effects:

* HP - your survivability, when it reaches 0 the hero will die
* MP - your stamina reserve, which can be spent on active skills in combat or in the campfire menu
* Damage - depends on the equipped weapon, and can also be upgraded additionally
* Accuracy - chance to hit in %, some types of attacks are more accurate than others
* Armor - simply subtracted from the damage inflicted
* Armor penetration - shows how many units of armor your attacks ignore
* Block Chance - the probability in % to block some damage, the blocked damage depends on the current HP
* Regeneration - restores HP or MP for each turn in battle
* Recovery - restores HP or MP during rest between battles
* Experience points - given for killing an enemy
* Stat points and skill points - given at the start and when leveling up


![hero_menu](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/hero_menu_3.png)


## Combat active skills:

Combat active skills can be used during battle, they consume some MP for each use.

* "Ascetic strike" - significantly increases both damage and accuracy, costs a small amount of MP, but requires unspent attribute points in reserve and the more of them, the stronger the effect
* "Precise Strike" - greatly increases accuracy and a little damage
* "Strong Strike" - greatly increases damage
* "Traumatic strike" - temporarily injures the enemy, causing them to deal reduced damage to you on their next attack


## Combat passive skills:

Combat passive skills are used permanently in combat and do not require MP expenditure.

* "Berserk" - the less HP are left from the maximum, the more damage
* "Concentration" - deals additional magic damage when attacking, which ignores armor and is not blocked. Damage depends on the maximum amount of MP, MP must be at least greater than 100.
* "Dazed" - with a certain ratio of one-time damage inflicted to the enemy's remaining HP, you can reduce the accuracy of his next blow
* "Shield Master" - increases the chance block with a shield (but amount of damage blocked by the shield does not depend on the skill, but only on the character's current HP)


## Non-combat skills:

Non-combat skills are used in the campfire menu. They can be either active or passive.

* "Bloody ritual" (active) - restores part of MP, restores more the greater the difference between the maximum MP and the remaining one. Spends some HP to activate. Additionally has a positive effect on random events related to sacrifices and black magic
* "First Aid" (active) - restores part of HP, the more the greater the difference between the maximum HP and the remaining. Spends MP to activate
* "Treasure Hunter" (passive) - positively affects many probabilities in the game, such as: chance to get loot, more options for choosing opponents and random events, more chance of positive outcomes in many random events, and so on.


![coins_add_min](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/main/coins_add_min.png)


## It may be added in new versions:

* More content: dungeons, buildings, characters, enemies, equipment, skills
* In those places of the dungeon where your previous hero died, an enemy zombie hero with the same characteristics and weapons will appear.
* If a large number of enemies of one type are killed, then it will be possible to play with this type of enemy as a new character class.
* Translations


## SCREENS

<details>
  <summary>Bandits</summary>
  ![rabid_dog](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/rabid_dog.png)
  ![poacher](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/poacher.png)
  ![poacher_damaged](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/poacher_damaged.png)
  ![poacher_attacks](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/poacher_attacks.png)
  ![bandit_leader](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/bandits/bandit_leader.png)
</details>
<details>
  <summary>Undeads</summary>
  ![undead_choose](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/undead_choose_2.png)
  ![fat_gull](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/fat_gull.png)
  ![fat_gull_attacks](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/fat_gull_attacks.png)
  ![skeleton_attacks](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/skeleton_attacks.png)
  ![skeleton_soldier](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/skeleton_soldier.png)
  ![ghost](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/undeads/ghost.png)
</details>
<details>
  <summary>Swamp</summary>
  ![swamp_choose](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/swamb_choose.png)
  ![snake_worm](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/snake_worm.png)
  ![ancient_snail](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/ancient_snail.png)
  ![ancient_snail_attacks](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/enemyes/swamp/ancient_snail_attacks.png)
</details>
<details>
  <summary>Ammunition</summary>
  ![body_armor_choose_1](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/body_armor_choose_1.png)
  ![head_armor_choose_1](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/head_armor_choose_1.png)
  ![shield_choose_1](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/shield_choose_1.png)
  ![axe](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/axe.png)
  ![weapon_choose_1](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/weapon_choose_1.png)
  ![weapon_choose_2](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/weapon_choose_2.png)
  ![living_whip](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/living_whip.png)
  ![rusty_mail_gloves](https://github.com/krillan49/PZDC_dungeon_2_arts/blob/main/ammunition/rusty_mail_gloves.png)
</details>
