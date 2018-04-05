class JamBaseServices
  def initialize(param)
    @param = param
  end

  def venue_lookup_zipcode
    get_json("?zipCode=#{@param}&page=0&api_key=#{ENV['JAMBASE_KEY']}")
  end

  def venue_lookup_name
    get_json("?name=#{@param}&page=0&api_key=#{ENV['JAMBASE_KEY']}")
  end

  private

    def conn
      Faraday.new(url: "http://api.jambase.com/venues") do |faraday|
        faraday.adapter  Faraday.default_adapter
      end
    end

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
