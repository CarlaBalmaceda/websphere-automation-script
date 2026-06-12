#!/bin/bash

PDF_FILE="DOCUMENTACIÓN APLICACIONES DE WEBSPHERE.pdf"
TXT_FILE="apps_data.txt"

# Verificar si el PDF existe
if [[ ! -f "$PDF_FILE" ]]; then
    echo "Error: El archivo $PDF_FILE no existe."
    exit 1
fi

# Verificar si pdftotext está instalado
if ! command -v pdftotext &> /dev/null; then
    echo "Error: pdftotext no está instalado. Instálalo con 'sudo apt install poppler-utils' (Ubuntu) o 'brew install poppler' (Mac)."
    exit 1
fi

# Extraer texto del PDF y filtrar las líneas relevantes
pdftotext -layout "$PDF_FILE" - | awk '
/^[[:alnum:]_-]+[[:space:]]+(Running|Stopped|Unknown)[[:space:]]+[[:alnum:]_-]+$/ {
    print $0
}' > "$TXT_FILE"

# Verificar si se extrajo información
if [[ ! -s "$TXT_FILE" ]]; then
    echo "Error: No se encontró información válida en el documento."
    exit 1
fi

# Llamar al script de Python para procesar la información
winpty python - <<EOF
import re

# Leer el archivo generado por awk
with open("$TXT_FILE", "r") as file:
    lines = file.readlines()

apps = []
servers = set()
app_server_map = {}

# Procesar cada línea del archivo
for line in lines:
    match = re.match(r"^(\S+)\s+(Running|Stopped|Unknown)\s+(\S+)", line)
    if match:
        app, status, server = match.groups()
        apps.append(app)
        servers.add(server)
        if server in app_server_map:
            app_server_map[server].append(app)
        else:
            app_server_map[server] = [app]

# Guardar la información en un archivo de salida
output_file = "resultado_websphere.txt"
with open(output_file, "w") as out:
    out.write("Lista de Aplicaciones:\n")
    out.writelines(f"- {app}\n" for app in sorted(apps))
    
    out.write("\nLista de Servidores:\n")
    out.writelines(f"- {server}\n" for server in sorted(servers))

    out.write("\nAplicaciones por Servidor:\n")
    for server, app_list in app_server_map.items():
        out.write(f"\n{server}:\n")
        out.writelines(f"  - {app}\n" for app in sorted(app_list))

# Mostrar mensaje final
print(f"Procesamiento completado. Los resultados están en {output_file}")
EOF
