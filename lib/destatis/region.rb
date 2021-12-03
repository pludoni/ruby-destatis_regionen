module Destatis
  class Region
    class << self
      attr_accessor :all

      %i[map select reject group_by first last take drop].each do |m|
        define_method(m) do
          all.send(m)
        end
      end

    end

    def self.[](search)
      all.find { |item| item.gemeinde_name == search } ||
        all.find { |item| item.gemeinde_name.downcase[search.downcase] }
    end

    attr_reader :flaeche, :lat, :lon, :bevoelkerung_km2, :bevoelkerung_insgesamt, :bevoelkerung_m, :bevoelkerung_w
    attr_accessor :satzart, :textkennzeichen, :state_id, :gemeinde_name, :gemeinde_plz,
                  :kreis, :state, :regierungsbezirk,
                  :reisegebiet_name, :verstaedtung_name

    def inspect
      vars = %w[kreis_id state_id regierungsbezirk_id]
        .select { |k| respond_to?(k) }
        .map { |v| "#{v}=#{send(v)}" }
        .join(', ')
      "<#{self.class.name} '#{gemeinde_name}' #{vars}>"
    end

    def lat=(other)
      @lat = other.sub(',', '.').to_f if other
    end

    def lon=(other)
      @lat = other.sub(',', '.').to_f if other
    end

    def flaeche=(other)
      @flaeche = other.to_f if other
    end

    def bevoelkerung_insgesamt=(other)
      @bevoelkerung_insgesamt = other.to_i if other
    end

    def bevoelkerung_m=(other)
      @bevoelkerung_m = other.to_i if other
    end

    def bevoelkerung_w=(other)
      @bevoelkerung_w = other.to_i if other
    end

    def bevoelkerung_km2=(other)
      @bevoelkerung_km2 = other.to_i if other
    end

    def as_json(_opts = {})
      (instance_variables - %i[@kreis @state @regierungsbezirk]).map { |key| [key.to_s.sub(/^@/, ''), instance_variable_get(key)] }.to_h.
        merge("class" => self.class.to_s)
    end

    def initialize(args)
      args.each do |key, value|
        send("#{key}=", value) if respond_to?(key)
      end
    end
  end
end
