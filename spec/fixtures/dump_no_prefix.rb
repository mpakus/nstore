# frozen_string_literal: true

class DumpNoPrefix
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
         prefix: false,
         stringify: false

  def initialize(meta = {})
    @meta = meta
  end
end
