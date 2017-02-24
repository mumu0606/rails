#coding:utf-8
=begin
require 'json'
require 'yaml'

def translate_file
  #party_info_json = JSON.load("party_infos.json")

  File.open("party_infos.json") do |io|
  party_info_json = JSON.load(io)
    File.open("party_infos.yaml","a") do |f|
      party_info_json.each do |party|
        party_member_info = party["party_member_infos"]
        party_hash = {}
        party_member_info.each do |member|
          poke_hash = {}
          name = member["name"]
          poke_hash["item"] = member["item"]
          poke_hash["move1"] = member["move"][0]
          poke_hash["move2"] = member["move"][1]
          poke_hash["move3"] = member["move"][2]
          poke_hash["move4"] = member["move"][3]
          party_hash[name] = poke_hash
        end
        f.write(party_hash.to_yaml)
      end
    end
  end
end

translate_file
=end