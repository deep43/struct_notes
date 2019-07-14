

#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

-keep class io.flutter.**  { *; }
-dontwarn  io.flutter.**
-keepclassmembers class io.flutter.**{*;}

-keepclassmembers class * implements java.io.Serializable {
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

-dontwarn  np.com.sarbagyastha.**
-dontwarn  com.benjaminabel.**

-keep class com.google.**  { *; }
-dontwarn  com.google.**

-keep class io.flutter.plugins.pathprovider.**  { *; }
-dontwarn  io.flutter.plugins.pathprovider.**
-keepclassmembers class io.flutter.plugins.pathprovider.**{*;}


-keep class io.flutter.plugins.share.**  { *; }
-dontwarn  io.flutter.plugins.share.**
-keepclassmembers class io.flutter.plugins.share.**{*;}


-keep class io.flutter.plugins.pathprovider.**  { *; }
-dontwarn  io.flutter.plugins.pathprovider.**
-keepclassmembers class io.flutter.plugins.pathprovider.**{*;}


-keep class com.tekartik.sqflite.**  { *; }
-dontwarn  com.tekartik.sqflite.**
-keepclassmembers class com.tekartik.sqflite.**{*;}


-keep class kotlin.**  { *; }
-dontwarn  kotlin.**
-keepclassmembers class kotlin.**{*;}

-keep class com.benjaminabel.vibration.**  { *; }
-dontwarn  com.benjaminabel.vibration.**
-keepclassmembers class com.benjaminabel.vibration.**{*;}


-keep class np.com.sarbagyastha.youtubeplayer.**  { *; }
-dontwarn  np.com.sarbagyastha.youtubeplayer.**
-keepclassmembers class np.com.sarbagyastha.youtubeplayer.**{*;}

-keep class at.huber.youtubeExtractor.VideoMeta.**  { *; }
-dontwarn  at.huber.youtubeExtractor.VideoMeta.**
-keepclassmembers class at.huber.youtubeExtractor.VideoMeta.**{*;}

-keep class com.google.**{*;}
-keepclassmembers class com.google.**{*;}
-keepclassmembers class * implements java.io.Serializable { *; } #or -keep class com.baseflow.permissionhandler.** { *; }

-optimizations !code/simplification/variable

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Fragment
-keep public class * extends android.support.v4.app.Fragment

# The Maps API uses custom Parcelables.
# Use this rule (which is slightly broader than the standard recommended one)
# to avoid obfuscating them.
-keepclassmembers class * implements android.os.Parcelable {
    static *** CREATOR;
}

# The Maps API uses serialization.
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}


-keepnames class com.transistorsoft.flutter.backgroundgeolocation.FLTBackgroundGeolocationPlugin
-keepnames class io.flutter.app.FlutterActivity

# BackgroundGeolocation lib tslocationmanager.aar is *already* proguarded
-keep class com.transistorsoft.** { *; }
-dontwarn com.transistorsoft.**

# BackgroundGeolocation (EventBus)
-keepattributes *Annotation*
