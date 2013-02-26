require "bundler/setup"

# require your gems as usual
require "tapp"
require "date"
require "hashie"
require "optparse/date"

Dir[File.join(File.dirname(__FILE__), "./lib", "*.rb")].each do |f|
  require f
end

#--------------------------------------#

module Closed

  class Main

    def initialize

    end

    def self.path
      @path ||= Closed::Setting.path
    end

    def self.path=(path)
      @path = path
    end

    def get(date = Date.today)
      closed = []
      Closed::Setting.path = @path
      Closed::Setting.get
      Closed::Setting.yaml.each do |e|
        has = Hashie::Mash.new e
        closed << has if Closed::Data.closed? has, date
      end
      closed
    end

    def closed(date = Date.today)
      closed = get date
      puts "----- #{date} closed -----"
      closed.each do |e|
        puts e[:shop]
      end
    end

  end

end

#--------------------------------------#
def opt_parse
  opthash = {}
  OptionParser.new do |opt|

    begin
      opt.on('-f configfile') {|v| opthash[:f] = v }
      opt.on('-d [date]', Date) {|v| opthash[:d] = v }
      opt.parse!(ARGV)
    rescue => e
      puts e
      exit 1
    end

  end
  opthash
end

opt = opt_parse
date = opt[:d] || Date.today
Closed::Main.path = opt[:f] if opt.key?(:f)
Closed::Main.new.closed date
