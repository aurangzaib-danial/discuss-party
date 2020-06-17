module Slugify
  def slug_for(attribute)
    define_method :slug do
      send(attribute).parameterize
    end
  end
end
