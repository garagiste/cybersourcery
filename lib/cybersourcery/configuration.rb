module Cybersourcery
  class Configuration
    attr_accessor :profiles_path, :sop_proxy_url, :sop_live_url, :sop_test_url

    def profiles
      @profiles ||= YAML.load(ERB.new(File.read(profiles_path)).result)
    end
  end
end
