class MainMessage
  attr_accessor :log

  def initialize
    @log = []
  end

  def method_missing(method)
    type, param = method.to_s.split('_')
    if type == 'log'
      @log.last(7)[param.to_i]
    end
  end
end
