# ``InsiderSDKTaskFramework``

Thanks to SkyView, you will be able to see how many stars there are in the sky.
Moreover, you can use it with only one function.

## Overview

You should add SkyView your screen and only call **skyView.addStarInterface** 


If user gives a non-nil value of StarSize as type parameter, (if there is more place) SDK adds in Sky.
- Parameters:
 - type: The size of star wanted to add to sky, if nil will remove all star from sky.
   
public func addStarInterface(type: StarSize?) 


### Background Works
SkyManager class manage all proccess, SkyView class just prepare view. SkyView has only one more job, that is forward "addStarInterface" function to its manager.
Star class just see about stars members and conforming "Codable". 
