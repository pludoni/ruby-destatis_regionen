module Destatis
  class Loader < AuszugGvParser
    def self.save(target = File.join(__dir__, '../../data/regions.json'))
      require 'json'
      items = State.all + Gemeinde.all + Regierungsbezirk.all + Kreis.all
      File.write(
        target,
        items.map(&:as_json).to_json
      )
    end

    def self.load(source = File.join(__dir__, '../../data/regions.json'))
      new(source).run
      true
    end

    def initialize(source)
      require 'json'
      json = JSON.parse(File.read(source))
      @items = json.map do |item|
        klass = case item['class']
                when 'Destatis::State' then Destatis::State
                when 'Destatis::Regierungsbezirk' then Destatis::Regierungsbezirk
                when 'Destatis::Gemeinde' then Destatis::Gemeinde
                when 'Destatis::Kreis' then Destatis::Kreis
                else
                  ArgumentError.new(item['class'])
                end
        item.delete 'class'
        object = klass.allocate
        item.each do |key, v|
          object.instance_variable_set("@#{key}", v)
        end
        object
      end
    end
  end
end
