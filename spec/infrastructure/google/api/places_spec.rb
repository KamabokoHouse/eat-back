require "net/http"
require 'spec_helper'
require 'rails_helper'
require "./app/infrastructure/google/api/places"
include Places

RSpec.describe "Google API の Places APIと通信する" do
    context "健全なレスポンスの場合" do

        let(:helhty_response) {
            response_double = double("HTTPResponse")
            allow(response_double).to receive(:body).and_return('{
                "html_attributions": [],
                "results": [{}],
                "status": "OK"}')
            return response_double
        }

        let(:query){{
                "key" => "test_key",
                "location" => "1111, 2222",
                "radius" => 800,
                "language" => "ja",
                "opennow" => true,
            }}

        let(:uri_for_test) {
             uri = URI.parse("http://test.com")
             uri.query = URI.encode_www_form(query)
             return uri
        }

        before do
            allow(ENV).to receive(:[]).and_call_original
            allow(ENV).to receive(:[]).with("GOOGLE_API_PLACES_URL").and_return("http://test.com")
        end

        it "何も起きないこと" do
            expect(Net::HTTP).to receive(:get_response).with(uri_for_test).and_return(helhty_response)
            expect { Places.getAll(query) }.not_to raise_error
        end
    end
    context "不健全なレスポンスの場合" do
        let(:bad_response){
            response_double = double("HTTPResponse")
            allow(response_double).to receive(:body).and_return('{
                "html_attributions": [],
                "results": [{}],
                "error_message": "This API project is not authorized to use this API.",
                "status": "REQUEST_DENIED"}')
            return response_double
        }

        let(:query){{
            "key" => "test_key",
            "location" => "1111, 2222",
            "radius" => 800,
            "language" => "ja",
            "opennow" => true,
        }}

        let(:uri_for_test) {
            uri = URI.parse("http://test.com")
            uri.query = URI.encode_www_form(query)
            return uri
        }

        before do
            allow(ENV).to receive(:[]).and_call_original
            allow(ENV).to receive(:[]).with("GOOGLE_API_PLACES_URL").and_return("http://test.com")
        end

        it "例外が投げられていること" do
            expect(Net::HTTP).to receive(:get_response).with(uri_for_test).and_return(bad_response)
            expect { Places.getAll(query) }.to raise_error(RuntimeError)
        end
    end
end
