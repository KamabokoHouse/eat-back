module Places
    URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/output"

    def getAll(query)
        uri = URI.parse(URL)
        uri.query = URI.encode_www_form(query)

        Rails.logger.info("url: #{uri}")
        response = Net::HTTP.get_response(uri)
        Rails.logger.info("status: #{response.code}, body: #{response.body}")

        return response.body
    end

    module_function :getAll
end