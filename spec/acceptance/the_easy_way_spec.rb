require 'spec_helper'

describe Prissy, "the easy way" do
  let(:json) { <<-JSON }
     {
      "Image": {
          "Width":  800,
          "Height": 600,
          "Title":  "View from 15th Floor",
          "Thumbnail": {
              "Url":    "http://www.example.com/image/481989943",
              "Height": 125,
              "Width":  "100"
          },
          "IDs": [116, 943, 234, 38793]
        }
   }
  JSON

  subject { Prissy(json) }

  it { should look_like(<<-JSON)
    {
      "Image": {
	"Width":  800,
	"Height": 600,
	"Title":  "View from 15th Floor",
	"Thumbnail": {
	  "Url":    "http://www.example.com/image/481989943",
	  "Height": 125,
	  "Width":  "100"
	},
	"IDs": [116, 943, 234, 38793]
      }
    }
  JSON
  }
end

