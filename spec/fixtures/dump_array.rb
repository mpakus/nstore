# frozen_string_literal: true

class DumpArray
  include NStore

  attr_accessor :meta
  attr_accessor :storage

  nstore :meta,
         accessors: %i[id name],
         prefix: true
  nstore :storage,
         accessors: %i[id name],
         prefix: false
end
