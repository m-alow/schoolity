require 'rails_helper'

RSpec.describe SchoolPolicy do
  subject { SchoolPolicy }

  let(:user) { build_stubbed(:user) }
  let(:admin) { build_stubbed(:admin) }
  let(:school_owner) { build_stubbed(:user) }
  let(:school) { build_stubbed(:school, owner: school_owner) }

  permissions :index? do
    it 'allows access for a user' do
      expect(subject).to permit(user)
    end
  end

  permissions :show? do
    context 'activated school' do
      let(:school) { build_stubbed(:school, active: true, owner: school_owner) }

      it 'allows access for a user' do
        expect(subject).to permit(user, school)
      end
      it 'allows access for an admin' do
        expect(subject).to permit(admin, school)
      end
      it 'allows access for the school owner' do
        expect(subject).to permit(school_owner, school)
      end
    end

    context 'non-activated school' do
      let(:school) { build_stubbed(:school, active: false, owner: school_owner) }

      it 'prevents users from seeing the school' do
        expect(subject).not_to permit(user, school)
      end
      it 'allows the school owner to see his school' do
        expect(subject).to permit(school_owner, school)
      end
      it 'allows an admin to see the school' do
        expect(subject).to permit(admin, school)
      end
    end
  end

  permissions :new?, :create?  do
    it 'allows a user' do
      expect(subject).to permit(user)
    end

    it 'allows an admin' do
      expect(subject).to permit(admin)
    end

    it 'allows a school owner' do
      expect(subject).to permit(school_owner)
    end
  end

  permissions :edit?, :update?, :destroy? do
    let(:school) { build(:school, owner: school_owner) }

    it 'prevents other users' do
      expect(subject).not_to permit(user, school)
    end

    it 'allows the school owner' do
      expect(subject).to permit(school_owner, school)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end
  end

  permissions :activate? do
    it 'prevents users' do
      expect(subject).not_to permit(user, school)
    end

    it 'prevents the school owner' do
      expect(subject).not_to permit(school_owner, school)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end
  end
end
