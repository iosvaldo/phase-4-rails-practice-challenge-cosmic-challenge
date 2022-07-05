class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

  def index
    #to_json method overrides serializer methods
    scientists = Scientist.all
    render json: scientists
  end

  def show
    scientist = Scientist.find(params[:id])
    render json: scientist, serializer: ScientistPlanetSerializer
  end
# use bang operator/rescue when the created object has invalid values to display the error message
  def create
    scientist = Scientist.create!(name: params[:name], field_of_study: params[:field_of_study], avatar: params[:avatar])
    render json: scientist, status: :created
  end
  
  # accepted is 202
  #must include id in url when patching PATCH /scientists/:id
  #if scientist is not successfully returned, then add a bang (!)
  def update
    scientist = Scientist.find(params[:id])
    scientist.update!(name: params[:name], field_of_study: params[:field_of_study], avatar: params[:avatar])
    render json: scientist, status: :accepted
  end

# since missions didnt have GET request to request i checked the SQLITE Exploror to see the missions removed. 
  def destroy
    scientist = Scientist.find(params[:id])
    scientist.destroy
    head :no_content
  end

  private 
 #must GET with an id that doesnt exsist 
  def render_not_found
    render json: { error: "Scientist not found" }, status: :not_found
  end

  def render_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
