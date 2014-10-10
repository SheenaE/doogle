require 'open-uri'

class Word < ActiveRecord::Base
  has_many :definitions, dependent: :destroy
  before_save { self.name = name.downcase }

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  def self.search(search)
    if search
      result = Word.find_by_name(search.downcase)
      if !result
		file_handle = open("http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{search}?key=" + Rails.configuration.dictionary_api_key)
      	entry = Nokogiri::XML(file_handle)
      	definitions = entry.xpath("//dt")
      	if definitions.empty?
      		nil
      	else
      	  result = Word.add_new_word(search, definitions)
      	end
      end
      result
    end
  end

  def self.add_new_word(word, definitions)
    new_word = Word.create(name: word)
    definitions.each do |definition|
      definition = definition.to_s.gsub("<dt>:","")
      definition = definition.gsub("<dt> :","") 
      definition = definition.gsub(":</dt>","") 
      definition = definition.gsub("</dt>","")  
      new_word.definitions.create(content: definition)
    end
    return new_word
  end
end
