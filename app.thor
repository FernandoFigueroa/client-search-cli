# frozen_string_literal: true

require_relative 'services/client_service'
require_relative 'views/base_view'
require_relative 'views/search_view'
require_relative 'views/duplicated_items_view'

# App
# Main application class, executed with Thor, should be considered as the entry point
class App < Thor
  desc 'search "John Doe" full_name', 'Searches a client by the specified field (full_name by default)'
  def search(value, attribute = 'full_name')
    if %w[email full_name id].include?(attribute)
      results = ClientService.new.search(value:, attribute:)
      puts SearchView.summary_output(results, attribute)
    else
      puts 'Invalid attribute'
    end
  end

  desc 'duplicated_items email', 'Finds the duplicated items on the list'
  def duplicated_items(attribute = 'email')
    if %w[email full_name id].include?(attribute)
      results = ClientService.new.duplicates_list(attribute:)
      puts DuplicatedItemsView.summary_output(results, attribute)
    else
      puts 'Invalid attribute'
    end
  end
end
