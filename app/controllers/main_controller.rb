class MainController < ApplicationController
  def index
    render json: {
      app: 'Everlywell Challenge App'
    }
  end
end
