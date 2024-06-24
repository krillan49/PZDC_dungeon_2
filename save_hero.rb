class SaveHero
  def initialize(hero)
    @hero = hero
    @n = 0
    @name = "save/#{@n}. #{hero.name} #{hero.lvl}.txt"
    @text = ''
  end

  def save
    File.write(@name, @text, mode: 'w')
  end
end

require_relative 'hero'
require_relative "skills"
hero = Hero.new('Vasya','watchman')
SaveHero.new(hero)
