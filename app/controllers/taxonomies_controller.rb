class TaxonomiesController < ApplicationController
  before_action :set_taxonomy, only: [:show, :update, :destroy]

  # GET /taxonomies
  # GET /taxonomies.json
  def index
    @taxonomies = Taxonomy.all
  end

  # GET /taxonomies/1
  # GET /taxonomies/1.json
  def show
    render json: @taxonomy.to_h
  end

  # POST /taxonomies
  # POST /taxonomies.json
  def create
    @taxonomy = Taxonomy.new(taxonomy_params)

    if @taxonomy.save
      render :show, status: :created, location: @taxonomy
    else
      render json: @taxonomy.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /taxonomies/1
  # PATCH/PUT /taxonomies/1.json
  def update
    if @taxonomy.update(taxonomy_params)
      render :show, status: :ok, location: @taxonomy
    else
      render json: @taxonomy.errors, status: :unprocessable_entity
    end
  end

  # DELETE /taxonomies/1
  # DELETE /taxonomies/1.json
  def destroy
    @taxonomy.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taxonomy
      @taxonomy = Taxonomy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def taxonomy_params
      params.require(:taxonomy).permit(:name, :key, :version, :owner, :description, :notes, :body)
    end
end
