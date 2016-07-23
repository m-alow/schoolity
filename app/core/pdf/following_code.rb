module Pdf
  class FollowingCode < Prawn::Document
    include FollowingCodeContent
    def initialize code
      super()
      content code
    end
  end
end
