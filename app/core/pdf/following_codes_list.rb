module Pdf
  class FollowingCodesList < Prawn::Document
    include FollowingCodeContent

    attr_reader :codes_list
    def initialize codes
      super()
      @codes_list = codes

      list_content
    end

    def list_content
      codes_list.each do |code|
        content code
        start_new_page
      end
    end
  end
end
