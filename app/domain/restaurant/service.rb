require "./app/infrastructure/google/api/places"
require "./app/infrastructure/error/errors"
include Places

class RestaurantService
    def initialize(latitude:, longitude:)
        validateParam(param: latitude)
        validateParam(param: longitude)

        @latitude = latitude
        @longitude = longitude
    end

    def getLanchPlaceAll()
        places_data = getPlacesByWalkingDistance()
        @lanch_places = places_data["results"]
        existNextPlaces(places_data: places_data)
 
        if @lanch_places == nil then
            return {}
        end

        return @lanch_places
    end

    private
    def getPlacesByWalkingDistance()
        return Places.getAll({
            "key" => ENV["GOOGLE_API_PLACES_KEY"],
            "location" => "#{@latitude}, #{@longitude}",
            "radius" => 800,
            "language" => "ja",
            "opennow" => true,
            "type" => "restaurant"
        })
    end

    private
    def existNextPlaces(places_data:)
        if places_data.has_key?("next_page_token") == true then
            add_places_data = getNextPlace(next_page_token: places_data["next_page_token"])
            
            add_places_data["results"].each {
                | place | @lanch_places.push( place )
            }

            existNextPlaces(places_data: add_places_data)
        end
    end

    private
    def getNextPlace(next_page_token:)
        return Places.getAll({
            "key" => ENV["GOOGLE_API_PLACES_KEY"],
            "next_page_token" => next_page_token
        })
    end

    private
    def validateParam(param:)
        if param.blank? then
            raise Errors.new(status: 400, detail: "param is required")
        end
    end
end