# frozen_string_literal: true

# SearchView
# Formats the output for the results of searching in the file
class SearchView < BaseView
  def self.summary_output(results_count, attribute)
    "Found #{results_summary(results_count)} when searching by the attribute: #{attribute_name(attribute)}"
  end
end
