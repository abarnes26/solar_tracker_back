class RetrieveEnergyProfile

  def initialize(zipcode)
    @zipcode = zipcode
  end

  def energy_profile
    NrelServices.new(zipcode).energy_profile_lookup[:result].first[1][:residential]
  end

  private
    attr_reader :zipcode

end
