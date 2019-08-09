require "./app/infrastructure/google/api/places"
include Places

class RestaurantService
    def initialize(longitude, latitude)
        @longitude = longitude
        @latitude = latitude
    end

    def getPlacesByWalkingDistance()
        return Places.getAll({
            "key" => ENV["GOOGLE_API_PLACES_KEY"],
            "location" => "#@latirude, #@longitude",
            "radius" => 800,
            "language" => "ja",
            "opennow" => true,
        })
    end
end