# encoding: utf-8

# -*- coding: utf-8 -*-
require 'spec_helper'

describe Closed::Main do

  describe "#path" do

    before { @path = Closed::Main.path }
    context "初期値はtest.ymlである" do
      subject { @path }
      it { should == Closed::Setting.path }
    end

    after { @path = Closed::Main.path = "a.yml" }
    context "a.ymlをセットしたらa.ymlである" do
      subject { @path }
      it { should == "a.yml" }
    end

  end

  describe "#get" do

    before {
      Closed::Main.path = Closed::Setting.path
      @main = Closed::Main.new
      @result = @main.get Date.new(2013, 2, 24)
    }
    context "test.yml：2013/02/24" do
      subject { @result[0]["shop"] }
      it { should == "郵便局" }
    end

  end

end
