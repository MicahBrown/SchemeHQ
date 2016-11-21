class SchemesController < ApplicationController
  load_and_authorize_resource param_method: :scheme_params, find_by: :token

  def new
  end

  def create
    respond_to do |format|
      if @scheme.save
        format.html { redirect_to @scheme, notice: "Successfully started scheme!" }
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  private

    def scheme_params
      params.require(:scheme).permit(:title)
    end
end
