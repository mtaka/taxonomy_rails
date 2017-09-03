class PageResController < ApplicationController
  before_action :set_page_re, only: [:show, :update, :destroy]

  # GET /page_res
  # GET /page_res.json
  def index
    @page_res = PageRe.all
  end

  # GET /page_res/1
  # GET /page_res/1.json
  def show
  end

  # POST /page_res
  # POST /page_res.json
  def create
    @page_re = PageRe.new(page_re_params)

    if @page_re.save
      render :show, status: :created, location: @page_re
    else
      render json: @page_re.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /page_res/1
  # PATCH/PUT /page_res/1.json
  def update
    if @page_re.update(page_re_params)
      render :show, status: :ok, location: @page_re
    else
      render json: @page_re.errors, status: :unprocessable_entity
    end
  end

  # DELETE /page_res/1
  # DELETE /page_res/1.json
  def destroy
    @page_re.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_re
      @page_re = PageRe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_re_params
      params.require(:page_re).permit(:url, :owner, :description)
    end
end
