allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    // Add AppCompat dependency for Android plugins before evaluation
    // This is needed for payment_gateway_plugin which uses Theme.AppCompat
    if (project.name != "app") {
        project.configurations.maybeCreate("implementation")
        project.dependencies.add("implementation", "androidx.appcompat:appcompat:1.6.1")
    }
    
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
