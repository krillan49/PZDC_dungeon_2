class AttacksRoundMessage
  attr_accessor :main, :actions, :log

  def initialize
    @main = ''
    @actions = ''
    @log = []
  end

  def clear_log
    @log = []
  end

  def log_last4
    @log.last(4)[0]
  end

  def log_last3
    @log.last(4)[1]
  end

  def log_last2
    @log.last(4)[2]
  end

  def log_last1
    @log.last(4)[3]
  end
end
