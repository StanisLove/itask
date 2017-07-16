require 'rails_helper'

describe User do
  let(:email) { Faker::Internet.email }

  context 'associations' do
    specify { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  context 'validations' do
    let(:user) { build :user, email: email }

    it { expect(user).to be_valid }

    context 'with invalid email' do
      let(:email) { 'invalid@@email.com' }

      it { expect(user).to be_invalid }
    end

    context 'with not unique email' do
      before { create :user, email: email }

      it { expect(user).to be_invalid }
    end

    specify { is_expected.to validate_presence_of :email }
    specify { is_expected.to validate_presence_of :password }
    specify { is_expected.to validate_length_of(:password).is_at_least(6) }
    specify { is_expected.to validate_length_of(:name).is_at_most(60) }
    specify { is_expected.to validate_length_of(:last_name).is_at_most(60) }
    specify { is_expected.to validate_inclusion_of(:role).in_range(0..1) }
  end

  describe '#save' do
    let(:user) { build :user, email: email.upcase }

    it 'creates user with lowercased email' do
      expect { user.save }.to change(user, :email).from(email.upcase).to(email.downcase)
    end
  end
end
