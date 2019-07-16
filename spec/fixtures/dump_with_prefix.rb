# frozen_string_literal: true

require 'nstore'

class DumpWithPrefix
  include NStore

  attr_accessor :meta

  nstore :meta,
         accessors: {
           raw: {
             board: %i[id name],
             column: [:id, :name, user: %i[id name]]
           },
           trello: %i[id name]
         },
         prefix: true,
         stringify: false

  def initialize(meta = {})
    @meta = meta
  end
end
