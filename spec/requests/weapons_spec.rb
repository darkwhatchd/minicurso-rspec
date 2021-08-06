require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /index" do
    it "weapon name is present" do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.name)
      end
    end

    it "weapon current_power is present" do
      weapon = create(:weapon)
      get weapons_path
      expect(response.body).to include(weapon.current_power)
    end

    it "weapon title is present" do
      weapon = create(:weapon)
      get weapons_path
      expect(response.body).to include(weapon.title)
    end

    it "return http success" do
      get weapons_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "when it has valid parameters" do
      it "creates the weapon with correct attributes" do
        weapon_attributes = FactoryBot.attributes_for(:weapon)
        post weapons_path, params: { weapon: weapon_attributes }
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end
    end

    context "when it has invalid parameters" do
      it "does not create weapon" do
        expect{
          post weapons_path, params: { weapon: { name: '', level: '', power_base: '', power_step: '', description: '' } }
        }.to_not change(Weapon, :count)
      end
    end
  end

  describe "DELETE /delete" do
    it "weapon is deleted" do
      weapon = create(:weapon)
      expect{
        delete "/weapons/#{weapon.id}"
      }.to change(Weapon, :count)
    end
  end

  describe "GET /show" do
    it "all stats is present" do
      weapon = create(:weapon)
      get "/weapons/#{weapon.id}"
      expect(response.body).to include(weapon.name)
      expect(response.body).to include(weapon.level.to_s)
      expect(response.body).to include(weapon.description)
      expect(response.body).to include(weapon.power_base.to_s)
      expect(response.body).to include(weapon.power_step.to_s)
      expect(response.body).to include(weapon.current_power.to_s)
      expect(response.body).to include(weapon.title)
    end
  end
end
