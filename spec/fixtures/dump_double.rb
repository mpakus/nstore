# frozen_string_literal: true

class DumpDouble
  include NStore

  attr_accessor :meta
  attr_accessor :storage

  nstore :meta,
         accessors: { board: %i[id name] },
         prefix: false
  nstore :storage,
         accessors: { board: %i[id name] },
         prefix: true
end
