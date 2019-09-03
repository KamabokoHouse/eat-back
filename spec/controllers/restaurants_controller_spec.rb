require "./app/controllers/restaurants_controller"
require "./app/controllers/application_controller"
require "./app/infrastructure/error/errors"
require "./app/domain/restaurant/service"
require 'spec_helper'
require 'rails_helper'

RSpec.describe RestaurantsController do
    context "正常な状態の場合" do
        let(:restaurants){
                {   
                        "id" => "8e980ad0c819c33cdb1cea31e72d654ca61a7065",
                        "name"=> "Cruise Bar",
                        "opening_hours"=> {
                            "open_now" => true
                        },
                        "place_id" => "ChIJi6C1MxquEmsR9-c-3O48ykI",
                        "types"=> [
                            "restaurant"
                        ]
                }
        }
        it "健全なレスポンスを返すこと" do
            allow_any_instance_of(RestaurantService).to receive(:getLanchPlaceAll).and_return(restaurants)

            get :show, params: { latitude: "-33.8585416", longitude:"151.2100441"}
            expect(response).to have_http_status "200"
        end
    end

    context "異常な状態の場合" do
        let(:error_instance) {
            Errors.new(status: 400, detail: "latitude is required")
        }

        it "不健全なレスポンスを返すこと" do
            allow_any_instance_of(RestaurantService).to receive(:getLanchPlaceAll).and_raise(error_instance)
            
            get :show, params: { latitude: "", longitude:""}
            expect(response).to have_http_status "400"
        end
    end
end