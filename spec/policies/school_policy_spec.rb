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

  describe 'scope' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:admin) { create(:admin) }
    let(:owner) { create(:user) }

    let(:owned_active_schools) { @owned_active_schools }
    let(:owned_non_active_schools) { @owned_non_active_schools }
    let(:other_active_schools) { @other_active_schools }
    let(:other_non_active_schools) { @other_non_active_schools }
    let(:active_schools) { owned_active_schools + other_active_schools }
    let(:non_active_schools) { owned_non_active_schools + other_non_active_schools }
    let(:all_schools) { active_schools + non_active_schools }
    let(:owned_schools) { owned_active_schools + owned_non_active_schools }
    before do
      @owned_active_schools = [ create(:active_school, owner: owner), create(:active_school, owner: owner) ]
      @owned_non_active_schools = [ create(:non_active_school, owner: owner), create(:non_active_school, owner: owner) ]
      @other_active_schools = [ create(:active_school, owner: create(:user)), create(:active_school, owner: create(:user)) ]
      @other_non_active_schools = [ create(:non_active_school, owner: create(:user)), create(:non_active_school, owner: create(:user)) ]
    end

    context 'admin' do
      subject { Pundit::policy_scope(admin, School) }

      it 'sees all schools' do
        expect(subject).to match_array all_schools
      end
    end

    context 'school owner' do
      subject { Pundit::policy_scope(owner, School) }

      it 'sees owned schools' do
        expect(subject).to include(*owned_schools)
      end

      it 'sees all active schools' do
        expect(subject).to include(*active_schools)
      end

      it 'does not see non active non owned schools' do
        expect(subject).not_to include(*other_non_active_schools)
      end
    end

    context 'user' do
      subject { Pundit::policy_scope(user, School) }

      it 'sees all active schools' do
        expect(subject).to include(*active_schools)
      end

      it 'does not see non active schools' do
        expect(subject).not_to include(*non_active_schools)
      end
    end
  end
end
