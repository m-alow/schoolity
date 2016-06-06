require 'rails_helper'

RSpec.describe SchoolClassPolicy do

  let(:user) { build(:user) }
  let(:admin) { build(:admin) }
  let(:owner) { build(:user) }
  let(:school_admin) { build(:user) }
  let(:school) { build(:school, owner: owner, active: true) }
  let(:other_school) { build(:school, active: true) }
  let(:school_class) { build(:school_class, school: school) }
  let(:other_school_class) { build(:school_class, school: other_school) }
  let(:school_administration) { build(:school_administration, user: school_admin, school: school) }

  before(:each) do
    school.administrators << school_admin
    school.school_classes << school_class
    other_school.school_classes << other_school_class
  end

  subject { described_class }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end

    it 'allows the school owner' do
      expect(subject).to permit(owner, school)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, other_school)
    end

    it 'allows the school administrator' do
      expect(subject).to permit(school_admin, school)
    end

    it 'prevents school administrator from accessing other schools' do
      expect(subject).not_to permit(school_admin, other_school)
    end

    it 'pervents other users' do
      expect(subject).not_to permit(user, school)
    end
  end

  permissions :show? do
    it 'allows admin' do
      expect(subject).to permit(admin, school_class)
    end

    it 'allows the school owner to access classes in his school' do
      expect(subject).to permit(owner, school_class)
    end

    it 'prevents the school owner to access classes not in his school' do
      expect(subject).not_to permit(owner, other_school_class)
    end

    it 'allows the school administrator to access classes in his school' do
      expect(subject).to permit(school_admin, school_class)
    end

    it 'prevents the school administrator to access classes not in his school' do
      expect(subject).not_to permit(school_admin, other_school_class)
    end

    it 'pervents other users from accessing it' do
      expect(subject).not_to permit(user, school_class)
    end
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    context 'activated school' do
      it 'allows admin' do
        expect(subject).to permit(admin, school_class)
      end

      it 'allows the school owner' do
        expect(subject).to permit(owner, school_class)
      end

      it 'prevents the school owner from accessing school class not in his school' do
        expect(subject).not_to permit(owner, other_school_class)
      end

      it 'allows the school administrator' do
        expect(subject).to permit(school_admin, school_class)
      end

      it 'prevents the school administrator from accessing school class not in his school' do
        expect(subject).not_to permit(school_admin, other_school_class)
      end

      it 'prevents other users' do
        expect(subject).not_to permit(user, school_class)
      end
    end

    context 'non-activated school' do
      let(:school) { build(:school, owner: owner, active: false) }

      it 'pervents admin' do
        expect(subject).not_to permit(admin, school_class)
      end

      it 'prevents the school owner' do
        expect(subject).not_to permit(owner, school_class)
      end

      it 'prevents the school administrator' do
        expect(subject).not_to permit(school_admin, school_class)
      end

      it 'prevents other users' do
        expect(subject).not_to permit(user, school_class)
      end
    end
  end
end
