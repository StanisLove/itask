require 'rails_helper'

describe Task do
  context 'associations' do
    specify { is_expected.to belong_to :user }
  end

  context 'validations' do
    specify { is_expected.to validate_presence_of :name }
    specify { is_expected.to validate_inclusion_of(:state).in_range(0..2) }
    specify { is_expected.to validate_length_of(:name).is_at_most(60) }
  end
end
