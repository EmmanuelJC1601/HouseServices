
#!/usr/bin/env bash
# @Autor(es):       Emmanuel Jimenez / Jesus Tenorio
# @Fecha creación:  08/12/2025
# @Descripción: Copia una imagen y un pdf a cada carpeta fisica
#               asociada a los directorys


echo "==> ${USER} ocupo tu password aca 👇, no va a tronar... espero"
sudo -u oracle bash <<'EOF'

  BASE_PROV="/opt/oracle/oradata/FREE/files/unam/bda/pf/blobs_prov"
  PROV_IMG_DIR="${BASE_PROV}/proveedor_imgs"
  PROV_ID_DIR="${BASE_PROV}/proveedor_pdfs"
  PROV_COMP_DIR="${BASE_PROV}/comprobantes_pdfs"
  COMP_DOC_DIR="${BASE_PROV}/documentos_pdfs"
  EVID_IMG_DIR="${BASE_PROV}/evidencias_imgs"

  BASE_SERV="/opt/oracle/oradata/FREE/files/unam/bda//pf/blobs_serv"
  SERV_DET_DIR="${BASE_SERV}/detalles_pdfs"
  SERV_CON_DIR="${BASE_SERV}/contratos_pdfs"
  PROV_DEP_DIR="${BASE_SERV}/comprobante_pdfs"
  CLI_LOGO_DIR="${BASE_SERV}/logo_imgs"
  CLI_PART_DIR="${BASE_SERV}/fotos_imgs"

  ZIP_IMG_VACIO="imagenes.zip"
  ZIP_PDF_VACIO="pdfs.zip"

  shopt -s nullglob

  echo "==> Crear directorios físicos en el server"
  mkdir -p "${PROV_IMG_DIR}" "${PROV_ID_DIR}" "${PROV_COMP_DIR}" "${COMP_DOC_DIR}" "${EVID_IMG_DIR}"
  mkdir -p "${SERV_DET_DIR}" "${SERV_CON_DIR}" "${PROV_DEP_DIR}" "${CLI_LOGO_DIR}" "${CLI_PART_DIR}"

  echo "==> Limpiar archivos anteriores SOLO dentro de las carpetas objetivo"
  rm -f "${PROV_IMG_DIR}/"* "${PROV_ID_DIR}/"* "${PROV_COMP_DIR}/"* "${COMP_DOC_DIR}/"* "${EVID_IMG_DIR}/"* || true
  rm -f "${SERV_DET_DIR}/"* "${SERV_CON_DIR}/"* "${PROV_DEP_DIR}/"* "${CLI_LOGO_DIR}/"* "${CLI_PART_DIR}/"* || true

  echo "==> Copiar imagen (1.jpg) a las carpetas de imágenes"
  if [ -f "${ZIP_IMG_VACIO}" ]; then
    unzip -j "${ZIP_IMG_VACIO}" -d "${PROV_IMG_DIR}"
    unzip -j "${ZIP_IMG_VACIO}" -d "${EVID_IMG_DIR}"
    unzip -j "${ZIP_IMG_VACIO}" -d "${CLI_LOGO_DIR}"
    unzip -j "${ZIP_IMG_VACIO}" -d "${CLI_PART_DIR}"
  else
    echo "(no se encontró ${ZIP_IMG_VACIO}; coloca manualmente 1.jpg en cada carpeta de imágenes)"
  fi

  echo "==> Copiar PDF (1.pdf) a las carpetas de PDFs"
  if [ -f "${ZIP_PDF_VACIO}" ]; then
    unzip -j "${ZIP_PDF_VACIO}" -d "${PROV_ID_DIR}"
    unzip -j "${ZIP_PDF_VACIO}" -d "${PROV_COMP_DIR}"
    unzip -j "${ZIP_PDF_VACIO}" -d "${COMP_DOC_DIR}"
    unzip -j "${ZIP_PDF_VACIO}" -d "${SERV_DET_DIR}"
    unzip -j "${ZIP_PDF_VACIO}" -d "${SERV_CON_DIR}"
    unzip -j "${ZIP_PDF_VACIO}" -d "${PROV_DEP_DIR}"
  else
    echo "(no se encontró ${ZIP_PDF_VACIO}; coloca manualmente 1.pdf en cada carpeta de PDFs)"
  fi

  echo "==> Verificación (conteo de archivos en cada carpeta)"
  echo "  - ${PROV_IMG_DIR}: $(ls -1 "${PROV_IMG_DIR}" | wc -l) archivo(s)"
  echo "  - ${PROV_ID_DIR}:  $(ls -1 "${PROV_ID_DIR}"  | wc -l) archivo(s)"
  echo "  - ${PROV_COMP_DIR}: $(ls -1 "${PROV_COMP_DIR}" | wc -l) archivo(s)"
  echo "  - ${COMP_DOC_DIR}:  $(ls -1 "${COMP_DOC_DIR}" | wc -l) archivo(s)"
  echo "  - ${EVID_IMG_DIR}:  $(ls -1 "${EVID_IMG_DIR}" | wc -l) archivo(s)"
  echo "  - ${SERV_DET_DIR}:  $(ls -1 "${SERV_DET_DIR}" | wc -l) archivo(s)"
  echo "  - ${SERV_CON_DIR}:  $(ls -1 "${SERV_CON_DIR}" | wc -l) archivo(s)"
  echo "  - ${PROV_DEP_DIR}:  $(ls -1 "${PROV_DEP_DIR}" | wc -l) archivo(s)"
  echo "  - ${CLI_LOGO_DIR}:  $(ls -1 "${CLI_LOGO_DIR}" | wc -l) archivo(s)"
  echo "  - ${CLI_PART_DIR}:  $(ls -1 "${CLI_PART_DIR}" | wc -l) archivo(s)"
EOF

echo "==> Listo."
