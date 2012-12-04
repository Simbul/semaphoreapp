module Semaphoreapp
  class Commit < OpenStruct

    def self.build(source)
      if source.is_a?(Hash)
        Semaphoreapp::Commit.new(source)
      end
    end

  end
end
