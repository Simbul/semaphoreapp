module Semaphoreapp
  class BuildInformation < Base


    private

    def self.build_from_hash(build_information)
      super do |hash|
        hash['commits'] = Semaphoreapp::Commit.build(hash['commits'])
      end
    end

  end
end
