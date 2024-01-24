# frozen_string_literal: true

require_relative '../../views/duplicated_items_view'

describe DuplicatedItemsView do
  describe '.summary_output' do
    it 'returns a formatted message' do
      expected_message = 'The following items are duplicated when being evaluated by Full name: 1, 2'
      expect(described_class.summary_output(%w[1 2], 'full_name')).to eq(expected_message)
    end

    context 'with one result' do
      it 'returns a formatted message' do
        expected_message = 'The following items are duplicated when being evaluated by Email: 1'
        expect(described_class.summary_output(['1'], 'email')).to eq(expected_message)
      end
    end

    context 'without results' do
      it 'returns a formatted message' do
        expect(described_class.summary_output([], 'full_name')).to eq('No duplicates found')
      end
    end
  end
end
