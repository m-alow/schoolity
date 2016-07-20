module Api
  module V1
    module Parent
      module Absences

        class CommentsController < ApiController
          def index
            absence = Absence.find params[:absence_id]

            respond_to do |format|
              format.json { render json: absence.comments, status: :ok, current_user: current_user.id  }
            end
          end

          def create
            absence = Absence.find params[:absence_id]
            respond_to do |format|
              Commenting::CommentOnAbsence.call(absence, current_user, params[:comment][:body]) do
                on(:success) do |comment|
                  format.json { render json: comment, status: :ok, current_user: current_user.id  }
                end
                on(:invalid) do
                  format.json { render json: { errors: ['Comment cannot be blank.'] }, status: :unprocessable_entity }
                end
              end
            end
          end
        end

      end
    end
  end
end
