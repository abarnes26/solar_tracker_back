class GoogleDistanceServices

  def initialize(branch_address, project_address)
    @branch_address = branch_address
    @project_address = project_address
  end

  def distance_lookup
    get_json("json?units=imperial&origins=#{branch_address}&destinations=#{project_address}&key=#{ENV['GOOGLE_MAPS_DISTANCE_API_KEY']}")
  end

  private
    attr_reader :branch_address, :project_address

    def conn
      Faraday.new("https://maps.googleapis.com/maps/api/distancematrix/") do |faraday|
        faraday.adapter           Faraday.default_adapter
      end
    end

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
