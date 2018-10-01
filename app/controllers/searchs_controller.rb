class SearchsController < ApplicationController
  respond_to :js

  def search
    respond_with(@results = Object.const_get(params[:search_by]).search(params[:search]))
  end
end
