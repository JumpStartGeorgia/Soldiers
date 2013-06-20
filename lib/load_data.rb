module LoadData
	require 'net/http'
	require 'net/https'

  #en = https://spreadsheets.google.com/feeds/list/0AtUyMZoeaZt8dGh5SF9CX1ZKZ0JTXzNKbUhwclNudVE/od6/public/values?alt=json
  #ka = https://spreadsheets.google.com/feeds/list/0AtUyMZoeaZt8dGh5SF9CX1ZKZ0JTXzNKbUhwclNudVE/1/public/values?alt=json

  def self.google_spreadsheet_json_multi_lang()
    en_url = "https://spreadsheets.google.com/feeds/list/0AtUyMZoeaZt8dGh5SF9CX1ZKZ0JTXzNKbUhwclNudVE/od6/public/values?alt=json"
    ka_url = "https://spreadsheets.google.com/feeds/list/0AtUyMZoeaZt8dGh5SF9CX1ZKZ0JTXzNKbUhwclNudVE/1/public/values?alt=json"
    
puts 'getting en'
    en_json = format_data(en_url)
puts 'getting ka'
    ka_json = format_data(ka_url)

    if en_json.present? && ka_json.present?
puts 'creating records'
      Soldier.load_from_json(en_json, ka_json)
    end

    return nil
  end


protected

  def self.format_data(url)
    formatted_json = []

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    json = response.body
    if json.present?
      # format the json into the format we need
      json_data = JSON.parse(json)["feed"]["entry"]
      json_data.each do |j|
        h = Hash.new
        formatted_json << h
        h["id"] = j["gsx$id"]["$t"].present? ? j["gsx$id"]["$t"] : nil
        h["first_name"] = j["gsx$firstname"]["$t"].present? ? j["gsx$firstname"]["$t"] : nil
        h["last_name"] = j["gsx$lastname"]["$t"].present? ? j["gsx$lastname"]["$t"] : nil
        h["rank"] = j["gsx$rank"]["$t"].present? ? j["gsx$rank"]["$t"] : nil
        h["country_died"] = j["gsx$country"]["$t"].present? ? j["gsx$country"]["$t"] : nil
        h["place_died"] = j["gsx$placeofdeath"]["$t"].present? ? j["gsx$placeofdeath"]["$t"] : nil
        h["incident_type"] = j["gsx$incidenttype"]["$t"].present? ? j["gsx$incidenttype"]["$t"] : nil
        h["incident_description"] = j["gsx$incidentdescription"]["$t"].present? ? j["gsx$incidentdescription"]["$t"] : nil
        h["died_at"] = j["gsx$dateofdeath"]["$t"].present? ? Date.strptime(j["gsx$dateofdeath"]["$t"], '%m/%d/%Y') : nil
        h["born_at"] = j["gsx$dateofbirth"]["$t"].present? ? j["gsx$dateofbirth"]["$t"] : nil
        h["age"] = j["gsx$age"]["$t"].present? ? j["gsx$age"]["$t"] : nil
        h["from"] = j["gsx$from"]["$t"].present? ? j["gsx$from"]["$t"] : nil
        h["served_with"] = j["gsx$servedwith"]["$t"].present? ? j["gsx$servedwith"]["$t"] : nil
      end
    end  
    return formatted_json
  end

end

