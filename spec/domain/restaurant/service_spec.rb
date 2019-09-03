require "./app/domain/restaurant/service"
require "./app/infrastructure/error/errors"
require 'spec_helper'
require 'rails_helper'

RSpec.describe "800m以内で営業中の飲食店を知る" do
    context "存在する場合" do
        
        let(:first_place) {
            {
                "html_attributions" => [],
                "results" => [
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
                ],
                "status" => "OK",
                "next_page_token" => "e08fd001-36ea-48cc-afbe-ac614a043cc2"
            }
        }
        let(:next_place) { 
            {
            "html_attributions"=> [],
            "results"=> [
                {        
                    "id": "ce4ffe228ab7ad49bb050defe68b3d28cc879c4a",
                    "name": "Sydney Showboats",
                    "opening_hours": {
                        "open_now": true
                    },
                    "types": [
                        "restaurant"
                    ]
                }
            ],
            "status"=> "OK",
            "next_page_token" => "70fcb979-971d-469e-9af6-7a2f44c3a22d"
            }
        
        }
        let(:last_place) { 
            {
            "html_attributions"=> [],
            "results"=> [
                {        
                    "id": "99904cd274e440d99a2ddc76a6fe1141",
                    "name": "Black Cats",
                    "opening_hours": {
                        "open_now": true
                    },
                    "types": [
                        "restaurant"
                    ]
                }
            ],
            "status"=> "OK"
            }
        }
        let(:all_places) {
            place = first_place["results"]
            place.push(next_place["results"][0])
            place.push(last_place["results"][0])
            return place
        }
        let(:restaurant) {
            RestaurantService.new(latitude: "1111", longitude: "2222")
        }

        before do
            allow(ENV).to receive(:[]).and_call_original
            allow(ENV).to receive(:[]).with("GOOGLE_API_PLACES_KEY").and_return("test_key")
        end

        it '店のリストが返却されること' do
            expect(Places).to receive(:getAll).with({
                "key" => "test_key",
                "location" => "1111, 2222",
                "radius" => 800,
                "language" => "ja",
                "opennow" => true,
                "type" => "restaurant"
            }).and_return(first_place)
            
            expect(Places).to receive(:getAll).with({
                "key" => "test_key",
                "next_page_token" => "e08fd001-36ea-48cc-afbe-ac614a043cc2"
            }).and_return(next_place)

            expect(Places).to receive(:getAll).with({
                "key" => "test_key",
                "next_page_token" => "70fcb979-971d-469e-9af6-7a2f44c3a22d"
            }).and_return(last_place)

            expect(restaurant.getLanchPlaceAll).to eq all_places
        end
    end

    context "存在しない場合" do
        
        let(:response) {{}}
        let(:restaurant) {
            RestaurantService.new(latitude: "1111", longitude: "2222")
        }

        before do
            allow(ENV).to receive(:[]).and_call_original
            allow(ENV).to receive(:[]).with("GOOGLE_API_PLACES_KEY").and_return("test_key")
        end

        it "空のリストが返却されること" do
            expect(Places).to receive(:getAll).with({
                "key" => "test_key",
                "location" => "1111, 2222",
                "radius" => 800,
                "language" => "ja",
                "opennow" => true,
                "type" => "restaurant"
            }).and_return(response)
            expect(restaurant.getLanchPlaceAll).to eq response
        end
    end

    context "現在地が不明の場合" do

        it "例外が投げられていること" do
            expect { RestaurantService.new(latitude: nil, longitude: nil) }.to raise_error(Errors)
        end
        
    end
  end