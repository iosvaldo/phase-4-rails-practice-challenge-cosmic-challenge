class MissionsController < ApplicationController

rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
# .planet is the json that i want to render as a response, when i want to show when i invoke this method using GET request

# def index
#   missions = Mission.all
#   render json: missions
# end

# def create
#   mission = Mission.create!(name: params[:name],scientist_id: params[:scientist_id], planet_id: params[:planet_id])
#   render json: mission.planets, status: :created
# end

def create
    mission = Mission.create!(mission_params)
    render json: mission.planet, status: :created
end

private

def render_invalid(invalid)
  render json: { errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
end

def mission_params
 params.permit(:name,:scientist_id, :planet_id)
 
end

end
