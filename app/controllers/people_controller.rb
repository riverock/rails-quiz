class PeopleController < ApplicationController

  def index
    @people = Person.page(params[:page]).per(10)
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.create(person_attributes)
    if @person.save
      redirect_to people_path, notice: 'Successfully created entry'
    else
      render :new, alert: 'Unsuccessfully created entry'
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end

end

