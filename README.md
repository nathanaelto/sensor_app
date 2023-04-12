# sensor_app

A new Flutter project for monoring of iot temperature sensor.

## Getting Started

Add this lines in `android/app/main/AndroidManifest.xml` at the end of the file :warning: IF IT IS NOT ALREADY PRESENT !
```xml
<manifest>
    //...
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
</manifest>
```

And add in `android/local.properties` 
```
flutter.minSdkVersion=21
flutter.targetSdkVersion=30
```


