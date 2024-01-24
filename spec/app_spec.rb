# frozen_string_literal: true

require 'spec_helper'

describe App do
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

  describe '.search' do
    it 'displays error message when using an invalid attribute' do
      expect { App.new.invoke(:search, %w[second invalid]) }.to output(
        a_string_including('Invalid attribute')
      ).to_stdout
    end

    it 'searches by full name' do
      expect { App.new.invoke(:search, ['user']) }.to output(
        a_string_including('Found 2 results when searching by the attribute: Full name')
      ).to_stdout
    end

    it 'searches by a different attribute' do
      expect { App.new.invoke(:search, %w[second email]) }.to output(
        a_string_including('Found 1 result when searching by the attribute: Email')
      ).to_stdout
    end

    context 'without matches' do
      it 'indicates not item was found' do
        expect { App.new.invoke(:search, ['third']) }.to output(
          a_string_including('Found 0 results when searching by the attribute: Full name')
        ).to_stdout
      end
    end
  end

  describe '.duplicated_items' do
    context 'without duplicated items' do
      it 'displays a not duplicates message' do
        expect { App.new.invoke(:duplicated_items, []) }.to output(
          a_string_including('No duplicates found')
        ).to_stdout
      end
    end

    context 'with duplicated items' do
      let(:second_client) do
        {
          'id' => 2,
          'full_name' => 'second user',
          'email' => first_client['email']
        }
      end

      it 'displays the duplicated matches' do
        expect { App.new.invoke(:duplicated_items, []) }.to output(
          a_string_including('The following items are duplicated when being evaluated by Email: first.user@email.com')
        ).to_stdout
      end

      context 'with a different evaluating attribute' do
        let(:second_client) do
          {
            'id' => 2,
            'full_name' => first_client['full_name'],
            'email' => 'second.user@email.com'
          }
        end
        it 'displays the duplicated matches' do
          expect { App.new.invoke(:duplicated_items, ['full_name']) }.to output(
            a_string_including('The following items are duplicated when being evaluated by Full name: first user')
          ).to_stdout
        end

        it 'displays an error message when using invalid attributes' do
          expect { App.new.invoke(:duplicated_items, ['invalid']) }.to output(
            a_string_including('Invalid attribute')
          ).to_stdout
        end
      end
    end
  end
end
