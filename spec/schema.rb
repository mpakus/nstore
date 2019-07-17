# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :dumps, force: true do |t|
    t.text :meta
    t.text :storage
    t.timestamps
  end
end
