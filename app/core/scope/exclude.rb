module Scope
  class Exclude
    attr_reader :scope, :excluded

    def initialize scope, excluded
      @scope = scope
      @excluded = [excluded].flatten
    end

    def call
      scope.call - excluded
    end

    def role
      scope.role
    end
  end
end
