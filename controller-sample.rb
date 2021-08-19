class IntervalsController < ApplicationController
  before_action :set_interval, only: [:show, :edit, :update, :destroy]

  # GET /intervals
  # GET /intervals.json
  def index
    #todo scope by current user meter
    @intervals = Interval.bydate.page params[:page]
  end

  # GET /intervals/1
  # GET /intervals/1.json
  def show
  end

  # GET /intervals/new
  def new
    @interval = Interval.new
  end

  # GET /intervals/1/edit
  def edit
  end

  # POST /intervals
  # POST /intervals.json
  def create
    @interval = Interval.new(interval_params)

    respond_to do |format|
      if @interval.save
        format.html { redirect_to @interval, notice: 'Interval was successfully created.' }
        format.json { render :show, status: :created, location: @interval }
      else
        format.html { render :new }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intervals/1
  # PATCH/PUT /intervals/1.json
  def update
    respond_to do |format|
      if @interval.update(interval_params)
        format.html { redirect_to @interval, notice: 'Interval was successfully updated.' }
        format.json { render :show, status: :ok, location: @interval }
      else
        format.html { render :edit }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intervals/1
  # DELETE /intervals/1.json
  def destroy
    @interval.destroy
    respond_to do |format|
      format.html { redirect_to intervals_url, notice: 'Interval was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    #sets format for the import based on user source data

    interval = Interval.import(params[:file])

    #todo call the IntervalBlankFillJob that will find blank time slots for @period (1.year, 2.year etc) , then fill in the blanks
    #by using an algorythm that looks at various data - last week, last month, last year etc then adjusts for seasonality

    redirect_to meter_intervals_path(@meter), notice: 'Interval data was loaded from external CSV file. Data analysis is being performed to create 1 year of clean history'

  end


  def clear_meter
     intervals = Interval.where(service_uid: params[:meter]).delete_all
     redirect_to intervals_path, notice: "Interval data was deleted for meter #{params[:meter]}"
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interval
      @interval = Interval.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interval_params
      params.require(:interval).permit(:service_uid, :utility, :utility_service_id, :utility_service_address, :utility_meter_number, :utility_tariff_name, :interval_start, :interval_end, :interval_kwh, :interval_kw, :source, :updated, :interval_timezone)
    end
end
