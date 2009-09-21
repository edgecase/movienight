module LocationsHelper
  def should_check?(loc)
    @location && @location.id == loc.id ? 'check_me' : ''
  end
end
