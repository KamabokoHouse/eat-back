require "./app/infrastructure/error/errors"
require "./app/infrastructure/google/api/places_errors"
require 'action_controller'

class ApplicationController < ActionController::API
    rescue_from Errors, with: :handleApplication
    rescue_from PlacesErrors, with: :handleApplication

    private
    def handleApplication(e)
      #Rails.logger.error("status: #{e.status}, detail: #{e.detail}")
      render json: { status: e.status, detail: e.detail }, status: e.status
    end
end
