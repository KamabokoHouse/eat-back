require "./app/infrastructure/google/api/places_errors"
require "net/http"
module Places

    def getAll(query)
        uri = URI.parse(ENV["GOOGLE_API_PLACES_URL"])
        uri.query = URI.encode_www_form(query)

        Rails.logger.info("url: #{uri}")
        # wait google genereted next result.
        sleep(5)
        response = Net::HTTP.get_response(uri)
        
        results = ActiveSupport::JSON.decode(response.body)
        if results["status"] != "OK" then
            # change status message to status code.
            raise PlacesErrors.new(status: results["status"], detail: results["status"])
        end

        Rails.logger.info("status: #{results["status"]}, body: #{results}")

        return results
    end

    module_function :getAll
end