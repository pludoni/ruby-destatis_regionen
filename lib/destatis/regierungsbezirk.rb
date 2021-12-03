module Destatis
  class Regierungsbezirk < Region
    attr_accessor :regierungsbezirk_id

    def kreise
      Kreis.all.select { |i| i.regierungsbezirk_id == regierungsbezirk_id && i.state_id == state_id }
    end
  end
end
