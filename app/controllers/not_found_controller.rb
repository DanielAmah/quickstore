class NotFoundController < ApplicationController
  def index
    status = 404
    obj = { message: 'where you are going does not exist' }
    json_response(obj, status)
  end
end
