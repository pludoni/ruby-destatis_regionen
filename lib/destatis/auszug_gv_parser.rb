module Destatis
  class AuszugGvParser
    HEADER = %i[ satzart textkennzeichen state_id regierungsbezirk_id kreis_id
                 gemeindeverband_id gemeinde_id gemeinde_name flaeche
                 bevoelkerung_insgesamt bevoelkerung_m bevoelkerung_w
                 bevoelkerung_km2 gemeinde_plz lat lon
                 reisegebiet_schluessel reisegebiet_name
                 verstaedtung_schluessel verstaedtung_name ]

    def initialize(file)
      require 'simple_xlsx_reader'

      @doc = SimpleXlsxReader.open(file)
    end

    def run
      State.all = states = items.select { |i| i.is_a?(State) }
      Regierungsbezirk.all = rb = items.select { |i| i.is_a?(Regierungsbezirk) }
      Kreis.all = kreise = items.select { |i| i.is_a?(Kreis) }
      Gemeinde.all = items.select { |i| i.is_a?(Gemeinde) }
      Gemeindeverband.all = items.select { |i| i.is_a?(Gemeindeverband) }
      kreise_map = kreise.map { |k| [[k.state_id, k.regierungsbezirk_id, k.kreis_id], k] }.to_h
      items.each do |item|
        next if item.is_a?(State)

        item.state = states.find { |s| s.state_id == item.state_id }

        next if item.is_a?(Regierungsbezirk)

        item.regierungsbezirk = rb.find do |s|
          s.regierungsbezirk_id == item.regierungsbezirk_id && item.state_id == s.state_id
        end

        next if item.is_a?(Kreis)

        item.kreis = kreise_map[[item.state_id, item.regierungsbezirk_id, item.kreis_id]]
      end
    end

    def items
      @items ||=
        begin
          sheet = @doc.sheets.drop_while { |i| i.name[/Inhalt|Deckblatt/i] }.first
          items = sheet.rows.drop(6).map { |i| HEADER.zip(i).to_h }
          items.reject! { |i| i[:satzart].to_i.to_s != i[:satzart] }
          items.map do |item|
            klass =
              if item[:regierungsbezirk_id].nil? && item[:gemeinde_id].nil? && item[:gemeindeverband_id].nil?
                State
              elsif item[:gemeinde_id].nil? && item[:regierungsbezirk_id] && item[:kreis_id].nil?
                Regierungsbezirk
              elsif item[:gemeinde_id].nil? && item[:gemeindeverband_id].nil?
                Kreis
              elsif item[:gemeinde_id].nil?
                Gemeindeverband
              else
                Gemeinde
              end
            klass.new(item)
          end
        end
    end
  end
end
