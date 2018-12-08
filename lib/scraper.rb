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
    html = Nokogiri::HTML(open(profile_url))
    scraped_students= {}

    html.css('div.profile-quote').each do |quote|
      scraped_students[:profile_quote] = quote.text
    end

    html.css('div.social-icon-container').each do |info|
      info.css('a').each do |link|
        if link.attr('href').include?('github')
          scraped_students[:github] = link.attr('href')
        elsif link.attr('href').include?('linkedin')
          scraped_students[:linkedin] = link.attr('href')
        elsif link.attr('href').include?('twitter')
          scraped_students[:twitter] = link.attr('href')
        else
          scraped_students[:blog] = link.attr('href')
        end
      end
    end

    html.css('div.description-holder').each do |about|
      if about.css('p').text != ''
      scraped_students[:bio] = about.css('p').text
      end
    end


    scraped_students
  end

end
