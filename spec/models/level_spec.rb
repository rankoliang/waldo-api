require 'rails_helper'

RSpec.describe Level, type: :model do
  it { is_expected.to have_many :characters }
  it { is_expected.to have_many :scores }
  it { is_expected.to have_one_attached :image }
end
