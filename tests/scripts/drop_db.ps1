# drop_db.ps1
# Скрипт для удаления базы данных из кластера 1С и PostgreSQL

# Название базы 1С и PostgreSQL
$infobase = "avtotestqa"

# Параметры подключения
$server1c = "localhost"
$agentPort = "1540"
$pgServer = "localhost"
$pgPort = "5432"
$pgUser = "postgres"
$pgPassword = "postgres"  # ← Укажи здесь пароль PostgreSQL

$baseFound = $false

try {
    # Подключение к кластеру 1С
    $V83Com = New-Object -ComObject "V83.ComConnector"
    $ServerAgent = $V83Com.ConnectAgent("$server1c`:$agentPort")
    $Clusters = $ServerAgent.GetClusters()
    $Cluster = $Clusters[0]
    $ServerAgent.Authenticate($Cluster, "", "")

    # Подключение к рабочему процессу
    $WorkingProcesses = $ServerAgent.GetWorkingProcesses($Cluster)
    $CurrentWorkingProcess = $V83Com.ConnectWorkingProcess("tcp://$server1c`:" + $WorkingProcesses[0].MainPort)

    # Поиск базы в кластере
    $BaseInfo = $CurrentWorkingProcess.GetInfoBases()
    foreach ($base in $BaseInfo) {
        if ($base.Name -eq $infobase) {
            $baseFound = $true
            $Base = $base
            break
        }
    }

    if ($baseFound) {
        # Блокировка базы
        $Base.ScheduledJobsDenied = $true
        $Base.SessionsDenied = $true
        $CurrentWorkingProcess.UpdateInfoBase($Base)

        # Завершение соединений
        $connections = $CurrentWorkingProcess.GetInfoBaseConnections($Base)
        foreach ($conn in $connections) {
            try {
                Write-Host "Disconnecting $infobase connection: $($conn.AppID)"
                $CurrentWorkingProcess.Disconnect($conn)
            } catch {
                Write-Host "Failed to disconnect $($conn.AppID): $($_.Exception.Message)"
            }
        }

        # Завершение сессий
        $Sessions = $ServerAgent.GetSessions($Cluster)
        foreach ($Session in $Sessions) {
            if ($Session.InfoBase.Name -eq $infobase) {
                Write-Host "Terminating session for $infobase, user: $($Session.UserName)"
                try {
                    $ServerAgent.TerminateSession($Cluster, $Session)
                } catch {
                    Write-Host "Failed to terminate session: $($_.Exception.Message)"
                }
            }
        }

        # Удаление базы из кластера
        Write-Host "Removing $infobase from 1C cluster..."
        $CurrentWorkingProcess.DropInfoBase($Base, 0)

        # Удаление базы из PostgreSQL
        Write-Host "Removing $infobase from PostgreSQL..."
        $dbNameLower = $infobase.ToLower()

        $terminateQuery = "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$dbNameLower' AND pid <> pg_backend_pid();"
        $dropQuery = "DROP DATABASE IF EXISTS $dbNameLower;"

        $env:PGPASSWORD = $pgPassword

        cmd.exe /c "psql -h $pgServer -p $pgPort -U $pgUser -d postgres -c `"$terminateQuery`""
        cmd.exe /c "psql -h $pgServer -p $pgPort -U $pgUser -d postgres -c `"$dropQuery`""

        Remove-Item Env:PGPASSWORD

        # Очистка кэша 1С
        $user = $env:UserName
        $paths = @(
            "C:\Users\$user\AppData\Local\1C\1cv8",
            "C:\Users\$user\AppData\Roaming\1C\1cv8",
            "C:\Users\$user\AppData\Roaming\1C\1cv82",
            "C:\Users\$user\AppData\Local\1C\1cv82"
        )

        foreach ($path in $paths) {
            if (Test-Path $path) {
                Get-ChildItem $path | Where-Object { $_.Name -match "........-....-....-....-............" } | Remove-Item -Force -Recurse
                Write-Host "Cleared 1C cache at $path"
            }
        }

        Write-Host "Database $infobase successfully removed."
    } else {
        Write-Host "Database $infobase not found in 1C cluster."
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}
