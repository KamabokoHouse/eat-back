require "./app/infrastructure/error/errors"
class PlacesErrors < Errors
    def initialize(status: nil, detail: nil)
       super
       handle_status()
    end

    private
    def handle_status()
        case @status
        when "ZERO_RESULTS" then
            @status = 404
        when "REQUEST_DENIED" then
            @status = 403
        when "INVALID_REQUEST" then
            @status = 400
        else
            @status = 500
        end
    end
end
