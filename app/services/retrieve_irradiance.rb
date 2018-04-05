class RetrieveIrradiance

  def initialize(zipcode)
    @zipcode = zipcode
  end

  def irradiance
    NrelServices.new(zipcode).irradiance_lookup[:outputs][:avg_dni][:annual]
  end

  # def clean_data(data)
  #   unless data.split.size == 1
  #     data = data.gsub(/ /, '+')
  #   end
  #   data
  # end

  private
    attr_reader :zipcode

end
