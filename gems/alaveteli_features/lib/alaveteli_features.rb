require "alaveteli_features/version"
require "alaveteli_features/helpers"
require "alaveteli_features/railtie" if defined?(Rails)
require "flipper"
require "flipper-active_record"

module AlaveteliFeatures
  def self.backend
    @backend ||= Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end

  # for overriding with memory adapter in tests
  def self.backend=(backend)
    @backend = backend
  end
end
