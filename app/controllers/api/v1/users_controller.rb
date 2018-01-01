module Api
  module V1
class UsersController < ApplicationController
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
         message: 'User Updated Successfully'
       }
       return json_response(obj, :ok)
     end
     json_response(@user.errors, :bad)
  end



  private


  def set_user
    @user = User.select(
    :id,
    :name,
    :email,
    :password_digest,
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
      :password_digest,
      :phone_number,
      :address,
      :city,
      :state,
      :country
    )
  end
end
end
end