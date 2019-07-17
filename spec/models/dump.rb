# frozen_string_literal: true

# Simple model model with 2 nstore fields (serialized)
class Dump < ActiveRecord::Base
  include NStore

  store :meta, serialize: JSON
  store :storage, serialize: JSON

  nstore :meta,
         accessors: { board: %i[id name] },
         prefix: false
  nstore :storage,
         accessors: { board: %i[id name] },
         prefix: true
end
