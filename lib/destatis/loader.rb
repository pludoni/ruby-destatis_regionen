module Destatis
  module Loader
    def self.save(target = File.join(__dir__, '../../data/regions.json'))
      require 'json'
      items = State.all + Gemeinde.all + Regierungsbezirk.all + Kreis.all
      File.write(
        target,
        items.map(&:as_json).to_json
      )
    end
  end
end
