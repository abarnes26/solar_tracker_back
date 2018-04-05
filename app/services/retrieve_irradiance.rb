class RetrieveIrradiance

  def initialize(args)
    @street = args['street']
    @city = args['city']
    @state = args['state']
  end

  def venue_list
    NrelServices.new(clean_data(street), clean_data(city), state).irradiance_lookup
  end

  def clean_data(data)
    unless data.split.size == 1
      data = data.gsub(/ /, '+')
    end
    data
  end

  private
    attr_reader :street, :city, :state

end
