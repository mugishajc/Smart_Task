plugins {
    kotlin("android") version "2.1.10" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Set a custom build directory
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// ✅ Ensure all subprojects depend on :app
subprojects {
    project.evaluationDependsOn(":app")
}

// ✅ Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// 🚀 Enforce Kotlin version for ALL modules
subprojects {
    configurations.all {
        resolutionStrategy.eachDependency {
            if (requested.group == "org.jetbrains.kotlin" && requested.name.startsWith("kotlin-")) {
                useVersion("2.1.10") // ✅ Force Kotlin version globally
            }
        }
    }
}

// 🔑 Force plugin resolution for older dependencies (like nb_utils)
gradle.beforeProject {
    project.buildscript.configurations.all {
        resolutionStrategy.eachDependency {
            if (requested.group == "org.jetbrains.kotlin" && requested.name == "kotlin-gradle-plugin") {
                useVersion("2.1.10") // ✅ Override kotlin-gradle-plugin version
            }
        }
    }
}
