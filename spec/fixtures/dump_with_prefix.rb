require 'nstore'

class DumpWithPrefix
  include NStore

  attr_accessor :meta

  nstore :meta,
         accessors: {
             raw: {
                 board:  [:id, :name],
                 column: [:id, :name, user: [:id, :name]]
             },
             trello: [:id, :name]
         },
         prefix: true

  def initialize(meta = {})
    @meta = meta
  end
end