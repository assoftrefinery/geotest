class SitiosController < ApplicationController
  before_action :set_sitio, only: [:show, :edit, :update, :destroy]

  # GET /sitios
  # GET /sitios.json
  def index
    @sitios = Sitio.all
    
      @hash = Gmaps4rails.build_markers(@sitios) do |sitio, marker|
          marker.json({:id => sitio.id })
           #marker.picture({
           #       :url => "http://maps.google.com/maps/api/staticmap?size=450x300&sensor=false&zoom=32&markers=#{sitio.latitude}%2C#{sitio.longitude}",
           #       :width   => 32,
           #       :height  => 32
           #      })
          marker.title      sitio.titulo
          marker.lat        sitio.latitude
          marker.lng        sitio.longitude
          marker.infowindow "<p  style='color:darkblue;' >" + sitio.notas + ' / Codigo Postal: ' + "#{sitio.postal_code}</b>" + "</p>"     #"<b>#{sitio_path(sitio)}</b>"
      end
      
  end

  # GET /sitios/1
  # GET /sitios/1.json
  def show
  end

  # GET /sitios/new
  def new
    @sitio = Sitio.new
  end

  # GET /sitios/1/edit
  def edit
  end

  # POST /sitios
  # POST /sitios.json
  def create
    @sitio = Sitio.new(sitio_params)

    respond_to do |format|
      if @sitio.save
        format.html { redirect_to @sitio, notice: 'Sitio creado!' }
        format.json { render :show, status: :created, location: @sitio }
      else
        format.html { render :new }
        format.json { render json: @sitio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sitios/1
  # PATCH/PUT /sitios/1.json
  def update
    respond_to do |format|
      if @sitio.update(sitio_params)
        format.html { redirect_to @sitio, notice: 'Sitio actualizado!' }
        format.json { render :show, status: :ok, location: @sitio }
      else
        format.html { render :edit }
        format.json { render json: @sitio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sitios/1
  # DELETE /sitios/1.json
  def destroy
    @sitio.destroy
    respond_to do |format|
      format.html { redirect_to sitios_url, notice: 'Sitio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sitio
      @sitio = Sitio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sitio_params
      params.require(:sitio).permit(:titulo, :direccion, :notas, :latitude, :longitude)
    end
end
