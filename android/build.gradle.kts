allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    afterEvaluate {
        if (extensions.findByName("android") != null) {
            try {
                val androidExt = extensions.findByName("android")
                if (androidExt != null) {
                    // Check if it's a com.android.build.gradle.BaseExtension
                    val namespaceMethod = androidExt.javaClass.methods.find { it.name == "getNamespace" }
                    val setNamespaceMethod = androidExt.javaClass.methods.find { it.name == "setNamespace" }
                    
                    if (namespaceMethod != null && setNamespaceMethod != null) {
                        val currentNamespace = namespaceMethod.invoke(androidExt) as? String
                        if (currentNamespace == null || currentNamespace.isEmpty()) {
                            // Set namespace based on project path or group
                            val defaultNamespace = when {
                                path.contains("vosk_flutter") -> "com.alphacephei.vosk"
                                else -> group.toString()
                            }
                            setNamespaceMethod.invoke(androidExt, defaultNamespace)
                            logger.lifecycle("Set namespace for $path to $defaultNamespace")
                        }
                    }
                }
            } catch (e: Exception) {
                logger.warn("Failed to set namespace for $path: ${e.message}")
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
