# cinemapedia

# Dev

1. Copiar el env.template y renombrarlo a .env
2. Cambiar las variables de entorno ( THE MOVIEDB )
3. cambios en la entidad, hay que ejecuitar el comando
```
flutter pub run build_runner build
```


Se Actualizo el archivo android/build.gradle
    se agrego [ afterEvaluate {....}  ]
```
subprojects {

    afterEvaluate { project ->
        if (project.plugins.hasPlugin("com.android.application") ||
        project.plugins.hasPlugin("com.android.library")) {
        project.android {
            compileSdkVersion 34
            buildToolsVersion "34.0.0"
        }
        }
        if (project.hasProperty("android")) {
        project.android {
            if (namespace == null) {
            namespace project.group
            }
        }
        }
    }    
    project.buildDir = "${rootProject.buildDir}/${project.name}"
    project.evaluationDependsOn(":app")
}
```