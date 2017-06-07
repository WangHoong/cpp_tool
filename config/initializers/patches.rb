# include all lib extensions
Dir[Rails.root.join('lib/ext/**/*.rb')].each {|file| require file }