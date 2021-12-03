module Destatis
  class Kreis < Region
    attr_accessor :kreis_id, :regierungsbezirk_id

    def gemeinden
      Gemeinde.all.select { |i| i.kreis_id == kreis_id && i.state_id == state_id }
    end
  end
end
