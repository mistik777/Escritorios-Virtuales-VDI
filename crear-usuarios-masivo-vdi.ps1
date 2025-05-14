# SCRIPT PARA CREAR USUARIOS EN CAMPUSVDI

# Variables iniciales
$global:tablaUsuarios = @()
$global:ID = 1
$global:grupos = @("default")
$global:categoria = "CAMPUS_DIGITAL"
$global:email = "ponaquitucorreo@dominio.com"

function Mostrar-Menu {
    Clear-Host
    Write-Host "`n===== GESTIÓN DE USUARIOS EN CAMPUSVDI ====="
    Write-Host "1 - Establecer variables (categoría, grupos, email)"
    Write-Host "2 - Crear ALUMN@S (user)"
    Write-Host "4 - Salir"
    Write-Host "`n(Recuerda: los datos no se guardan permanentemente)"
    Write-Host "==============================================`n"
}

function Crear-Usuarios-Automaticamente {
    param (
        [string]$Grupo,
        [string]$Role
    )

    $cantidad = Read-Host "¿Cuántos usuarios quieres crear para el grupo '$Grupo'?"
    if (-not [int]::TryParse($cantidad, [ref]$null)) {
        Write-Host "❌ Cantidad no válida. Introduce un número entero." -ForegroundColor Red
        return
    }

    $cantidad = [int]$cantidad
    $usuariosCreados = @()

    for ($i = 0; $i -lt $cantidad; $i++) {
        $username = "user{0:D2}-$Grupo" -f $global:ID
        $nuevoUsuario = [PSCustomObject]@{
            ID       = "{0:D3}" -f $global:ID
            username = $username
            name     = "Usuario $global:ID"
            email    = $global:email
            group    = $Grupo
            category = $global:categoria
            role     = $Role
            active   = "true"
            provider = "local"
            uid      = $username
        }

        $global:tablaUsuarios += $nuevoUsuario
        $usuariosCreados += $nuevoUsuario
        $global:ID++
    }

    Mostrar-Usuarios $usuariosCreados $Grupo

    $guardar = Read-Host "`n¿Deseas guardar estos usuarios en un archivo CSV? (s/n)"
    if ($guardar -match '^[sS]$') {
        Guardar-En-CSV $usuariosCreados
    } else {
        Write-Host "❌ No se ha guardado ningún archivo." -ForegroundColor Yellow
    }
}

function Mostrar-Usuarios {
    param (
        [array]$usuarios,
        [string]$grupo
    )

    Write-Host "`n✅ Usuarios creados para el grupo '$grupo':"
    $cabecera = "ID,username,name,email,group,category,role,active,provider,uid"
    Write-Host $cabecera
    foreach ($u in $usuarios) {
        Write-Host "$($u.ID),$($u.username),$($u.name),$($u.email),$($u.group),$($u.category),$($u.role),$($u.active),$($u.provider),$($u.uid)"
    }
}

function Guardar-En-CSV {
    param (
        [array]$usuariosAGuardar
    )

    $ruta = Join-Path -Path (Get-Location) -ChildPath "usuarios_generados.csv"
    try {
        $usuariosAGuardar | Export-Csv -Path $ruta -NoTypeInformation -Encoding UTF8
        Write-Host "`n💾 Usuarios guardados correctamente en: $ruta" -ForegroundColor Green
    } catch {
        Write-Host "❌ Error al guardar el archivo CSV: $_" -ForegroundColor Red
    }
}

function Establecer-Variables {
    Write-Host "`n== Establecer Variables =="

    # Categoría
    $nuevaCategoria = Read-Host "Nueva categoría (actual: $global:categoria)"
    if ($nuevaCategoria) {
        $global:categoria = $nuevaCategoria
        Write-Host "✅ Categoría actualizada a: $global:categoria"
    }

    # Email
    $nuevoEmail = Read-Host "Nuevo email (actual: $global:email)"
    if ($nuevoEmail) {
        $global:email = $nuevoEmail
        Write-Host "✅ Email actualizado a: $global:email"
    }

    # Grupos
    Write-Host "`nGrupos actuales: $($global:grupos -join ', ')"
    $nuevoGrupo = Read-Host "Introduce un nuevo grupo (dejar en blanco para omitir)"
    if ($nuevoGrupo) {
        if ($global:grupos -notcontains $nuevoGrupo) {
            $global:grupos += $nuevoGrupo
            Write-Host "✅ Grupo '$nuevoGrupo' añadido."
        } else {
            Write-Host "⚠️ El grupo '$nuevoGrupo' ya existe."
        }
    }
}

# Bucle principal
do {
    Mostrar-Menu
    $opcion = Read-Host "Elige una opción"

    switch ($opcion) {
        "1" {
            Establecer-Variables
        }
        "2" {
            Write-Host "`n== CREACIÓN DE USUARIOS =="
            Write-Host "Grupos disponibles: $($global:grupos -join ', ')"
            $grupoSeleccionado = Read-Host "Selecciona un grupo"
            if ($global:grupos -contains $grupoSeleccionado) {
                Crear-Usuarios-Automaticamente -Grupo $grupoSeleccionado -Role "user"
            } else {
                Write-Host "❌ Grupo no válido." -ForegroundColor Red
            }
        }
        "4" {
            Write-Host "`n👋 Saliendo del programa. ¡Hasta pronto!"
        }
        default {
            Write-Host "❌ Opción no válida. Intenta de nuevo." -ForegroundColor Red
        }
    }

    if ($opcion -ne "4") {
        Pause
    }

} while ($opcion -ne "4")
