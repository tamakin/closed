# encoding: utf-8

require "bundler/setup"

# require your gems as usual
require "tapp"
require "date"
require 'holiday_japan'
require "hashie"

require_relative "setting"

#--------------------------------------#
module Closed

  class Data

    def self.yaml
      @@yaml ||= Closed::Setting.default
    end

    def self.set=(yaml)
      @@yaml = yaml
    end

    def self.closed?(hash, date = Date.today)

      hash[:closed].each { |e|

        return true if case e[:type]
        when "毎週"
          weekday_hit?(:every, e[:weekday], date)
        when "第一", "第二", "第三", "第四"
          weekday_hit?(e[:type], e[:weekday], date)
        when "祝日"
          holiday_hit?(date)
        when "特定"
          specialday_hit?(e[:day], date)
        else
          false
        end

      }
      false

    end

    def self.weekday_hit?(type, weekday, date = Date.today)
      hit = false
      weekday.each do |e|
        hit = weekhash[e] == date.cwday ? true : false
        break if hit
      end
      return hit if type == :every
      return false unless typehash.has_key? type
      return date.mwday == typehash[type] ? true : false
    end

    def self.holiday_hit?(date = Date.today)
      return HolidayJapan.check(date) ? true : false
    end

    def self.specialday_hit?(day, date = Date.today)
      hit = false
      day.each do |e|
        hit = e.to_i == date.day ? true : false
        break if hit
      end
      hit
    end

    private
    def self.weekhash
      { "日" => 7, "月" => 1, "火" => 2, "水" => 3, "木" => 4, "金" => 5, "土" => 6 }
    end
    def self.typehash
      { "第一" => 1, "第二" => 2, "第三" => 3, "第四" => 4 }
    end

  end

end
