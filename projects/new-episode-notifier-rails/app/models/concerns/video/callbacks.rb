class Video::Callbacks

  class << self

    def after_create(video)
      after_create_create_scrape(video)
    end
    
    def after_create_create_scrape(video)
      Scrape.create!(video:)
    end
  end
end