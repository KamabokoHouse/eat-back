require "./app/domain/restaurant/service"
require "./app/controllers/application_controller"

class RestaurantsController < ApplicationController
    def show
        restaurant = RestaurantService.new(latitude: params[:latitude], longitude: params[:latitude])
        render :json => restaurant.getLanchPlaceAll()
    end
end
