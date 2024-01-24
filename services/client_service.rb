# frozen_string_literal: true

require 'json'

# ClientService
# Holds the logic for data management
class ClientService
  def initialize(file_name: './data/clients.json')
    initialize_clients(file_name)
  end

  def search(value:, attribute: 'full_name')
    @clients.select { |client| client[attribute].downcase.strip.include?(value.downcase.strip) }
  end

  def duplicates_list(attribute: 'email')
    @clients.group_by { |client| client[attribute] }.select { |_, matches| matches.size > 1 }.map(&:first)
  end

  private

  def initialize_clients(file_name)
    @clients = JSON.parse(File.read(file_name))
  rescue StandardError
    @clients = []
  end
end
