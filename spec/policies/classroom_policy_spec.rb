require 'rails_helper'

RSpec.describe ClassroomPolicy do
  subject { described_class }

  let(:school) { build(:active_school, owner: school_owner) }
  let(:other_school) { build(:active_school) }
  let(:school_owner) { build(:user) }
  let(:admin) { build(:admin) }
  let(:user) { build(:user) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:classroom) { build(:classroom, school_class: build(:school_class, school: school)) }
  let(:other_classroom) { build(:classroom) }
  let(:teacher) { create(:teaching, classroom: classroom).teacher }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end

    it 'allows school owner' do
      expect(subject).to permit(school_owner, school)
    end

    it 'prevents school owner from accessing classroom in other schools' do
      expect(subject).not_to permit(school_owner, other_school)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, school)
    end

    it 'prevents school admin from accessing classroom in other schools' do
      expect(subject).not_to permit(school_admin, other_school)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, school)
    end

    it 'prevents teacher from accessing classrooms in other schools' do
      expect(subject).not_to permit(teacher, other_school)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school)
    end
  end

  shared_examples_for 'common access' do
    it 'allows admin' do
      expect(subject).to permit(admin, classroom)
    end

    it 'allows school owner' do
      expect(subject).to permit(school_owner, classroom)
    end

    it 'prevents school owner from accessing classroom in other schools' do
      expect(subject).not_to permit(school_owner, other_classroom)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, classroom)
    end

    it 'prevents school admin from accessing classroom in other schools' do
      expect(subject).not_to permit(school_admin, other_classroom)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, classroom)
    end
  end

  permissions :show? do
    it_behaves_like 'common access'

    it 'allows teacher' do
      expect(subject).to permit(teacher, classroom)
    end

    it 'prevents teacher from accessing classrooms he is not teaching' do
      expect(subject).not_to permit(teacher, other_classroom)
    end
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it_behaves_like 'common access'

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, classroom)
    end
  end
end
