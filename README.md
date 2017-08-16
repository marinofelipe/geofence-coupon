# geofence-coupon
Simple Coursera course app which adds custom locations for simulator and send notifications when user enters a region

### Simulating Locations
Create a GPX file with the route to be simulated.
You can access [GPX-POI](http://gpx-poi.com) **_OR_** use the basic .gpx files sintax as shown below

#### GPX files sintax
```
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<gpx
xmlns="http://www.topografix.com/GPX/1/1"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd"
version="1.1" 
creator="gpx-poi.com">
   <wpt lat="53.343147" lon="-6.275468">
      <time>2017-08-16T00:27:21Z</time>
   </wpt>
</gpx>
```

It's only necessary to add more ```wpt``` itens and change the disered location and time

### Using on Xcode
On debugging options, after running your app on simulator, you must select **Simulate Location > Add GPX File to Project...**
Import your gpx file and then just run again _**OR**_ select the main scheme and then **Edit Scheme...Run > Options**, check the item **Allow Location Simulation** and define your gpx file on **Default Location**.
