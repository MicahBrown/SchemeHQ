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
    @entries = entry_list

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def scheme_params
      params.require(:scheme).permit(:title)
    end

    def entry_scope
      @scheme.entries.order('id DESC').includes(:votes, :schemable => :user)
    end

    def entry_list
      if params[:entry_id] && entry = @scheme.entries.find_by(id: params[:entry_id])
        entry_scope.page page(entry)
      else
        entry_scope.page params[:page]
      end
    end

    def page(record)
      position = entry_scope.where("id >= ?", record.id).count

      (position.to_f / Kaminari.config.default_per_page ).ceil
    end
end
