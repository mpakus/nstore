# frozen_string_literal: true

require_relative './fixtures/dump_no_prefix'
require_relative './fixtures/dump_with_prefix'
require_relative './fixtures/dump_stringify'

RSpec.describe NStore do
  it 'has a version number' do
    expect(NStore::VERSION).not_to be nil
  end

  context 'with methods' do
    subject { DumpNoPrefix.new }

    it 'creates setters and getters' do
      %i[
        raw_board_id raw_board_name
        raw_column_id raw_column_name
        raw_column_user_id raw_column_user_name
        trello_id trello_name
      ].each do |m|
        value = "VALUE: #{m}"
        subject.send("#{m}=".to_sym, value)
        expect(subject.send(m)).to eq value
      end
    end
  end

  context 'with prefix' do
    subject { DumpWithPrefix.new }

    it 'creates setters and getters' do
      %i[
        meta_raw_board_id meta_raw_board_name
        meta_raw_column_id meta_raw_column_name
        meta_raw_column_user_id meta_raw_column_user_name
        meta_trello_id meta_trello_name
      ].each do |m|
        value = "VALUE: #{m}"
        subject.send("#{m}=".to_sym, value)
        expect(subject.send(m)).to eq value
      end
    end
  end

  context 'with stringify option' do
    describe 'when stringify on' do
      subject { DumpStringify.new }

      it 'sets nested hash values with string keys' do
        subject.raw_column_user_id   = 100
        subject.raw_column_user_name = 'Renat'
        result                       = { 'raw' => { 'column' => { 'user' => { 'id' => 100, 'name' => 'Renat' } } } }

        expect(subject.meta).to eq result
      end
    end

    describe 'when stringify off' do
      describe 'prefix off' do
        subject { DumpNoPrefix.new }

        it 'sets nested hash values with symbol keys' do
          subject.raw_board_id   = 100
          subject.raw_board_name = 'Renat'
          result                 = { raw: { board: { id: 100, name: 'Renat' } } }

          expect(subject.meta).to eq result
        end
      end

      describe 'prefix on' do
        subject { DumpWithPrefix.new }

        it 'sets nested hash values with symbol keys' do
          subject.meta_raw_column_user_id   = 100
          subject.meta_raw_column_user_name = 'Renat'
          result                            = { raw: { column: { user: { id: 100, name: 'Renat' } } } }

          expect(subject.meta).to eq result
        end
      end
    end
  end
end
