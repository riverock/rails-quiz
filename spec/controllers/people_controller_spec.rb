require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  subject { response }
  describe "GET #index" do
    before do
      create_list(:person, 15) # Create 15 persons
    end

    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @persons with paginated persons" do
      get :index, params: { page: 1 }
      expect(assigns(:persons)).to eq(Person.page(1).per(10))
    end
  end

  describe 'GET new' do
    before { get :new }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'POST create' do
    it 'Creates a record' do
      expect{ post :create, params: { person: { name: 'foo', phone_number: '123', email: 'foo' } } }.to change{ Person.count }.by(1)
    end

    it 'has status found' do
      expect(post :create, params: { person: { name: 'foo', phone_number: '123', email: 'foo' } }).to have_http_status(:found)
    end
  end
end
