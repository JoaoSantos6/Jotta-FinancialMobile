plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.jotta.financial"
    // Literal, não flutter.compileSdkVersion: flutter_secure_storage 11.0.0 exige
    // compileSdk 37+ (descoberto rodando de verdade no Actions do GitHub — o
    // Flutter 3.47.2 ainda resolve flutter.compileSdkVersion para 36). Mesma lógica
    // do minSdk logo abaixo: o padrão do Flutter muda de versão para versão sem
    // aviso no nosso changelog.
    compileSdk = 37
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // Identidade definitiva do app (docs/DECISIONS.md). NUNCA mudar depois da
        // primeira instalação com dado real: o banco (SEG-1) é irrecuperável, e
        // trocar o applicationId obriga a desinstalar.
        applicationId = "com.jotta.financial"
        // RNF-1: minSdk fixo em 26 (Android 8.0), não o padrão do Flutter — que muda
        // entre versões do SDK sem aviso no nosso changelog.
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
