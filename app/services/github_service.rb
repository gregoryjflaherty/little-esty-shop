require 'httparty'
require 'pry'

class GitHubService

  def get_body
    response = HTTParty.get('https://api.github.com/repos/gregoryjflaherty/little-esty-shop/pulls', query: {state: 'all'} )
    parsed = JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end
end

service = GitHubService.new
service.get_body
