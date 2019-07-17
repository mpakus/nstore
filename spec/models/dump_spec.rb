# frozen_string_literal: true

RSpec.describe Dump do
  let(:dump) { Dump.new }

  subject { dump.reload }

  before do
    dump.board_id           = 100
    dump.board_name         = 'Meta Board'
    dump.storage_board_id   = 200
    dump.storage_board_name = 'Storage Board'
    dump.save!
  end

  it { expect(subject.board_id).to eq 100 }
  it { expect(subject.board_name).to eq 'Meta Board' }

  it { expect(subject.storage_board_id).to eq 200 }
  it { expect(subject.storage_board_name).to eq 'Storage Board' }

  it { expect(subject.meta).to eq('board' => { 'id' => 100, 'name' => 'Meta Board' }) }
  it { expect(subject.storage).to eq('board' => { 'id' => 200, 'name' => 'Storage Board' }) }
end
