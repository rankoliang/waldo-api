require 'rails_helper'

RSpec.describe Level, type: :model do
  it { is_expected.to have_many :characters }
end
