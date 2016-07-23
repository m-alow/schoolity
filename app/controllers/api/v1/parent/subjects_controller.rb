module Api
  module V1
    module Parent
      class SubjectsController < ApiController
        def index
          @following = Following.find params[:following_id]
          authorize @following, :show?

          classroom = @following.student.classroom
          subjects = classroom.present? ? classroom.school_class.subjects : []
          respond_to do |format|
            format.json { render json: subjects, status: :ok }
          end
        end

        def show
          subject = Subject.find params[:id]
          authorize subject
          respond_to do |format|
            format.json { render json: subject, status: :ok }
          end
        end
      end
    end
  end
end
