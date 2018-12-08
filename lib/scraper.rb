require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = []

    html.css('div.roster-cards-container').each do |card|
      card.css('.student-card a').each do |student|
        student_url = student.attr('href') #url
        location = student.css('.student-location').text #location
        name = student.css('.student-name').text #name
    students << {
      name:name,
      location: location,
      profile_url: student_url
    }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
