# frozen_string_literal: true

require_relative '../../views/search_view'

describe SearchView do
  let(:first_client) do
    {
      'id' => 1,
      'full_name' => 'first user',
      'email' => 'first.user@email.com'
    }
  end
  let(:second_client) do
    {
      'id' => 2,
      'full_name' => 'second user',
      'email' => 'second.user@email.com'
    }
  end
  let(:clients) { [first_client, second_client] }

  describe '.summary_output' do
    it 'returns a formatted message' do
      expected_message = "Found 2 results when searching by the attribute: Full name\n"
      expected_message += "1. first user - first.user@email.com\n2. second user - second.user@email.com\n"
      expect(described_class.summary_output(clients, 'full_name')).to eq(expected_message)
    end

    context 'with one result' do
      it 'returns a formatted message' do
        expected_message = "Found 1 result when searching by the attribute: Full name\n"
        expected_message += "1. first user - first.user@email.com\n"
        expect(described_class.summary_output([first_client], 'full_name')).to eq(expected_message)
      end
    end

    context 'without results' do
      it 'returns a formatted message' do
        expected_message = "Found 0 results when searching by the attribute: Full name\n"
        expect(described_class.summary_output([], 'full_name')).to eq(expected_message)
      end
    end
  end
end
