# encoding: utf-8

require "bundler/setup"

# require your gems as usual
require "tapp"
require "yaml"

#--------------------------------------#
module Closed

  class Setting

    def self.default
      [
        {
          shop: "郵便局",
          closed: [ type: "毎週", weekday: ["土", "日"], day: [] ]
        },
        {
          shop: "床屋",
          closed: [
                    { type: "毎週", weekday: ["月"], day: [] },
                    { type: "第三", weekday: ["日"], day: [] }
                  ]
        },
        {
          shop: "近所の肉屋",
          closed: [
                    { type: "特定", weekday: [], day: [1, 5, 10] },
                    { type: "祝日", weekday: [], day: [] }
                  ]
        }
      ]
    end

    def self.init
      @@path = nil
      @@yaml = nil
    end

    def self.path
      @@path ||= "test.yml"
    end

    def self.path=(path)
      @@path = path
    end

    def self.yaml
      @@yaml ||= self.default
    end

    def self.get
      @@yaml = self.default
      if File.exists? self.path
        begin
          File.open self.path do |f|
            YAML.load_documents(f) do |yaml|
              @@yaml = yaml
            end
          end
        rescue => e
          STDERR.puts e
        end
      end
    end

  end

end
