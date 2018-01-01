class AuthenticateController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]
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
