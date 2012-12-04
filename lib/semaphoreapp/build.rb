module Semaphoreapp
  class Build < Base

    private

    def self.build_from_hash(build)
      super do |hash|
        hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
      end
    end

  end
end
