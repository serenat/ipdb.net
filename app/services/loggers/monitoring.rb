require 'singleton'
class Loggers::Monitoring < Logger
  include Singleton

  def initialize
    super(Rails.root.join('log/monitoring_' + Rails.env + '.log'))
    self
  end

  class << self
    delegate :error, :debug, :fatal, :info, :warn, :add, :log, :to => :instance
  end
end
