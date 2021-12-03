module Destatis
  class Gemeinde < Region
    attr_accessor :kreis_id, :regierungsbezirk_id, :gemeinde_id, :gemeindeverband_id
  end
end
