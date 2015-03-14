require 'open-uri'
require 'json'

class RecipeFetcher
  URL = 'http://www.recipepuppy.com/api/?p='

  attr_accessor :page

  def initialize(page = 0)
    @page = page
  end

  def self.call(page = 0)
    new(page).call
  end

  def call
    fetch
  end

  private

  def fetch
    result = []
    while(page < 3)
      self.page += 1
      url = URL + page.to_s
      result += JSON.parse(open(url).read)['results']
    end
    result
  end
end

