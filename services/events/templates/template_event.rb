# 1. Create file your_evetn_name_event.rb in the directory services/events/
# 2. Copy and modify this class to create your event

# The concept of this project does not involve the use of third-party gems, but it is possible to require built-in standard libraries

class YourEventNameEvent # change name to ...Event

  # include concerns you need from ../conserns/:
  include DisplayScreenConcern  # Will be needed in 95% of cases if you don't want to change renderer options manually
  # include AmmunitionConcern   # Uncomment if you want to use offer character new equipment
  # include BattleConcern       # Uncomment if you want the character to engage in battle with the enemy
  # include GameEndConcern      # Uncomment if the character dies or leaves the dungeon

  PATH_ART = "events/_your_event_name"  # change the path to the event images if there are any
  # this is a relative path, full path: '/views/arts/events/_your_event_name.yml' - Add your file there if you have ready-made text images, the default image directory inside the file must have the name 'normal'. The 'mini' image will be displayed on the event selection screen, so don't make it big. You can also add images with any names to display by specifying their name inside your code. Please look at other files in this directory to add images correctly.

  # mandatory attributes are used by other classes
  attr_reader :entity_type, :path_art
  attr_reader :name, :description1, :description2, :description3, :description4, :description5

  def initialize(hero)
    # 1. mandatory variables whose values ​​cannot be changed:

    @hero = hero              # current character object

    @entity_type = 'events'
    @path_art = PATH_ART

    # 2. mandatory variables whose values ​​can be changed:

    @name = 'Your event name'          # your event name will be inserted into views
    @description1 = 'some message'     # short description of your event, there is no auto-line wrapping functionality, so maximum string length is 29 characters, you can leave them blank
    @description2 = 'some message'
    @description3 = 'some message'
    @description4 = ''
    @description5 = ''

    @messages = MainMessage.new # object for standard messages, it is recommended to use it. Below will be described the methods for messages of this class.
    # You can also create your own message class, but then you will have to figure out how renderer classes and insertions into views work)


    # 3. your own variables without restrictions:

  end

  # required main method that other classes call to fire your event
  def start

    # Below is the code for the example, you can delete it:


    # 1. methods for messages object:
    # -------------------------------------
    @messages.main = 'String'  # main - method inserts string at the top of the screen. Maximum string length is 116 characters
    @messages.log << 'String'  # log  - method inserts strings with messages into the bottom of the screen, since this is an array you can apply the corresponding methods to it. Maximum length of each string is 116 characters
    @messages.clear_log        # clear_log - additional method to clear the message log-array


    # 2. methods from DisplayScreenConcern:
    # -------------------------------------
    display_message_screen(:art_name) # method displays the screen on which the view 'views/menues/messages_screen.yml' is rendered. Inserts messages that were created using the methods of the message object and the image. Split screens with 'gets' methods to provide choice or 'slip' if you want to do dynamic animations
    # :art_name - an optional parameter that specifies the name of the image that will be inserted into the view from the file at the path specified in the variable PATH_ART. if you do not pass the parameter, the 'normal' picture will be displayed

    # You can add your text images for your event to the directory views/arts/events/_your_event_name.yml. How the images are made, see the files in this directory

    # An example of using the method can be seen in any of the existing events.


    # 3. methods from AmmunitionConcern:
    # -------------------------------------
    # The method takes a piece of equipment, displays a screen asking the player to exchange their current equipment of that type for the offered one, and after choosing, either replaces the equipment or keeps the old one. Returns true if the player agreed otherwise false

    # a. Can accept the item type and code name of the item we want to offer to the player.
    # item types: 'weapon', 'body_armor', 'head_armor', 'arms_armor', 'shield'
    # You can see the code and characteristics of any item of ammunition in /data/ammunition/
    ammunition_loot(ammunition_type: 'weapon', ammunition_code: 'knife', message: 'some message')
    # message: 'some message' - This message parameter is optional as it has a default value for each element type.

    # b. Can accept an item object that you need to create first (This will be more convenient if, for example, you want to display some of its characteristics in a message by accessing the methods of the ammunition model.):
    sallet = AmmunitionCreator.create('head_armor', 'sallet') # We create an item of ammunition in the same way using item type and code name
    sallet = HeadArmor.new('sallet') # or we can create it using a separate class (model) of ammunition using only code name
    ammunition_loot(ammunition_obj: sallet, message: 'some message') # pass the object to the method

    # с. You can also not use this method if you do not want to give the player a choice and want to forcefully change the item of ammunition. In this case, simply assign the new item of ammunition via the character model method
    @hero.head_armor = AmmunitionCreator.create('head_armor', 'sallet')
    @hero.weapon = Weapon.new('knife')

    # You can see examples of the application of this method in the events: pig_with_saucepan_event, warriors_grave_event


    # 4. methods from BattleConcern:
    # -------------------------------------

    # battle - method that fully implements a fight with an opponent and its results, all that is needed additionally is a variable @enemy with an opponent object:
    @enemy = Enemy.new('black_mage', 'events') # here the 1st argument is the enemy's code name, and the second is always a string 'events'.
    # To create your new unique enemy you need to come up with and add its characteristics to the file /data/characters/enemyes/events.yml, similar to those already existing there. But then you will have to draw the images for it yourself.
    # You can also take ready-made opponents existing in the game from the files bandits.yml, swamp.yml, undeads.yml in the same directory /data/characters/enemyes/ add their data to events.yml, just change the first line of data to the code name line (for example you want to add "Rabid dog" enemy, then when copying - the 1st line 'e2:' in the bandit file for the event file will change to 'rabid_dog:'). You also need to completely copy the file with the images of this enemy from views/arts/enemyes/bandits/_rabid_dog.yml to views/arts/enemyes/events/_rabid_dog.yml. This way you can adjust the characteristics and images as you need to make the one you need based on this enemy.
    # Or you can just use pre-made enemies by adding their dungeon code and their codename as arguments, like Enemy.new('bandits', 'e2')
    battle('some message')

    # You can see example of the application of this method in the event: black_mage_event




    # your code here
  end

  # your methods here:

end
