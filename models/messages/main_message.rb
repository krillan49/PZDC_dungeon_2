class MainMessage
  attr_accessor :main, :log

  def initialize
    @main = ''
    @log = []
  end

  def method_missing(method)
    type, param = method.to_s.split('_')
    if type == 'log'
      @log[param.to_i] || ''
    end
  end

  def clear_log
    @log = []
  end
end
