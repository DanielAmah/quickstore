class UsersController < ApplicationController
skip_before_action :authenticate_request, only: %i[login register]
before_action :set_user, only: %i[show destroy]

def index
  @user = User.select(:id, :name, :email, :phone_number, :address, :city, :role_id).paginate(page: params[:page], per_page: 10)
  if @user.empty?
    obj = {
      message: 'User not Found'
    }
    return json_response(obj, 404)
  end
  json_response(@user)
end

  def register
    @user = User.create!(name: params[:name], email: params[:email], password: params[:password], phone_number: params[:phone_number], address: params[:address],
    city: params[:city], state: params[:state], country: params[:country], role_id: params[:role_id] || 2)
    if @user.save
      command = AuthenticateUser.call(params[:email], params[:password])
      if command.success?
        obj = {
          auth_token: command.result,
          name: @user.name,
          email: @user.email,
          role_id: @user.role_id,
          message: 'User Created Successfully and Logged in'
        }
        return json_response(obj, :created)
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end 
    json_response(@user.errors, :created)
  end

  def show
    json_response(@user)
  end

  def search
    if params[:q]
      @user = User.search(params[:q]).select(:id, :name, :email, :phone_number, :address, :city, :role_id)
      return json_response(@user, :ok)
    else
      obj = {
        message: 'No search key, Use routes \'/users/search/{search value}\''
      }
      return json_response(obj, :bad)
    end
  end

  def update
    if params[:email]
      @user = User.where(email: params[:email])
      unless @user.empty?
        obj = {
          message: 'Email Already Exist'
        }
        return json_response(obj, :bad)
      end
    end 

   @user = User.find(params[:id])
   @user.attributes = user_params
 
     if @user.save(validate: false)
       obj = {
         message: 'User Updated Succefully'
       }
       return json_response(obj, :ok)
     end
     json_response(@user.errors, :bad)
  end

  def login
    authenticate params[:email], params[:password]
  end

  def test
    render json: {
          message: 'You have passed authentication and authorization test'
        }
  end

  private

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: command.result,
        message: 'User Successfully Logged in'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def set_user
    @user = User.select(
    :id,
    :name,
    :email,
    :password,
    :phone_number,
    :address,
    :city,
    :state,
    :country,
    :role_id).find(params[:id])
  end

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :phone_number,
      :address,
      :city,
      :state,
      :country
    )
  end
end
