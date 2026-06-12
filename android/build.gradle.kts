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
    project.evaluationDependsOn(":app")
}

subprojects {
    val configureProject = {
        if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
            val android = extensions.findByName("android")
            if (android != null) {
                try {
                    val getNamespace = android.javaClass.getMethod("getNamespace")
                    val currentNamespace = getNamespace.invoke(android) as? String
                    if (currentNamespace.isNullOrEmpty()) {
                        val setNamespace = android.javaClass.getMethod("setNamespace", java.lang.String::class.java)
                        val ns = if (project.group.toString().isEmpty() || project.group.toString() == "compass" || project.group.toString() == "sbi") {
                            "com.example.${project.name.replace("-", "_").replace(".", "_")}"
                        } else {
                            project.group.toString()
                        }
                        setNamespace.invoke(android, ns)
                    }
                } catch (e: Exception) {
                    // Ignore errors if setNamespace is not supported
                }
            }
        }
    }

    if (state.executed) {
        configureProject()
    } else {
        afterEvaluate {
            configureProject()
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
