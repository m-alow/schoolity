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

  permissions :new? do
    it 'allows a access for a user' do
      expect(subject).to permit(user)
    end
    it 'allows access for an admin' do
      expect(subject).to permit(admin)
    end
    it 'allows access for a school owner' do
      expect(subject).to permit(school_owner)
    end
  end

  permissions :create? do
    let(:school) { build_stubbed(:school, owner: school_owner) }
    it 'allows a user to create a school' do
      expect(subject).to permit(user)
    end
    it 'allows an admin to create a school' do
      expect(subject).to permit(admin)
    end
    it 'allows a school owner to create another school' do
      expect(subject).to permit(school_owner)
    end
  end

  permissions :edit? do
    let(:school) { build_stubbed(:school, owner: school_owner) }

    it 'prevents other users from editing the school' do
      expect(subject).not_to permit(user, school)
    end
    it 'allows the school owner to edit her school' do
      expect(subject).to permit(school_owner, school)
    end
    it 'allows admins to edit the school!!!' do
      expect(subject).to permit(admin, school)
    end
  end

  permissions :update? do
    let(:school) { build_stubbed(:school, owner: school_owner) }

    it 'prevents other users from updating the school' do
      expect(subject).not_to permit(user, school)
    end
    it 'allows the school owner to update her school' do
      expect(subject).to permit(school_owner, school)
    end
    it 'allows amins to update the shcool!!!' do
      expect(subject).to permit(admin, school)
    end
  end

  permissions :destroy? do
    it 'prevents other users from deleting the school' do
      expect(subject).not_to permit(user, school)
    end
    it 'allows the school owner to delete his school!!!' do
      expect(subject).to permit(school_owner, school)
    end
    it 'allows admins to delete schools' do
      expect(subject).to permit(admin, school)
    end
  end

  permissions :activate? do
    it 'prevents users from activating schools' do
      expect(subject).not_to permit(user, school)
    end
    it 'prevents the school owner from activatin his school' do
      expect(subject).not_to permit(school_owner, school)
    end
    it 'allows admin to activate schools' do
      expect(subject).to permit(admin, school)
    end
  end
end
