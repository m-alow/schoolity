require 'rails_helper'

RSpec.describe CommentPolicy do
  let(:comment) { build(:comment) }

  let(:subject) { described_class }

  permissions :destroy?, :update? do
    it 'allows comment author' do
      expect(subject).to permit(comment.user, comment)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(create(:user), comment)
    end
  end
end
