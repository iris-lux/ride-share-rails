class DriversController < ApplicationController
  def index
    @drivers =Driver.all
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(
        name: params[:driver][:name],
        vin: params[:driver][:vin],
        available: true
    )
    if @driver.save
      redirect_to driver_path(@driver)
      return
    else
      render :new
      return
    end
  end

  def edit
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def update
    @driver = Driver.find(params[:id])
    result = @driver.update({
                                name: params[:driver][:name],
                                vin: params[:driver][:vin],
                                available: params[:driver][:available]
                          })

    if result
      redirect_to driver_path(@driver.id)
    else
      render :edit
    end
  end


  def destroy
    #how to handle trips by deleted drivers?
    driver = Driver.find_by_id(params[:id])
    if driver.nil?
      redirect_to drivers_path
      return
    end
    driver.trips.destroy_all
    if driver.destroy
      redirect_to drivers_path
    else

    end
  end


  def count
    count = Driver.count
  end

  def passenger_params
    return params.require(:driver).permit(:driver_id, :vin, :available)
  end

end
