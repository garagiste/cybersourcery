module Cybersourcery
  class CybersourceParamsNormalizer
    def self.run(params)
      params.to_h.keys.each do |key|
        params[key[4..-1]] = params[key] if key =~ /^req_/
      end
      params
    end
  end
end
