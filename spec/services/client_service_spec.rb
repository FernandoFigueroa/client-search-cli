# frozen_string_literal: true

require_relative '../../services/client_service'

describe ClientService do
  let(:client_service) { described_class.new }
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
  let(:clients) { JSON.generate([first_client, second_client]) }

  before do
    allow(File).to receive(:read).and_return(clients)
  end

  context 'with an invalid JSON file' do
    let(:clients) { 'invalids' }

    it 'handles gracefully' do
      expect { client_service }.not_to raise_error
    end
  end

  describe '#search' do
    it 'searches by full name by default' do
      expect(client_service.search(value: 'second')).to eq([second_client])
    end

    it 'ignores case' do
      expect(client_service.search(value: 'SECOND')).to eq([second_client])
    end

    it 'removes trailing or leading white spaces' do
      expect(client_service.search(value: ' second ')).to eq([second_client])
    end

    it 'accepts multiple words' do
      expect(client_service.search(value: 'second user')).to eq([second_client])
    end

    it 'returns multiple results' do
      expect(client_service.search(value: 'user')).to eq([first_client, second_client])
    end

    it 'returns empty array when no matches' do
      expect(client_service.search(value: 'walter white')).to eq([])
    end

    context 'with a different search attribute' do
      it 'searches by email' do
        expect(client_service.search(attribute: 'email', value: 'first.user')).to eq([first_client])
      end
    end
  end

  describe '#duplicates_list' do
    it 'returns empty array when no duplicates' do
      expect(client_service.duplicates_list).to eq([])
    end

    context 'with duplicated emails' do
      let(:second_client) do
        {
          'id' => 2,
          'full_name' => 'second user',
          'email' => first_client['email']
        }
      end

      it 'returns duplicates in the list' do
        expect(client_service.duplicates_list).to eq(['first.user@email.com'])
      end
    end

    context 'with different attributes' do
      let(:second_client) do
        {
          'id' => 2,
          'full_name' => first_client['full_name'],
          'email' => 'second.user@email.com'
        }
      end

      it 'returns duplicates in the list' do
        expect(client_service.duplicates_list(attribute: 'full_name')).to eq(['first user'])
      end
    end
  end
end
