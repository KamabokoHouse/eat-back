require "./app/domain/restaurant/service"

RSpec.describe "ランチを営業している店を知りたい" do
    it '店の一覧が返却されること' do
        response = <<'EOF'
{
"html_attributions": [],
"results": [
    {
        "geometry": {
            "location": {
                "lat": -33.8585416,
                "lng": 151.2100441
            },
            "viewport": {
                "northeast": {
                    "lat": -33.85717672010728,
                    "lng": 151.2112447798927
                },
                "southwest": {
                    "lat": -33.85987637989272,
                    "lng": 151.2085451201073
                }
            }
        },
        "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/bar-71.png",
        "id": "8e980ad0c819c33cdb1cea31e72d654ca61a7065",
        "name": "Cruise Bar",
        "opening_hours": {
            "open_now": true
        },
        "photos": [
            {
                "height": 4032,
                "html_attributions": [
                    "<a href=\"https://maps.google.com/maps/contrib/113789395029859570237/photos\">sreeju c</a>"
                ],
                "photo_reference": "CmRaAAAA2a9tcG1CYQJc8XI_FkPsQLryzMUN5QSqfw5smyJ3vUnI4FFtTk7Dx0bejwcwj22fSEJdB8UlwN9iI4B53SQR4j5B24bJ4cdacuAr26qA2siOvXbkwWAO1eovqZoY55r2EhB3WQ86RyYi0A5cUjEgPEuSGhRy7OTVtpJniKrz-pIus8-X1gQMmQ",
                "width": 2268
            }
        ],
        "place_id": "ChIJi6C1MxquEmsR9-c-3O48ykI",
        "plus_code": {
            "compound_code": "46R6+H2 The Rocks, New South Wales",
            "global_code": "4RRH46R6+H2"
        },
        "price_level": 2,
        "rating": 4,
        "reference": "ChIJi6C1MxquEmsR9-c-3O48ykI",
        "scope": "GOOGLE",
        "types": [
            "bar",
            "restaurant",
            "food",
            "point_of_interest",
            "establishment"
        ],
        "user_ratings_total": 850,
        "vicinity": "Level 1, 2 and 3, Overseas Passenger Terminal, Circular Quay W, The Rocks"
    },
    {
        "geometry": {
            "location": {
                "lat": -33.8675829,
                "lng": 151.2016025
            },
            "viewport": {
                "northeast": {
                    "lat": -33.86623307010728,
                    "lng": 151.2029523298927
                },
                "southwest": {
                    "lat": -33.86893272989272,
                    "lng": 151.2002526701073
                }
            }
        },
        "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
        "id": "ce4ffe228ab7ad49bb050defe68b3d28cc879c4a",
        "name": "Sydney Showboats",
        "opening_hours": {
            "open_now": true
        },
        "photos": [
            {
                "height": 4912,
                "html_attributions": [
                    "<a href=\"https://maps.google.com/maps/contrib/107415973755376511005/photos\">Sydney Showboats - Dinner Cruise Sydney Harbour</a>"
                ],
                "photo_reference": "CmRaAAAAxljeMDImQthQ92qixUf4e-8ptWiV0mDKu7ijTArJTxXtOkYrG3HsDfjR7XcIpfFjom50HCzhxmfJ4ajpRzGh4T_EHrk_E49ebAjQrOJtQa6vFYZjtRVxB6Y9gd_fXKEBEhCXVxGKKnXle1uUFWNNBCL0GhQ1CAKEWfYlz0OSBRSMK-l4a0kExg",
                "width": 7360
            }
        ],
        "place_id": "ChIJjRuIiTiuEmsRCHhYnrWiSok",
        "plus_code": {
            "compound_code": "46J2+XJ Sydney, New South Wales",
            "global_code": "4RRH46J2+XJ"
        },
        "rating": 4.1,
        "reference": "ChIJjRuIiTiuEmsRCHhYnrWiSok",
        "scope": "GOOGLE",
        "types": [
            "travel_agency",
            "restaurant",
            "food",
            "point_of_interest",
            "establishment"
        ],
        "user_ratings_total": 86,
        "vicinity": "32 The Promenade, King Street Wharf 5, Sydney"
    }
],
"status": "OK"
}
EOF

        allow(Places).to receive(:getAll).and_return(response)
        restaurant = RestaurantService.new(longitude: "1111", latitude: "2222")
        expect(restaurant.getPlacesByWalkingDistance).to eq response
    end
  end