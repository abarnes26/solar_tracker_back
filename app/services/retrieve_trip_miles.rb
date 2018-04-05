class RetrieveTripMiles

  def initialize(project)
    @project = project
  end

  def get_distance
    response = GoogleDistanceServices.new(branch_address, project_address).distance_lookup
    response[:rows][0][:elements][0][:distance][:text].split(' ')[0].to_f
  end

  def branch_address
    "#{clean_data(project.branch.street)}+#{clean_data(project.branch.city)}+#{clean_data(project.branch.state)}"
  end

  def project_address
    "#{clean_data(project.street)}+#{clean_data(project.city)}+#{clean_data(project.state)}"
  end

  def clean_data(data)
    unless data.split.size == 1
      data = data.gsub(/ /, '+')
    end
    data
  end

  private
    attr_reader :project

end
