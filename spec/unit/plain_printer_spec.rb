require 'spec_helper'

describe Prissy::Printer do

  subject { Prissy::Printer.new.print(object) }

  describe "an empty object" do
    let(:object) { {} }
    it { should look_like '{}' }
  end

  describe "a simple object" do
    let(:object) { {"foo" => "bar"} }
    it { should look_like '{"foo": "bar"}' }
  end

  describe "an object with multiple keys" do
    let(:object) { {"foo" => "bar", "x" => "y" } }
    it { should look_like <<-STR.strip }
{
  "foo": "bar",
  "x":   "y"
}
STR
  end

  describe "an object with simple nested objects" do
    let(:object) { {"foo" => "bar", "other" => {"subkey" => "subvalue"}} }
    it { should look_like <<-STR.strip }
{
  "foo":   "bar",
  "other": {"subkey": "subvalue"}
}
STR
  end

  describe "an object with multiple nested objects" do
    let(:object) { {"foo" => "bar", "other" => {"a" => "b", "c" => "d"}} }
    it { should look_like <<-STR.strip }
{
  "foo":   "bar",
  "other": {
    "a": "b",
    "c": "d"
  }
}
STR
  end

  describe "an object with a short array" do
    let(:object) { {"stooges" => %w[Moe Larry Curly] } }
    it { should look_like <<-STR.strip }
{"stooges": ["Moe", "Larry", "Curly"]}
STR
  end

  describe "an object with a long array" do
    let(:object) { {"dwarves" => %w[ Fili Kili Oin Gloin Thorin Dwalin Balin Bifur Bofur Bombur Dori Nori Ori ]} }
    it { should look_like <<-STR.strip }
{"dwarves": [
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
]}
STR
  end

  describe "basic types" do
    let(:object) { {
      "string" => "string",
      "number" => 42.0,
      "object" => {"foo" => "bar"},
      "array"  => [1, 2, 3],
      "true"   => true,
      "false"  => false,
      "null"   => nil
    } }
    it { should look_like <<-STR.strip }
{
  "array":  [1, 2, 3],
  "false":  false,
  "null":   null,
  "number": 42.0,
  "object": {"foo": "bar"},
  "string": "string",
  "true":   true
}
STR
  end

end

