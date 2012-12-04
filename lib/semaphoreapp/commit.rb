module Semaphoreapp
  class Commit < OpenStruct

    def self.build(source)
      Semaphoreapp::Commit.new(source) if source.is_a?(Hash)
    end

  end
end
