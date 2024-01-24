# frozen_string_literal: true

# DuplicatedItemsView
# Formats the output for the results of finding duplicates in the file
class DuplicatedItemsView < BaseView
  def self.summary_output(results, attribute)
    return 'No duplicates found' if results.empty?

    "The following items are duplicated when being evaluated by #{attribute_name(attribute)}: #{results.join(', ')}"
  end
end
