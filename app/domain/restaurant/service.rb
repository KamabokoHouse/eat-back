require "./app/infrastructure/google/api/places"
include Places

class RestaurantService
    def initialize(latitude:, longitude:)
        @latitude = latitude
        @longitude = longitude
    end

    def getPlacesByWalkingDistance()
        return Places.getAll({
            "key" => ENV["GOOGLE_API_PLACES_KEY"],
            "location" => "#@latitude, #@longitude",
            "radius" => 800,
            "language" => "ja",
            "opennow" => true,
        })
    end
end