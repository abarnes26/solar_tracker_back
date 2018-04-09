class NrelServices
  def initialize(zipcode)
    @zipcode = zipcode
  end

  def irradiance_lookup
    get_json("solar/solar_resource/v1.json?address=#{zipcode}")
  end

  def energy_profile_lookup
    get_json("cleap/v1/energy_expenditures_and_ghg_by_sector.json?zip=#{zipcode}")
  end

  private
    attr_reader :zipcode

    def conn
      Faraday.new("https://developer.nrel.gov/api/") do |faraday|
        faraday.headers['X-Api-Key'] = ENV['NREL_API_KEY']
        faraday.adapter           Faraday.default_adapter
      end
    end

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
