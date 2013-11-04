require 'redis'
$redis = Redis.new
require 'active_support/concern'
module Bloccit
  module Cache
    extend ActiveSupport::Concern

    REDIS = Redis.new

    module ClassMethods

      def redis
        Bloccit::Cache::REDIS
      end

    end

    def redis
      self.class.redis
    end

  end

end