package com.agricola.arroz.service;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.model.PlanillaPago;
import com.agricola.arroz.model.Trabajador;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

@Service
public class ReportePdfService {

    private static final ZoneId PERU_ZONE = ZoneId.of("America/Lima");

    public byte[] generarPdfAsistenciaGeneral(List<Asistencia> registros, LocalDate desde, LocalDate hasta) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Header "Empresa"
            Font fontEmpresa = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, new Color(45, 139, 45));
            document.add(new Paragraph("AGROMOYOBAMBA - SISTEMA AGRÍCOLA", fontEmpresa));
            document.add(new Paragraph("Moyobamba, San Martín - Perú", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            document.add(new Paragraph("RUC: 20123456789", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            document.add(new Paragraph("----------------------------------------------------------------------------------------------------------------------------------"));

            // Título
            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Color.BLACK);
            Paragraph titulo = new Paragraph("Reporte General de Asistencias", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);

            Font fontSub = FontFactory.getFont(FontFactory.HELVETICA, 10, Color.GRAY);
            String periodoStr = desde.equals(hasta) ? "Fecha: " + desde : "Periodo: " + desde + " al " + hasta;
            Paragraph sub = new Paragraph(periodoStr + " (Registros Completos)", fontSub);
            sub.setAlignment(Element.ALIGN_CENTER);
            document.add(sub);
            document.add(Chunk.NEWLINE);

            // Tabla
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.setWidths(new float[]{20, 50, 15, 15});

            addStyledTableHeader(table, new String[]{"Fecha", "Trabajador", "Entrada", "Salida"});

            for (Asistencia a : registros) {
                table.addCell(new Phrase(formatFechaPeru(a.getFecAsist(), a.getHoraEntrada()), FontFactory.getFont(FontFactory.HELVETICA, 9)));
                
                String nombre = (a.getTrabajador() != null) ? a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab() : "N/A";
                table.addCell(new Phrase(nombre, FontFactory.getFont(FontFactory.HELVETICA, 9)));

                // Las horas ya se guardan en horario local (America/Lima) según el cambio en AsistenciaQrService
                String hEntStr = a.getHoraEntrada().toString();
                String hSalStr = a.getHoraSalida().toString();

                table.addCell(new Phrase(hEntStr, FontFactory.getFont(FontFactory.HELVETICA, 9)));
                table.addCell(new Phrase(hSalStr, FontFactory.getFont(FontFactory.HELVETICA, 9)));
            }

            document.add(table);
            document.add(new Paragraph("\nTotal de registros completados: " + registros.size(), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10)));

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return out.toByteArray();
    }

    private String formatFechaPeru(LocalDate fecha, LocalTime hora) {
        if (fecha == null) return "N/A";
        return fecha.toString();
    }

    public byte[] generarPdfRiego(List<Asistencia> registros, LocalDate desde, LocalDate hasta) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Header "Empresa" - Diseño mejorado
            Font fontEmpresa = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, new Color(45, 139, 45));
            document.add(new Paragraph("AGROMOYOBAMBA - SISTEMA AGRÍCOLA", fontEmpresa));
            document.add(new Paragraph("Moyobamba, San Martín - Perú", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            document.add(new Paragraph("RUC: 20123456789", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            document.add(new Paragraph("----------------------------------------------------------------------------------------------------------------------------------"));

            // Título
            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Color.BLACK);
            Paragraph titulo = new Paragraph("Reporte de Labores de Riego", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);

            Font fontSub = FontFactory.getFont(FontFactory.HELVETICA, 9, Color.GRAY);
            Paragraph sub = new Paragraph("Periodo: " + desde + " al " + hasta, fontSub);
            sub.setAlignment(Element.ALIGN_CENTER);
            document.add(sub);
            
            document.add(Chunk.NEWLINE);

            // Tabla
            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);
            table.setWidths(new float[]{12, 25, 12, 16, 8, 27});

            addStyledTableHeader(table, new String[]{"Fecha", "Trabajador", "DNI", "Horario", "Tareas", "Observación"});

            int totalTareas = 0;
            for (Asistencia a : registros) {
                table.addCell(new Phrase(formatFechaPeru(a.getFecAsist(), a.getHoraEntrada()), FontFactory.getFont(FontFactory.HELVETICA, 9)));
                if (a.getTrabajador() != null) {
                    table.addCell(new Phrase(a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab(), FontFactory.getFont(FontFactory.HELVETICA, 9)));
                    table.addCell(new Phrase(a.getTrabajador().getDniTrab(), FontFactory.getFont(FontFactory.HELVETICA, 9)));
                } else {
                    table.addCell(new Phrase("N/A", FontFactory.getFont(FontFactory.HELVETICA, 9)));
                    table.addCell(new Phrase("-", FontFactory.getFont(FontFactory.HELVETICA, 9)));
                }
                
                // Horario (Rango horario solicitado)
                String hEntStr = a.getHoraEntrada() != null ? a.getHoraEntrada().toString() : "--:--";
                String hSalStr = a.getHoraSalida() != null ? a.getHoraSalida().toString() : "--:--";

                PdfPCell cellHorario = new PdfPCell(new Phrase(hEntStr + " - " + hSalStr, FontFactory.getFont(FontFactory.HELVETICA, 9)));
                cellHorario.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cellHorario);

                int t = (a.getTareasCompletadas() != null) ? a.getTareasCompletadas() : 0;
                totalTareas += t;
                PdfPCell cellTareas = new PdfPCell(new Phrase(String.valueOf(t), FontFactory.getFont(FontFactory.HELVETICA, 9)));
                cellTareas.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cellTareas);
                
                table.addCell(new Phrase(a.getObservacionSupervisor() != null ? a.getObservacionSupervisor() : "-", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            }

            document.add(table);

            // Resumen de totales al final
            Paragraph pTotal = new Paragraph("\nTOTAL REGISTROS: " + registros.size() + " | TOTAL TAREAS DE RIEGO ACUMULADAS: " + totalTareas, 
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10));
            pTotal.setAlignment(Element.ALIGN_RIGHT);
            document.add(pTotal);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return out.toByteArray();
    }

    public byte[] generarPdfTareas(List<Asistencia> registros, String tipo, LocalDate desde, LocalDate hasta) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Color.BLACK);
            Paragraph titulo = new Paragraph("Reporte de Tarea: " + tipo.toUpperCase(), fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);

            Font fontSub = FontFactory.getFont(FontFactory.HELVETICA, 10, Color.GRAY);
            Paragraph sub = new Paragraph("Periodo: " + desde + " al " + hasta, fontSub);
            sub.setAlignment(Element.ALIGN_CENTER);
            document.add(sub);
            document.add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setWidths(new float[]{15, 30, 15, 10, 30});

            addStyledTableHeader(table, new String[]{"Fecha", "Trabajador", "DNI", "Tareas", "Observación"});

            for (Asistencia a : registros) {
                table.addCell(a.getFecAsist().toString());
                if (a.getTrabajador() != null) {
                    table.addCell(a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab());
                    table.addCell(a.getTrabajador().getDniTrab());
                } else {
                    table.addCell("N/A");
                    table.addCell("-");
                }
                table.addCell(String.valueOf(a.getTareasCompletadas()));
                table.addCell(a.getObservacionSupervisor() != null ? a.getObservacionSupervisor() : "-");
            }

            document.add(table);
            
            int total = registros.stream().mapToInt(a -> a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0).sum();
            document.add(new Paragraph("\nTotal acumulado de tareas: " + total));

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return out.toByteArray();
    }

    public byte[] generarPdfBoletaPago(PlanillaPago planilla, List<Asistencia> detalles) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Trabajador t = planilla.getTrabajador();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Header "Empresa"
            Font fontEmpresa = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, new Color(45, 139, 45));
            document.add(new Paragraph("AGROMOYOBAMBA - SISTEMA AGRÍCOLA", fontEmpresa));
            document.add(new Paragraph("Moyobamba, San Martín - Perú", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            document.add(new Paragraph("RUC: 20123456789", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            document.add(new Paragraph("----------------------------------------------------------------------------------------------------------------------------------"));

            // Título Boleta
            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
            Paragraph titulo = new Paragraph("BOLETA DE PAGO DE HABERES", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);
            document.add(Chunk.NEWLINE);

            // Información del Trabajador
            PdfPTable infoTable = new PdfPTable(2);
            infoTable.setWidthPercentage(100);

            addInfoCell(infoTable, "TRABAJADOR:", t.getNomTrab() + " " + t.getApeTrab());
            addInfoCell(infoTable, "DNI:", t.getDniTrab());
            addInfoCell(infoTable, "CARGO:", t.getCargo() != null ? t.getCargo().getNomCargo() : "Personal");
            addInfoCell(infoTable, "TIPO PAGO:", t.getTipoPago().getEtiqueta());
            addInfoCell(infoTable, "PERIODO:", planilla.getFechaInicio() + " al " + planilla.getFechaFin());
            addInfoCell(infoTable, "EMITIDO EL:", LocalDate.now().toString());
            
            document.add(infoTable);
            document.add(Chunk.NEWLINE);

            // Tabla de Desglose
            document.add(new Paragraph("DETALLE DE ACTIVIDADES REALIZADAS:", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10)));
            document.add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            addStyledTableHeader(table, new String[]{"Fecha", "Actividad", "Cant/Días", "Subtotal"});

            com.agricola.arroz.model.TipoPago tp = t.getTipoPago();
            BigDecimal tarifa = BigDecimal.ZERO;
            if (tp != null) {
                if (tp.esPorJornal()) tarifa = t.getSueldoBaseDia();
                else if (tp.esPorSaco()) tarifa = t.getPagoPorSaco();
                else if (tp.esPorTarea()) tarifa = t.getPagoPorTarea();
            }
            if (tarifa == null) tarifa = BigDecimal.ZERO;

            for (Asistencia a : detalles) {
                table.addCell(new Phrase(a.getFecAsist().toString(), FontFactory.getFont(FontFactory.HELVETICA, 9)));
                
                String label = a.getTipoTarea() != null ? a.getTipoTarea() : 
                               (a.getSacosCosechados() != null && a.getSacosCosechados() > 0 ? "POR SACO" : "JORNAL");
                
                table.addCell(new Phrase(label, FontFactory.getFont(FontFactory.HELVETICA, 9)));
                
                int cant = (a.getTareasCompletadas() != null && a.getTareasCompletadas() > 0) ? a.getTareasCompletadas() : 
                           (a.getSacosCosechados() != null ? a.getSacosCosechados() : 1);
                
                table.addCell(new Phrase(String.valueOf(cant), FontFactory.getFont(FontFactory.HELVETICA, 9)));
                BigDecimal sub = tarifa.multiply(BigDecimal.valueOf(cant));
                PdfPCell cellSub = new PdfPCell(new Phrase("S/ " + sub.toString(), FontFactory.getFont(FontFactory.HELVETICA, 9)));
                cellSub.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cellSub);
            }
            document.add(table);

            // Total
            Paragraph total = new Paragraph("\nMONTO TOTAL A PAGAR: S/ " + planilla.getMontoTotal(), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12));
            total.setAlignment(Element.ALIGN_RIGHT);
            document.add(total);

            // Firmas
            document.add(new Paragraph("\n\n\n\n"));
            PdfPTable firmaTable = new PdfPTable(2);
            firmaTable.setWidthPercentage(80);
            PdfPCell c1 = new PdfPCell(new Paragraph("__________________________\nFirma del Empleador", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            PdfPCell c2 = new PdfPCell(new Paragraph("__________________________\nFirma del Trabajador", FontFactory.getFont(FontFactory.HELVETICA, 9)));
            c1.setBorder(0); c2.setBorder(0);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER); c2.setHorizontalAlignment(Element.ALIGN_CENTER);
            firmaTable.addCell(c1); firmaTable.addCell(c2);
            document.add(firmaTable);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return out.toByteArray();
    }

    public byte[] generarPdfBoletaActividad(Asistencia a) {
        Document document = new Document(PageSize.A5);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Trabajador t = a.getTrabajador();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            Font fontEmpresa = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, new Color(45, 139, 45));
            document.add(new Paragraph("AGROMOYOBAMBA - COMPROBANTE DE LABOR", fontEmpresa));
            document.add(new Paragraph("RUC: 20123456789", FontFactory.getFont(FontFactory.HELVETICA, 8)));
            document.add(new Paragraph("-----------------------------------------------------------------------------------------"));

            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14);
            Paragraph titulo = new Paragraph("BOLETA DE LABOR ESPECIFICA", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);
            document.add(Chunk.NEWLINE);

            PdfPTable infoTable = new PdfPTable(2);
            infoTable.setWidthPercentage(100);

            addInfoCell(infoTable, "TRABAJADOR:", t.getNomTrab() + " " + t.getApeTrab());
            addInfoCell(infoTable, "DNI:", t.getDniTrab());
            addInfoCell(infoTable, "FECHA LABOR:", a.getFecAsist().toString());
            addInfoCell(infoTable, "ACTIVIDAD:", a.getTipoTarea() != null ? a.getTipoTarea() : "JORNAL");
            
            int cant = (a.getTareasCompletadas() != null && a.getTareasCompletadas() > 0) ? a.getTareasCompletadas() : 
                       (a.getSacosCosechados() != null ? a.getSacosCosechados() : 1);
            
            com.agricola.arroz.model.TipoPago tp = t.getTipoPago();
            BigDecimal tarifa = BigDecimal.ZERO;
            if (tp != null) {
                if (tp.esPorJornal()) tarifa = t.getSueldoBaseDia();
                else if (tp.esPorSaco()) tarifa = t.getPagoPorSaco();
                else if (tp.esPorTarea()) tarifa = t.getPagoPorTarea();
            }
            if (tarifa == null) tarifa = BigDecimal.ZERO;
            
            BigDecimal subtotal = tarifa.multiply(BigDecimal.valueOf(cant));

            addInfoCell(infoTable, "CANTIDAD:", String.valueOf(cant));
            addInfoCell(infoTable, "PAGO UNITARIO:", "S/ " + tarifa.toString());
            addInfoCell(infoTable, "TOTAL PAGADO:", "S/ " + subtotal.toString());
            
            document.add(infoTable);
            document.add(new Paragraph("\n\n"));

            PdfPTable firmaTable = new PdfPTable(2);
            firmaTable.setWidthPercentage(100);
            PdfPCell c1 = new PdfPCell(new Paragraph("__________________________\nFirma del Empleador", FontFactory.getFont(FontFactory.HELVETICA, 8)));
            PdfPCell c2 = new PdfPCell(new Paragraph("__________________________\nFirma del Trabajador", FontFactory.getFont(FontFactory.HELVETICA, 8)));
            c1.setBorder(0); c2.setBorder(0);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER); c2.setHorizontalAlignment(Element.ALIGN_CENTER);
            firmaTable.addCell(c1); firmaTable.addCell(c2);
            document.add(firmaTable);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return out.toByteArray();
    }

    private void addStyledTableHeader(PdfPTable table, String[] headers) {
        Font fontHeader = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Color.WHITE);
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, fontHeader));
            cell.setBackgroundColor(new Color(45, 139, 45)); // Verde institucional
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(6);
            table.addCell(cell);
        }
    }

    private void addInfoCell(PdfPTable table, String label, String value) {
        PdfPCell c1 = new PdfPCell(new Phrase(label, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9)));
        PdfPCell c2 = new PdfPCell(new Phrase(value, FontFactory.getFont(FontFactory.HELVETICA, 9)));
        c1.setBorder(0); c2.setBorder(0);
        c1.setPadding(2); c2.setPadding(2);
        table.addCell(c1); table.addCell(c2);
    }

    public byte[] generarPdfResumen(List<Asistencia> registros, LocalDate desde, LocalDate hasta) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Color.BLACK);
            Paragraph titulo = new Paragraph("Resumen General de Labores", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);

            Font fontSub = FontFactory.getFont(FontFactory.HELVETICA, 10, Color.GRAY);
            Paragraph sub = new Paragraph("Periodo: " + desde + " al " + hasta, fontSub);
            sub.setAlignment(Element.ALIGN_CENTER);
            document.add(sub);
            
            document.add(Chunk.NEWLINE);

            // Cálculos
            Map<Trabajador, List<Asistencia>> grouped = registros.stream()
                .filter(a -> a.getTrabajador() != null)
                .collect(Collectors.groupingBy(Asistencia::getTrabajador));

            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.setWidths(new float[]{30, 15, 35, 20});
            addStyledTableHeader(table, new String[]{"Trabajador / DNI", "Cargo", "Detalle Labores", "Total"});

            BigDecimal granTotal = BigDecimal.ZERO;

            for (Map.Entry<Trabajador, List<Asistencia>> entry : grouped.entrySet()) {
                Trabajador t = entry.getKey();
                List<Asistencia> asists = entry.getValue();

                String actividades = asists.stream()
                    .map(a -> {
                        if (a.getTipoTarea() != null) return a.getTipoTarea();
                        return (a.getSacosCosechados() != null && a.getSacosCosechados() > 0) ? "POR SACO" : "JORNAL";
                    })
                    .distinct()
                    .collect(Collectors.joining(", "));

                BigDecimal totalTrabajador = BigDecimal.ZERO;
                
                com.agricola.arroz.model.TipoPago tp = t.getTipoPago();
                BigDecimal tarifa = BigDecimal.ZERO;
                if (tp != null) {
                    if (tp.esPorJornal()) tarifa = t.getSueldoBaseDia();
                    else if (tp.esPorSaco()) tarifa = t.getPagoPorSaco();
                    else if (tp.esPorTarea()) tarifa = t.getPagoPorTarea();
                }
                if (tarifa == null) tarifa = BigDecimal.ZERO;

                for (Asistencia a : asists) {
                    int cant = (a.getTareasCompletadas() != null && a.getTareasCompletadas() > 0) ? a.getTareasCompletadas() : 
                               (a.getSacosCosechados() != null ? a.getSacosCosechados() : 1);
                    totalTrabajador = totalTrabajador.add(tarifa.multiply(BigDecimal.valueOf(cant)));
                }

                table.addCell(t.getNomTrab() + " " + t.getApeTrab() + "\nDNI: " + t.getDniTrab());
                table.addCell(t.getCargo() != null ? t.getCargo().getNomCargo() : "N/A");
                table.addCell(actividades);
                table.addCell("S/ " + totalTrabajador.setScale(2, RoundingMode.HALF_UP).toString());
                
                granTotal = granTotal.add(totalTrabajador);
            }

            document.add(table);
            document.add(Chunk.NEWLINE);
            
            Paragraph pTotal = new Paragraph("TOTAL GENERAL DEL PERIODO: S/ " + granTotal.setScale(2, RoundingMode.HALF_UP).toString(), 
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12));
            pTotal.setAlignment(Element.ALIGN_RIGHT);
            document.add(pTotal);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return out.toByteArray();
    }

    /**
     * Genera un PDF con el código QR único del trabajador para el control de asistencia.
     */
    public byte[] generarPdfQrTrabajador(Trabajador t) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Título
            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, new Color(45, 139, 45));
            Paragraph titulo = new Paragraph("CREDENCIAL DE ASISTENCIA", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);
            document.add(Chunk.NEWLINE);

            // Datos del trabajador
            Paragraph pNombre = new Paragraph(t.getNomTrab() + " " + t.getApeTrab(), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16));
            pNombre.setAlignment(Element.ALIGN_CENTER);
            document.add(pNombre);

            Paragraph pDni = new Paragraph("DNI: " + t.getDniTrab(), FontFactory.getFont(FontFactory.HELVETICA, 14));
            pDni.setAlignment(Element.ALIGN_CENTER);
            document.add(pDni);
            document.add(Chunk.NEWLINE);

            // Generar QR usando ZXing
            String qrData = (t.getQrToken() != null && !t.getQrToken().isEmpty()) ? t.getQrToken() : "TOKEN_NO_ASIGNADO";
            
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(qrData, BarcodeFormat.QR_CODE, 200, 200);
            BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix);
            Image imgQr = Image.getInstance(bufferedImage, null);
            
            imgQr.setAlignment(Element.ALIGN_CENTER);
            imgQr.scaleAbsolute(200f, 200f);
            document.add(imgQr);

            document.add(Chunk.NEWLINE);
            Paragraph pFooter = new Paragraph("Escanee este código en el campo para registrar su ingreso y salida.", 
                FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10, Color.GRAY));
            pFooter.setAlignment(Element.ALIGN_CENTER);
            document.add(pFooter);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return out.toByteArray();
    }
}