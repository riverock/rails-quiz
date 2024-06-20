class CompaniesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
    http_basic_authenticate_with name: "username", password: "password", only: [:create]

    def index
      @companies = Company.all

      if params[:name].present?
        @companies = @companies.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%")
      end

      @companies = @companies.page(params[:page]).per(params[:per_page])

      respond_to do |format|
        format.html
        format.json { render :index }
      end
    end

    def create
        companies = companies_params[:companies].map do |company_params|
            Company.create(company_params)
        end

        render json: companies, status: :created
    end
    
    private

    def companies_params
        params.permit(companies: [:name])
    end
end
