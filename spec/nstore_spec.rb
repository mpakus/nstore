# frozen_string_literal: true

require_relative './fixtures/dump_no_prefix'
require_relative './fixtures/dump_with_prefix'
require 'awesome_print'

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
      trello_id trello_name].each do |m|
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
      meta_trello_id meta_trello_name].each do |m|
        value = "VALUE: #{m}"
        subject.send("#{m}=".to_sym, value)
        expect(subject.send(m)).to eq value
      end
    end
  end
end
