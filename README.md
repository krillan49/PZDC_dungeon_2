# PZDC dungeon 2

![Example](assets/alfa_ss.png)

## What is it?

"PZDC dungeon 2" is a small terminal based roguelike game

[Based on](https://github.com/krillan49/rogulike_game_ruby)

## Installation

```shell
git clone https://github.com/krillan49/Pzdc_dungeon2.git
```

## Run

```shell
ruby Pzdc_dungeon2.rb
```

## TODO

* Add translations
* Main menu / area for distributing bonuses, viewing statistics, opening new characters, a store, etc. between battle runs
* Various locations for combat runs with enemies corresponding to their lore, for example, an undead crypt with dead people, a cave with greenskins, a bandit camp, etc.
* More content: characters, enemies, equipment, skills
* More complex combat system with a greater choice of actions and their combinations
* Add documentation
* Add tests

## How to play

For a better picture, make the terminal window to the outline of the game screen and one line below it for input

As the game progresses, there will be instructions on which keys to press before Enter to select an action.

At the moment, the main combat part of the game is ready. So we just create a character, fight and pump it up to fight further.

* The battles are step-by-step, you can choose from several types of attacks
* When you get a new level, you can upgrade your characteristics and skills
* There is equipment that is knocked out of opponents
* The further you go into the dungeon, the greater the chance to meet stronger opponents
* The game is endless for now, but you can count killing the boss "Zombie Knight" as a victory


Characteristics and effects:
-
* Damage - depends on the equipped weapon, and can also be upgraded additionally
* Accuracy - chance to hit in %, some types of attacks are more accurate than others
* Armor - simply subtracted from the damage inflicted
* Block chance - works only if a shield is equipped, depends on the shield and the "Shield Master" skill, blocked damage - depends on current health
* Regeneration - restores hit points for each turn in battle
* Recovery - restores hit points during rest between battles
* Experience points - given for killing an enemy
* Stat points and skill points - given at the start and when leveling up

Active skills (spend mp):
-
* "Precise Strike" - greatly increases accuracy and a little damage
* "Strong Strike" - greatly increases damage

Passive skills:
-
* "Concentration" - deals additional damage when attacking depending on the maximum mp
* "Shield Master" - increases the chance block with a shield (the amount of damage blocked by the shield does not depend on the skill, but only on the character's current health)
* "Dazed" - with a certain ratio of one-time damage inflicted to the enemy's remaining hit points, you can reduce the accuracy of his next blow

Non-combat skills (work between battles):
-
* "First Aid" (active) - at a halt between battles restores part of the health, the more the greater the difference between the maximum health and the remaining
* "Treasure Hunter" (passive) - increases the chance and value of loot dropped after the battle
