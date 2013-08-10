module Semaphoreapp
  class DeployLog < Base

    private

    def self.build_from_hash(threads)
      super do |hash|
        hash['threads'] = Semaphoreapp::Thread.build(hash['threads'])
      end
    end

  end
end
