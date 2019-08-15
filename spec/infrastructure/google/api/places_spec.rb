require 'spec_helper'
require "./app/infrastructure/google/api/places"
include Places

RSpec.describe "Google API の Places APIと通信する" do
    context "健全なレスポンスの場合" do
        before do
        end

        it "何も起きないこと" do
        end
    end
    context "不健全なレスポンスの場合" do
        before do
        end

        it "例外が投げられていること" do
        end
    end
end
