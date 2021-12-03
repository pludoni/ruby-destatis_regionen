module Destatis
  class State < Region
    def inspect
      "<#{self.class.name} #{gemeinde_name}>"
    end

    def regierungsbezirke
      Regierungsbezirk.all.select { |i| i.state_id == state_id }
    end

    def kreise
      Kreis.all.select { |i| i.state_id == state_id }
    end
  end
end
