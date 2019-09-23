require "./app/domain/restaurant/service"
require "./app/controllers/application_controller"

class RestaurantsController < ApplicationController
    def show
        restaurant = RestaurantService.new(latitude: params[:latitude], longitude: params[:longitude])
        render :json => restaurant.getLanchPlaceAll()
    end
end
