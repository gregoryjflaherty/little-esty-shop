require 'httparty'
require 'pry'

class GitHubService
  response = HTTParty.get('https://api.github.com/repos/gregoryjflaherty/little-esty-shop')
  parsed = JSON.parse(response.body, symbolize_names: true)
  binding.pry
end
