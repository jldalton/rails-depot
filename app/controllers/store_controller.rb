class StoreController < ApplicationController
  def index
      @products = Product.order(:title)
      @count = session_count(:store)
  end
end
