require 'rails_helper'

RSpec.describe Weapon, type: :model do
  context "Testing Weapon methods" do
    it 'test current_power' do
      weapon = build(:weapon)
      expect(weapon.current_power).to eq("#{weapon.power_base + (weapon.level - 1) * weapon.power_step}")
    end

    it 'test title return' do
      weapon = build(:weapon)
      expect(weapon.title).to eq("#{weapon.name} ##{weapon.level}")
    end
  end
end
