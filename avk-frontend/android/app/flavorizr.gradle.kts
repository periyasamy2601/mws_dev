import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.dconag.lite"
            resValue(type = "string", name = "app_name", value = "AVK")
        }
        create("stage") {
            dimension = "flavor-type"
            applicationId = "com.mobitech.dconag.lite.stage"
            resValue(type = "string", name = "app_name", value = "AVK Stage")
        }
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.mobitech.dconag.lite.dev"
            resValue(type = "string", name = "app_name", value = "AVK Dev")
        }
    }
}