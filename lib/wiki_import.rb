require_relative 'wiki_handler'

class WikiImport < Nokogiri::XML::SAX::Document
  
  include WikiHandler
  
  # A stack (Array) of attributes as we find them 
  attr_accessor :attribute_stack
  
  # A logger to output to the screen
  attr_accessor :logger
  
  # A counter to increment each time you find a page
  attr_accessor :page_count
  
  # The output SQL file
  attr_accessor :sql
  
  # The contents of the last page as a hash
  attr_accessor :last_page
  
  # The text contents of last element's body 
  attr_accessor :last_body
  
  def initialize(logger)
    self.logger = logger
    self.attribute_stack = Array.new
    self.page_count = 0
    self.last_page = {}
    self.last_body = ""
    @output_file_count = 0
    @title = ""
    @body = ""
    
  end
  
  def start_document
    logger.debug "Start document"
    @sql = File.open('data/mdstuff.sql', 'w')
  end
  
  def end_document
    logger.debug "End document"
    @sql.close
    
  end

  def start_element(name, attrs)
    #logger.debug "Found element #{name}"
    case name
    when "title"
      @titleint = true
      #logger.debug "Found element title"
    when "text"
      @bodyint = true
      #logger.debug "Found element body"
    else
      @titleint = false
      @bodyint = false
    end 


  end
  
  def characters(c)

    @title = @title + c if @titleint 
    @body = @body + c if @bodyint
  end
  
  def end_element(name)

    if name == "page"
      puts @title
      
      @sql << "INSERT INTO articles(title, body, created_at, updated_at) VALUES('#{clean @title}', '#{clean @body}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);" 

      @title = ""
      @body = "" 
      #self.last_page[:title] = self.last_body
    end 
  end
  
  def method_missing(m, *args, &block)
    logger.debug("Ignoring #{m}")
  end
  
  protected
  def handler_method(name)
    :"handle_#{name.downcase}"
  end
  
  def clean(s)
    s.strip.gsub("'", "''")
  end
  
  def output_file_name
    "/tmp/articles-#{@output_file_count}.sql"
  end  
end
