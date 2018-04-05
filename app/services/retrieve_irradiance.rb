class RetrieveIrradiance

  def initialize(zipcode)
    @zipcode = zipcode
  end

  def irradiance
    NrelServices.new(zipcode).irradiance_lookup[:outputs][:avg_dni][:annual]
  end

  private
    attr_reader :zipcode

end
