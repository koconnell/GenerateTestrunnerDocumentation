require 'nokogiri'
require 'csv'

def generate_reports(filenames,csvwriter)

  filenames.each {|a|

    puts "processing: #{a}"

    # open tests
    doc = Nokogiri::XML(File.open(a).read)

    # extract test attributes
    feature = doc.search('feature').attr('value')
    title = doc.search('test').attr('title') 
    featureID = doc.search('test').attr('featureID')
    regression = doc.search('test').attr('regression')
    category = doc.search('test').attr('category')

    # write attributes to csv file
    csvwriter << [category, featureID, feature, title, a, regression]
  }

end

# create header of csv file
CSV.open('reports_doc.csv', 'w') do |writer|
  writer << ['category', 'featureID', 'feature', 'scenario', 'filename', 'regression']
  # call generate reports function
  generate_reports(ARGV,writer)
end
