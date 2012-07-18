# What's Your News!
Application for What's Your News TV show aimed at kids 5-12 years old, to be released at CBC events in mid July, 2012.

### Goals are:
* Whack-a-mole style game to begin the app
* Get audio and image from user, save to disk
* Song mixer which uses provided samples and recorded components

### Hardware/Software Requirements:
* iOS 3-5
* iPad 2/3 and iPhone 3GS/4/4S
* Retina/Non-Retina Display

### Any 3rd Party Components/Custom Re-writes:
* Cocos2D
* Updated to Cocos2D 1.1 after 1.0 build
* CDAudioManager class in cocosDenshion was overwritten to add up to 5 audio channels (default is 2)
* **Not Needed With Cocos2d 1.1** -Replaced lines 212 & 213 of CCDirectorIOS.m to the following to fix black screen issue on iPad Retina-             
> if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad &&
                [[UIScreen mainScreen] scale] > 1.0 ) { gluPerspective(60, (GLfloat)size.width/size.height, zeye-size.height/2, zeye+size.height/2 ); } else { gluPerspective(60, (GLfloat)size.width/size.height, 0.5f, 1500); }
