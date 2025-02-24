// vars/loadTemplate.groovy
def call(Map config = [:]) {
    stage('Загрузка шаблона') {
        def sourceFile = config.sourceFile ?: "${env.fbrb}\\messenger.cfe"
        def designerPath = config.designerPath ?: env.platformPath
        def baseBuild = config.baseBuild ?: env.baseBuild
        def buildUser = config.buildUser ?: env.buildUser
        def templateName = config.templateName ?: "РасширениеМессенджера"
        def tempDir = "${env.TEMP ?: 'C:\\Temp'}\\template.upd"

        if (!fileExists(sourceFile)) {
            echo "Исходный файл '${sourceFile}' не найден!"
            error "Прерывание выполнения из-за отсутствия файла"
        }

        echo "Путь к информационной базе: ${baseBuild}"
        echo "Исходный файл: ${sourceFile}"
        echo "Целевой шаблон: ${templateName}"

        if (!fileExists(designerPath)) {
            echo "1C:Enterprise не найден, невозможно обновить шаблон..."
            error "Прерывание выполнения из-за отсутствия 1C"
        }
        echo "Найдена 1C:Enterprise: ${designerPath}"

        if (fileExists(tempDir)) {
            dir(tempDir) {
                deleteDir()
            }
        }
        new File(tempDir).mkdirs()

        def targetFile = "${tempDir}\\ОбщийМакет.${templateName}.Макет.bin"
        new File(targetFile).parentFile.mkdirs()
        new File(sourceFile).copyTo(new File(targetFile))
        echo "Загрузка шаблона..."

        def loadCmd = "\"${designerPath}\" DESIGNER /S\"${baseBuild}\" /N\"${buildUser}\" /LoadConfigFiles\"${tempDir}\" -Template /UpdateDBCfg"
        def loadResult = bat(script: "@chcp 65001 >nul & ${loadCmd}", returnStatus: true)
        if (loadResult != 0) {
            echo "Ошибка при загрузке шаблона: ${loadResult}"
            error "Не удалось загрузить шаблон"
        }

        echo "Операция выполнена успешно"

        if (fileExists(tempDir)) {
            dir(tempDir) {
                deleteDir()
            }
        }
    }
}