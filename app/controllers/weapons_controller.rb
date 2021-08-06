class WeaponsController < ApplicationController
  before_action :set_weapon, only: %i[destroy show]

  def index
    @weapons = Weapon.all
  end

  def create
    @weapon = Weapon.create(weapon_params)
    redirect_to weapons_path
  end

  def destroy
    @weapon.destroy
    redirect_to weapons_url
  end

  def show
  end

  private

  def weapon_params
    params.require(:weapon).permit(:name, :description, :power_base, :level, :power_step)
  end

  def set_weapon
    @weapon = Weapon.find(params[:id])
  end
end
