require 'nokogiri'
require 'csv'

def generate_comments(filenames,csvwriter)
  
  filenames.each {|a|
    
    puts "processing: #{a}"

    #open tests
    doc = Nokogiri::XML(File.open(a).read)

    doc.root.children.each do |node|
      next if node.is_a?(Nokogiri::XML::Text)
      action = node.name
      comment = node.attributes["comment"]
      csvwriter << [a, action, comment]
    end

}

end

# create header of csv file
CSV.open('comments_doc.csv', 'w') do |writer|
  writer << ['filename', 'action', 'comment']
  # call generate comments function
  generate_comments(ARGV,writer)
end
