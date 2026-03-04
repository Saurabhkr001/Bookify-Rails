require 'rails_helper'

RSpec.describe BooksController, type: :controller do
    
    before(:each) do
        @user = FactoryBot.create(:user)
        @book = FactoryBot.create(:book, user: @user)
        sign_in @user
    end

    describe "GET /INDEX" do
        it "shows all the books" do
            get :index
            expect(response).to have_http_status(:success)
        end
    end


end
