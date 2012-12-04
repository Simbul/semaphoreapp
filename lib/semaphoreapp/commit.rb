module Semaphoreapp
  class Commit < OpenStruct
    def self.from_hash(hash)
      Commit.new(hash)
    end
  end
end
