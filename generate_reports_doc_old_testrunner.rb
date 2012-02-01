require 'nokogiri'
require 'csv'

def generate_reports(filenames,csvwriter)

  filenames.each {|a|

    puts "processing: #{a}"

    # open tests
    doc = Nokogiri::XML(File.open(a).read)

    # extract test attributes
    title = doc.search('test').attr('title')
    regression = doc.search('test').attr('regression')
    category = doc.search('test').attr('category')
    ignore = doc.search('test').attr('ignore')

    # write attributes to csv file
    csvwriter << [category, title, a, regression, ignore]
  }

end

# create header of csv file
CSV.open('reports_doc.csv', 'w') do |writer|
  writer << ['category', 'scenario', 'filename', 'regression', 'ignore']
  # call generate reports function
  generate_reports(ARGV,writer)
end
