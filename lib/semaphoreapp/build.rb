module Semaphoreapp
  class Build < OpenStruct
    def initialize(hash)
      hash['commit'] = Semaphoreapp::Commit.from_hash(hash['commit'])
      super(hash)
    end

    def self.all_from_hash(hash)
      hash.map{ |build| Semaphoreapp::Build.new(build) }
    end
  end
end
