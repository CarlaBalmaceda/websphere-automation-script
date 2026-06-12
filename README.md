}# 🚀 WebSphere Application & Log Status Parser

Una solución automatizada e híbrida desarrollada en **Bash** y **Python** para extraer, filtrar y estructurar de manera eficiente los reportes de estado de aplicaciones y servidores IBM WebSphere a partir de documentación en formato PDF.

---

## 📋 Descripción del Problema y Caso de Uso

En entornos operativos corporativos, los reportes de salud y estado de las aplicaciones suelen extraerse en documentos consolidados de texto o PDF de gran tamaño. Realizar un análisis manual de estos archivos consume tiempo crítico y es propenso a errores humanos.

Este script automatiza por completo el flujo de diagnóstico técnico:
1. **Fase Operativa (Bash):** Valida el entorno de ejecución, interactúa con utilidades del sistema y realiza un filtrado masivo y eficiente de líneas mediante expresiones regulares con `awk`.
2. **Fase de Lógica de Datos (Python):** Recibe la información depurada, la procesa mediante un diccionario y genera una estructura limpia, ordenada alfabéticamente y agrupada para el equipo de operaciones.

---

## 🛠️ Requisitos Previos

El script requiere de la utilidad `pdftotext` para procesar los documentos. Asegurate de tenerla instalada según tu sistema operativo:

* **Ubuntu / Debian:** `sudo apt install poppler-utils`
* **macOS (Homebrew):** `brew install poppler`

---

## 📂 Estructura de Archivos

* `listar_websphere.sh` - Script principal de automatización (híbrido Bash + Python).
* `DOCUMENTACIÓN APLICACIONES DE WEBSPHERE.pdf` - Archivo fuente con los datos del servidor (requerido para la ejecución).
* `resultado_websphere.txt` - Reporte final estructurado generado automáticamente.

---

## ⚙️ Guía de Ejecución Rápida

Siga estos pasos para ejecutar la herramienta en su entorno local:

### 1. Clonar el repositorio y preparar el script
Guarda el código principal en tu máquina local con el nombre `listar_websphere.sh`.

### 2. Otorgar permisos de ejecución
Antes de ejecutarlo, asigná los permisos necesarios desde tu terminal:
```bash
chmod +x listar_websphere.shresultado en resultado_websphere.txt.
