# frozen_string_literal: true

require_relative '../../views/search_view'

describe SearchView do
  describe '.summary_output' do
    it 'returns a formatted message' do
      expected_message = 'Found 2 results when searching by the attribute: Full name'
      expect(described_class.summary_output(2, 'full_name')).to eq(expected_message)
    end

    context 'with one result' do
      it 'returns a formatted message' do
        expected_message = 'Found 1 result when searching by the attribute: Full name'
        expect(described_class.summary_output(1, 'full_name')).to eq(expected_message)
      end
    end

    context 'without results' do
      it 'returns a formatted message' do
        expected_message = 'Found 0 results when searching by the attribute: Full name'
        expect(described_class.summary_output(0, 'full_name')).to eq(expected_message)
      end
    end
  end
end
