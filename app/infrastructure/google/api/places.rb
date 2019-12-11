require "./app/infrastructure/google/api/places_errors"
require "rest-client"
module Places

    def getAll(query)

        Rails.logger.info("url: #{ENV["GOOGLE_API_PLACES_URL"]}, pram: #{query}")
        # wait google genereted next result.
        sleep(5)
        # google api need proxy for heroku
        RestClient.proxy = ENV["QUOTAGUARDSTATIC_URL"]
        response = RestClient.get(ENV["GOOGLE_API_PLACES_URL"], {params: query})
        
        results = ActiveSupport::JSON.decode(response.body)
        if results["status"] != "OK" then
            Rails.logger.error("status: #{results["status"]}, body: #{results}")
            # change status message to status code.
            raise PlacesErrors.new(status: results["status"], detail: results["status"])
        end

        Rails.logger.info("status: #{results["status"]}, body: #{results}")

        return results
    end

    module_function :getAll
end