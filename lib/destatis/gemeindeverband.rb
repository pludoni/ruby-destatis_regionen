module Destatis
  class Gemeindeverband < Region
    attr_accessor :kreis_id, :regierungsbezirk_id, :gemeindeverband_id

    def gemeinden
      Gemeinde.all.select { |i| i.kreis_id == kreis_id && i.state_id == state_id && i.gemeindeverband_id == gemeindeverband_id }
    end
  end
end
