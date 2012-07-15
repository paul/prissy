require 'spec_helper'

describe Prissy::Obj do

  subject { Prissy::Obj.new(object).to_string }

  describe "a string" do
    let(:object) { "Paul Sadauskas" }
    it { should == '"Paul Sadauskas"' }
  end

  describe "a number" do
    let(:object) { 42 }
    it { should == '42' }
  end

  describe "a short array" do
    let(:object) { %w[ Moe Larry Curly ] }
    it { should == '["Moe", "Larry", "Curly"]' }
  end

  describe "a long (>80 char default) array" do
    let(:object) { %w[ Fili Kili Oin Gloin Thorin Dwalin Balin Bifur Bofur Bombur Dori Nori Ori ] }
    it { should == <<-STR.strip }
[
  "Fili",
  "Kili",
  "Oin",
  "Gloin",
  "Thorin",
  "Dwalin",
  "Balin",
  "Bifur",
  "Bofur",
  "Bombur",
  "Dori",
  "Nori",
  "Ori"
]
STR

  end
end

