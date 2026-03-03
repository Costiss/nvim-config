// app/build.gradle.kts

tasks.register("generateClasspath") {
    description = "Generates an Eclipse .classpath file for Neovim JDTLS"
    group = "ide"

    doLast {
        // Build the .classpath contents in memory first so we can write the same
        // content to both project-root and module .classpath files.
        val sb = StringBuilder()
        sb.appendLine("""<?xml version="1.0" encoding="UTF-8"?>""")
        sb.appendLine("""<classpath>""")

        // 1. Point JDTLS to the Android SDK (Fixes: "Cannot resolve symbol 'android'")
        val compileSdk = android.compileSdk
        val sdkDir = android.sdkDirectory.absolutePath
        val platformDir = File("$sdkDir/platforms/android-$compileSdk")
        if (platformDir.exists()) {
            platformDir.walkTopDown().filter { it.isFile && it.extension == "jar" }.forEach { jarFile ->
                sb.appendLine("""    <classpathentry kind="lib" path="${jarFile.absolutePath}"/>""")
            }
        } else {
            val androidJar = "$sdkDir/platforms/android-$compileSdk/android.jar"
            sb.appendLine("""    <classpathentry kind="lib" path="$androidJar"/>""")
        }

        // 2. Add your main source code directories
        sb.appendLine("""    <classpathentry kind="src" path="app/src/main/java"/>""")

        // 3. Add generated Android sources (Fixes: "Cannot resolve symbol 'R'" and 'BuildConfig')
        sb.appendLine("""    <classpathentry kind="src" path="app/build/generated/ap_generated_sources/debug/out"/>""")
        sb.appendLine("""    <classpathentry kind="src" path="app/build/generated/source/buildConfig/debug"/>""")

        // 4. Specify the output directory for compiled classes
        sb.appendLine("""    <classpathentry kind="output" path="app/build/intermediates/javac/debug/classes"/>""")

        // 5. Inject dependencies (JARs and AARs)
        val compileClasspath = configurations.getByName("debugCompileClasspath")

        fun findClassesJarForAar(aarFile: File): File? {
            // Common locations to check
            val candidate1 = File(aarFile.absolutePath.replace(".aar", "/jars/classes.jar"))
            if (candidate1.exists()) return candidate1
            val candidate2 = File(aarFile.parentFile, "jars/classes.jar")
            if (candidate2.exists()) return candidate2

            // Try to find a matching classes.jar somewhere in the Gradle cache transforms.
            // This is a best-effort search and may take a short while on large caches.
            val gradleHome = project.gradle.gradleUserHomeDir
            val match =
                gradleHome.walkTopDown().firstOrNull {
                    it.name == "classes.jar" && it.absolutePath.contains(aarFile.nameWithoutExtension)
                }
            if (match != null) return match

            return null
        }

        compileClasspath.resolvedConfiguration.resolvedArtifacts.forEach { artifact ->
            val file = artifact.file
            if (file.extension == "jar") {
                // Standard JARs are easily read by JDTLS
                sb.append("""    <classpathentry kind="lib" path="${file.absolutePath}"/>\n""")
            } else if (file.extension == "aar") {
                // JDTLS cannot read AARs directly. Try to locate the exploded classes.jar
                val classesJar = findClassesJarForAar(file)
                if (classesJar != null && classesJar.exists()) {
                    sb.appendLine("""    <classpathentry kind="lib" path="${classesJar.absolutePath}"/>""")
                } else {
                    // Fallback: include the AAR itself as a hint (some setups may handle this differently)
                    sb.appendLine("""    <classpathentry kind="lib" path="${file.absolutePath}"/>""")
                }
            }
        }
        sb.appendLine("""</classpath>""")

        // Write to project root .classpath (outside app/) and also to module app/.classpath
        val projectClasspathFile = file("../.classpath")
        projectClasspathFile.bufferedWriter().use { it.write(sb.toString()) }

        val moduleClasspathFile = file(".classpath")
        moduleClasspathFile.bufferedWriter().use { it.write(sb.toString()) }

        println("✅ Successfully generated .classpath for JDTLS at project root and module!")
    }
}
