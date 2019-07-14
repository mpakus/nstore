class DumpNoPrefix
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
         prefix: false

  def initialize(meta = {})
    @meta = meta
  end
end
