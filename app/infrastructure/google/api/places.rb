require "net/http"
module Places

    def getAll(query)
        uri = URI.parse(ENV["GOOGLE_API_PLACES_URL"])
        uri.query = URI.encode_www_form(query)

        #Rails.logger.info("url: #{uri}")
        response = Net::HTTP.get_response(uri)
        
        results = ActiveSupport::JSON.decode(response.body)
        if results["status"] != "OK" then
            raise "#{results["status"]}"
        end

        #Rails.logger.info("status: #{results["status"]}, body: #{results}")

        return results
    end

    module_function :getAll
end