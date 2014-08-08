WildKingdom
===========

##Auto Layout & Constraints - Minimum Viable Product

- As a user, I want to use the Flickr API to access the first 10 photos of lions and tigers and bears from the Flickr Creative Commons

 - Setup a Flickr API key
 - Connect to the Flickr API through a url connection
 
- As a user, I want to display the images returned from Flickr in a two column grid layout
  - Use a UICollectionView for the grid
  - Create a custom UICollectionVewCell for image display

- As a user, I want to tab between the lion, tiger, and bear image types
  - Create a UITabBarController with 3 tabs
  - Each tab should contain either an instance of a ViewController or separate ViewControllers, one for each type of image
  - The preference is to use one ViewController type

- As a user, I want to be able to rotate the device and have the layout change to a single roll of images that can be horizontally scrolled
  - Using a combination of constraints / auto-layout and code, adjust the metrics of the UICollectionView when the the ViewController detects that the device has rotated
  - Resize the UICollectionView and re-orient the scrollDirection

------------
##Auto Layout & Constraints - Stretch Goals

- Wild Kingdom - Stretch One
  - As a user, I want to see where the photo was taken on a map
   - The map should be displayed in a full screen

- Wild Kingdom - Stretch Two
  - As a user, I want to view more information about the photo
   - Tapping the image should flip it around and display more information

- Wild Kingdom - Stretch Three
 - As a user, I want to browse other artwork by the photographer who took this picture
  -No engineering tasks

- Wild Kingdom - Stretch Four
 - As a user, I want to see an overlay of interesting information about the images when the image is tapped
  - The overlay should take up the lower 1/4 of the image and have a gradient from black to clear
  - Something like this… http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/pictures/1/content_8236eebc-8aa3-4fc7-b832-71df8fa7a4d0.tiff
