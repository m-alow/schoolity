module Pdf
  class FollowingCode < Prawn::Document
    attr_reader :code
    def initialize code
      super()
      @code = code

      content
    end

    def content
      font "Times-Roman"

      text "#{school.name} School", align: :center, size: 20

      move_down 20

      text "Following code for #{student.full_name}", align: :center
      text "Expires on #{code.expire_at.strftime('%d, %b %Y %I:%M:%p')}", align: :center

      move_down 20
      text 'Please enter the following code:', align: :center

      move_down 20
      text code.code, align: :center, size: 16
    end

    def student
      @student ||= code.student
    end

    def school
      @school ||= student.school
    end
  end
end
