# frozen_string_literal: true

# BaseView
# Contains common methods for the "views"
class BaseView
  def self.results_summary(count)
    "#{count} #{count == 1 ? 'result' : 'results'}"
  end

  def self.attribute_name(attribute)
    attribute.gsub('_', ' ').capitalize
  end
end
