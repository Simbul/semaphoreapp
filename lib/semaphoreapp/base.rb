module Semaphoreapp
  class Base < OpenStruct

    def self.build(source, *params)
      if source.is_a?(Hash)
        build_from_hash(source, *params)
      elsif source.is_a?(Array)
        build_from_array(source, *params)
      end
    end


    private

    def self.build_from_hash(source_hash, &block)
      self.new(
        source_hash.dup.tap do |hash|
          block.call(hash) unless block.nil?
        end
      )
    end

    def self.build_from_array(source_array, *params)
      source_array.map{ |source_item| self.build_from_hash(source_item, *params) }
    end

  end
end
