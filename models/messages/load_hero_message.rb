class LoadHeroMessage
  attr_accessor :main, :heroes

  def initialize
    @main = ''
    @heroes = []
  end

  def method_missing(method)
    type, param = method.to_s.split('_')
    @heroes[param.to_i]
  end
end
