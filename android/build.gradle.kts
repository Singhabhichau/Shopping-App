import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.0.0")
        classpath("com.google.gms:google-services:4.4.1") // ✅ Firebase plugin
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}


