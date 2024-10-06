class MainMessage
  attr_accessor :main, :additional_1, :additional_2, :additional_3, :log

  def initialize
    @main = ''
    @additional_1 = ''
    @additional_2 = ''
    @additional_3 = ''
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
