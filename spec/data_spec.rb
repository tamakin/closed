# encoding: utf-8

# -*- coding: utf-8 -*-
require 'spec_helper'

describe Closed::Data do

  describe "#yaml" do

    before { @default = Closed::Setting.default }
    context "初期値はdefalutである" do
      subject { Closed::Data.yaml }
      it { should == @default }
    end

  end

  describe "#weekday_hit?" do

    # 毎週
    before { }
    context "毎週：土,日：2013/02/16" do
      subject {
        @result = Closed::Data.weekday_hit?(:every, %w(土 日), Date.new(2013, 2, 16))
      }
      it { should be_true }
    end

    context "毎週：土,日：2013/02/17" do
      subject {
        @result = Closed::Data.weekday_hit?(:every, %w(土 日), Date.new(2013, 2, 17))
      }
      it { should be_true }
    end

    context "毎週：土,日：2013/02/18" do
      subject {
        @result = Closed::Data.weekday_hit?(:every, %w(土 日), Date.new(2013, 2, 18))
      }
      it { should be_false }
    end

    context "毎週：土,日：2013/02/24" do
      subject {
        @result = Closed::Data.weekday_hit?(:every, %w(土 日), Date.new(2013, 2, 24))
      }
      it { should be_true }
    end

    # 第一～第四
    context "うんこ：土,日：2013/02/2" do
      subject {
        @result = Closed::Data.weekday_hit?("うんこ", %w(土 日), Date.new(2013, 2, 2))
      }
      it { should be_false }
    end

    context "第一：土,日：2013/02/2" do
      subject {
        @result = Closed::Data.weekday_hit?("第一", %w(土 日), Date.new(2013, 2, 2))
      }
      it { should be_true }
    end

    context "第一：土,日：2013/02/3" do
      subject {
        @result = Closed::Data.weekday_hit?("第一", %w(土 日), Date.new(2013, 2, 3))
      }
      it { should be_true }
    end

    context "第三：月：2013/02/11" do
      subject {
        @result = Closed::Data.weekday_hit?("第三", %w(土 日), Date.new(2013, 2, 11))
      }
      it { should be_false }
    end

    context "第三：月：2013/02/18" do
      subject {
        @result = Closed::Data.weekday_hit?("第三", %w(土 日), Date.new(2013, 2, 18))
      }
      it { should be_true }
    end

    # 祝日
    context "祝日：2013/02/2" do
      subject {
        @result = Closed::Data.holiday_hit?(Date.new(2013, 2, 2))
      }
      it { should be_false }
    end

    context "祝日：2013/02/11" do
      subject {
        @result = Closed::Data.holiday_hit?(Date.new(2013, 2, 11))
      }
      it { should be_true }
    end

    # 特別
    context "特定：%w(1 5 10)：2013/02/2" do
      subject {
        @result = Closed::Data.specialday_hit?(%w(1 5 10), Date.new(2013, 2, 2))
      }
      it { should be_false }
    end

    context "特定：%w(1 5 10)：2013/02/10" do
      subject {
        @result = Closed::Data.specialday_hit?(%w(1 5 10), Date.new(2013, 2, 10))
      }
      it { should be_true }
    end

  end

  describe "#closed?" do

    before {
      @default = Closed::Setting.default
      @hash1 = @default[0]
      @hash2 = @default[1]
      @hash3 = @default[2]
    }
    context "郵便局：毎週：土, 日：2013/02/17" do
      subject { Closed::Data.closed?(@hash1, Date.new(2013, 2, 17)) }
      it { should be_true }
    end

    context "郵便局：毎週：土, 日：2013/02/18" do
      subject { Closed::Data.closed?(@hash1, Date.new(2013, 2, 18)) }
      it { should be_false }
    end


    context "床屋：毎週：月, 第三：日：2013/02/11" do
      subject { Closed::Data.closed?(@hash2, Date.new(2013, 2, 11)) }
      it { should be_true }
    end

    context "床屋：毎週：月, 第三：日：2013/02/17" do
      subject { Closed::Data.closed?(@hash2, Date.new(2013, 2, 17)) }
      it { should be_true }
    end

    context "床屋：毎週：月, 第三：日：2013/02/24" do
      subject { Closed::Data.closed?(@hash2, Date.new(2013, 2, 24)) }
      it { should be_false }
    end


    context "近所の肉屋：特定：[1, 5, 10], 祝日：2013/02/5" do
      subject { Closed::Data.closed?(@hash3, Date.new(2013, 2, 5)) }
      it { should be_true }
    end

    context "近所の肉屋：特定：[1, 5, 10], 祝日：2013/02/10" do
      subject { Closed::Data.closed?(@hash3, Date.new(2013, 2, 10)) }
      it { should be_true }
    end

    context "近所の肉屋：特定：[1, 5, 10], 祝日：2013/02/11" do
      subject { Closed::Data.closed?(@hash3, Date.new(2013, 2, 11)) }
      it { should be_true }
    end

    context "近所の肉屋：特定：[1, 5, 10], 祝日：2013/02/12" do
      subject { Closed::Data.closed?(@hash3, Date.new(2013, 2, 12)) }
      it { should be_false }
    end

  end


end
