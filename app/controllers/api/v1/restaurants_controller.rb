class Api::V1::RestaurantsController < Api::V1::BaseController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  # GET /restaurants
  def index
    @restaurants = policy_scope(Restaurant).page(params[:page]).per(params[:per])

    render json: @restaurants
  end

  # GET /restaurants/1
  def show
    authorize @restaurant
    render json: @restaurant
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(permitted_attributes(Restaurant.new))
    authorize @restaurant #Authorizing

    if @restaurant.save
      render json: @restaurant, status: :created
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    authorize @restaurant
    if @restaurant.update(permitted_attributes(@restaurant))
      render json: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1
  def destroy
    authorize @restaurant
    @restaurant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
end
