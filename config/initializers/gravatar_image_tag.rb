# config/initializers/gravatar_image_tag.rb
GravatarImageTag.configure do |config|
  config.default_image = 'http://github.com/images/gravatars/gravatar-80.png'   # Set this to use your own default gravatar image rather then serving up Gravatar's default image [ 'http://example.com/images/default_gravitar.jpg', :identicon, :monsterid, :wavatar, 404 ].
  config.filetype      = nil   # Set this if you require a specific image file format ['gif', 'jpg' or 'png'].  Gravatar's default is png
  config.rating        = nil   # Set this if you change the rating of the images that will be returned ['G', 'PG', 'R', 'X']. Gravatar's default is G
  config.size          = 32   # Set this to globally set the size of the gravatar image returned (1..512). Gravatar's default is 80
  config.secure        = false # Set this to true if you require secure images on your pages.
end