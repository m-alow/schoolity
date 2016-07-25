module Pdf
  module FollowingCodeContent
    def content code
      @code = code
      font "Times-Roman"

      text "#{school.name} School", align: :center, size: 20

      move_down 20

      text "Following code for #{student.full_name}", align: :center
      text "Expires on #{code.expire_at.strftime('%d, %b %Y %I:%M:%p')}", align: :center

      move_down 20

      text 'Please visit following a new student page.', align: :center
      move_down 20

      text 'Enter this following code. Note that it is case sensitive:', align: :center
      text code.code, align: :center, size: 16
      move_down 20

      text 'Enter the student full name exactly like this:', align: :center
      text student.full_name, align: :center, size: 16
      move_down 20
      text "Enter your relationship to #{student.name}.", align: :center
      text 'Submit the form.', align: :center


      move_down 36
      text 'Thank you', align: :center

    end

    def student
      @student = @code.student
    end

    def school
      @school = student.school
    end
  end
end
