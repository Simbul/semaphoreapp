module Semaphoreapp
  class BranchStatus < OpenStruct
    def initialize(hash)
      hash['commit'] = Commit.from_hash(hash['commit'])
      super(hash)
    end

    def self.all_from_hash(hash)
      hash.map{ |status| BranchStatus.new(status) }
    end
  end
end
