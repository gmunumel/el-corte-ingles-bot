class NoSuchElementError < Exception
end

class ConsoleDiscount

  def self.check
    browser = Selenium::WebDriver.for :firefox
    browser.get 'https://www.elcorteingles.es/videojuegos/nintendo-2ds-3ds/consolas/?level=6'

    wait = Selenium::WebDriver::Wait.new(timeout: 15)
     
    # Check that the table with the given class is displayed
    table = wait.until {
        element = browser.find_element(id: 'rr-container')
        element if element.displayed?
    }
    return unless table

    begin 
      # Iterate through all products of the table
      xpathProduct = "//*[@id='rr-container']/ul/li"
      count = browser.find_elements(xpath: xpathProduct).size()
      detail = "<h2>Number of Product nodes with discount: #{count}</h2>"
      detail += "<br/>"
    
      count.times do |i|
        # xpathProductBrand = "//*[@id='rr-container']/ul/li[#{i + 1}]/div/div[2]/div[1]/h4"
        # productBrand = browser.find_element(xpath: xpathProductBrand)
        # puts "Brand Name: #{productBrand.text}" if productBrand
        
        xpathProductName = "//*[@id='rr-container']/ul/li[#{i + 1}]/div/div[2]/div[1]/h3/a[1]"
        productName = browser.find_element(xpath: xpathProductName)
        detail += "<span>Product Name: #{productName.text} || " if productName

        xpathProductDiscount = "//*[@id='rr-container']/ul/li[#{i + 1}]/div/div[2]/div[2]/span[3]"
        productDiscount = browser.find_element(xpath: xpathProductDiscount)
        detail += "Product Discount: #{productDiscount.text}</span>" if productDiscount
        detail += "<br/>"
      end

    rescue NoSuchElementError => e
      puts "Error: #{e}"
    ensure
      browser.quit
    end

    if count > 0
      # return if Product.last.text.eql? detail
      Product.create(name: '', brand: 'nintendo', category: 'videos games - console', text: detail)
      NotificationMailer.mailer(detail).deliver_later
    end

  end
end