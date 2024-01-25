# frozen_string_literal: true

# SearchView
# Formats the output for the results of searching in the file
class SearchView < BaseView
  def self.summary_output(results, attribute)
    summary = "Found #{results_summary(results.count)} when searching by the attribute: #{attribute_name(attribute)}\n"
    if results.count.positive?
      summary += results.map.with_index do |result, index|
        "#{index + 1}. #{result['full_name']} - #{result['email']}\n"
      end.join
    end
    summary
  end
end
