# encoding: utf-8

# -*- coding: utf-8 -*-
require 'spec_helper'

describe Closed::Setting do

  describe "#default" do

    before {
      Closed::Setting.init
      @setting = Closed::Setting.default
    }
    context "要素が3個ある" do
      subject { @setting.size }
      it { should == 3 }
    end

  end

  describe "#yaml" do

    before { @default = Closed::Setting.default }
    context "初期値はdefalutである" do
      subject { Closed::Setting.yaml }
      it { should == @default }
    end

  end

  describe "#path" do

    before { @path = Closed::Setting.path }
    context "初期値はtest.ymlである" do
      subject { @path }
      it { should == "test.yml" }
    end

    after { @path = Closed::Setting.path = "a.yml" }
    context "a.ymlをセットしたらa.ymlである" do
      subject { @path }
      it { should == "a.yml" }
    end

  end

  describe "#get" do

    before { @default = Closed::Setting.default }
    context "存在しないファイルを指定したらdefaultを返す" do
      subject {
        Closed::Setting.path = "aaa.yml"
        Closed::Setting.get
        Closed::Setting.yaml
      }
      it { should == @default }
    end

    describe "test.ymlであれば" do
      before {
        Closed::Setting.path = "test.yml"
        Closed::Setting.get
        @yml = Closed::Setting.yaml
      }
      context "要素が4個ある" do
        subject { @yml.size }
        it { should == 4 }
      end
    end

  end




end
