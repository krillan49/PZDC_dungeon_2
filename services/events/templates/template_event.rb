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
    @messages.main = 'String'  # main - method inserts string at the top of the screen. Maximum string length is 116 characters
    @messages.log << 'String'  # log  - method inserts strings with messages into the bottom of the screen, since this is an array you can apply the corresponding methods to it. Maximum length of each string is 116 characters
    @messages.clear_log        # clear_log - additional method to clear the message log-array

    # 2. methods from DisplayScreenConcern:
    display_message_screen(:art_name) # method displays the screen on which the view 'views/menues/messages_screen.yml' is rendered. Inserts messages that were created using the methods of the message object and the image. Split screens with 'gets' methods to provide choice or 'slip' if you want to do dynamic animations
    # :art_name - an optional parameter that specifies the name of the image that will be inserted into the view from the file at the path specified in the variable PATH_ART. if you do not pass the parameter, the 'normal' picture will be displayed

    # 3. methods from AmmunitionConcern:
    # Each method takes a gear item that matches the name, displays a screen asking the player to change the current gear item of that type to a new one, and once selected, either changes the gear item for the current character or keeps the old one. Returns true if the player agreed otherwise false
    # First you need to create the corresponding equipment object:

    # weapon_obj = Weapon.new('rusty_sword')
    # body_armor_obj = BodyArmor.new()
    # head_armor_obj = HeadArmor.new()
    # arms_armor_obj = ArmsArmor.new()
    # shield_obj = Shield.new()
    # weapon_loot(weapon_obj, 'Change weapon?')
    # body_armor_loot(body_armor_obj, 'Change body armor?')
    # head_armor_loot(head_armor_obj, 'Change head armor?')
    # arms_armor_loot(arms_armor_obj, 'Change arms armor?')
    # shield_loot(shield_obj, 'Change shield?')
    
    #

    # your code here
  end

  # your methods here:

end
