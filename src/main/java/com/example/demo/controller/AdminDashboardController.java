package com.example.demo.controller;

import com.example.demo.model.Complaint;
import com.example.demo.model.Mandal;
import com.example.demo.model.Village;
import com.example.demo.repository.ComplaintRepository;
import com.example.demo.repository.MandalRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.repository.VillageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.ByteArrayOutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

    public static class MandalReportItem {
        private String villageName;
        private String mandalName;
        private String submittedDate;
        private String submittedTime;

        public MandalReportItem(String villageName, String mandalName, String submittedDate, String submittedTime) {
            this.villageName = villageName;
            this.mandalName = mandalName;
            this.submittedDate = submittedDate;
            this.submittedTime = submittedTime;
        }

        public String getVillageName() {
            return villageName;
        }

        public String getMandalName() {
            return mandalName;
        }

        public String getSubmittedDate() {
            return submittedDate;
        }

        public String getSubmittedTime() {
            return submittedTime;
        }
    }

    @Autowired
    private MandalRepository mandalRepository;

    @Autowired
    private VillageRepository villageRepository;

    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private UserRepository userRepository;

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/dashboard")
    public String adminDashboard(Model model) {
        List<Mandal> mandals = mandalRepository.findAll();
        model.addAttribute("mandals", mandals);
        return "admin-dashboard";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/mandal/{id}")
    public String mandalVillages(@PathVariable("id") Long id, Model model) {
        Mandal mandal = mandalRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Mandal not found: " + id));

        List<Village> villages = villageRepository.findByMandal(mandal);

        List<Village> submitted = villages.stream()
                .filter(v -> complaintRepository.countByUserVillage(v) > 0)
                .toList();

        List<Village> notSubmitted = villages.stream()
                .filter(v -> complaintRepository.countByUserVillage(v) == 0)
                .toList();

        model.addAttribute("mandal", mandal);
        model.addAttribute("villages", villages);
        model.addAttribute("submitted", submitted);
        model.addAttribute("notSubmitted", notSubmitted);
        return "mandal-villages";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/village/{id}")
    @Transactional(readOnly = true)
    public String villageReport(@PathVariable("id") Long id, Model model) {
        Village village = villageRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Village not found: " + id));

        List<Complaint> complaints = complaintRepository.findByUserVillage(village);
        long userCount = userRepository.countByVillage(village);

        model.addAttribute("village", village);
        model.addAttribute("complaints", complaints);
        model.addAttribute("userCount", userCount);
        if (village.getMandal() != null) {
            model.addAttribute("mandalId", village.getMandal().getId());
        }
        return "village-report";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/mandal/{id}/reports")
    public String mandalReports(@PathVariable("id") Long id, Model model) {
        Mandal mandal = mandalRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Mandal not found: " + id));

        List<Village> villages = villageRepository.findByMandal(mandal);

        List<Village> submitted = villages.stream()
                .filter(v -> complaintRepository.countByUserVillage(v) > 0)
                .toList();

        List<Village> notSubmitted = villages.stream()
                .filter(v -> complaintRepository.countByUserVillage(v) == 0)
                .toList();

        model.addAttribute("mandal", mandal);
        model.addAttribute("totalVillages", villages.size());
        model.addAttribute("submittedCount", submitted.size());
        model.addAttribute("pendingCount", notSubmitted.size());
        model.addAttribute("submitted", submitted);
        model.addAttribute("notSubmitted", notSubmitted);
        return "mandal-reports";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/reports")
    public String overallReports(Model model) {
        List<Mandal> mandals = mandalRepository.findAll();
        List<Village> allVillages = villageRepository.findAll();

        long submittedVillages = allVillages.stream()
                .filter(v -> complaintRepository.countByUserVillage(v) > 0)
                .count();
        long pendingVillages = allVillages.size() - submittedVillages;

        List<MandalReportItem> submittedDetails = buildSubmittedDetails();
        List<MandalReportItem> pendingDetails = buildPendingDetails();

        model.addAttribute("mandals", mandals);
        model.addAttribute("totalVillages", allVillages.size());
        model.addAttribute("submittedVillages", submittedVillages);
        model.addAttribute("pendingVillages", pendingVillages);
        model.addAttribute("submittedDetails", submittedDetails);
        model.addAttribute("pendingDetails", pendingDetails);
        return "reports";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/reports/export/excel")
    public ResponseEntity<byte[]> exportExcel(@RequestParam String type) throws Exception {
        List<MandalReportItem> items = "submitted".equalsIgnoreCase(type)
                ? buildSubmittedDetails()
                : buildPendingDetails();

        org.apache.poi.ss.usermodel.Workbook wb = new org.apache.poi.xssf.usermodel.XSSFWorkbook();
        org.apache.poi.ss.usermodel.Sheet sheet = wb.createSheet(type + "_villages");

        org.apache.poi.ss.usermodel.Row header = sheet.createRow(0);
        String[] cols = "submitted".equalsIgnoreCase(type)
                ? new String[]{"Village Name", "Mandal Name", "Submitted Date", "Submitted Time"}
                : new String[]{"Village Name", "Mandal Name"};
        for (int i = 0; i < cols.length; i++) {
            org.apache.poi.ss.usermodel.Cell cell = header.createCell(i);
            cell.setCellValue(cols[i]);
            cell.setCellStyle(getHeaderStyle(wb));
        }

        for (int i = 0; i < items.size(); i++) {
            org.apache.poi.ss.usermodel.Row row = sheet.createRow(i + 1);
            MandalReportItem item = items.get(i);
            row.createCell(0).setCellValue(item.getVillageName() != null ? item.getVillageName() : "");
            row.createCell(1).setCellValue(item.getMandalName() != null ? item.getMandalName() : "");
            if ("submitted".equalsIgnoreCase(type)) {
                row.createCell(2).setCellValue(item.getSubmittedDate() != null ? item.getSubmittedDate() : "");
                row.createCell(3).setCellValue(item.getSubmittedTime() != null ? item.getSubmittedTime() : "");
            }
        }

        for (int i = 0; i < cols.length; i++) {
            int width = "submitted".equalsIgnoreCase(type)
                    ? new int[]{35, 30, 18, 18}[i]
                    : 30;
            sheet.setColumnWidth(i, width * 256);
        }

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        wb.write(out);
        wb.close();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "reports_" + type + ".xlsx");
        headers.setContentLength(out.size());

        return ResponseEntity.ok().headers(headers).body(out.toByteArray());
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/reports/export/pdf")
    public ResponseEntity<byte[]> exportPdf(@RequestParam String type) throws Exception {
        List<MandalReportItem> items = "submitted".equalsIgnoreCase(type)
                ? buildSubmittedDetails()
                : buildPendingDetails();

        com.lowagie.text.Document document = new com.lowagie.text.Document(com.lowagie.text.PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        com.lowagie.text.pdf.PdfWriter.getInstance(document, out);
        document.open();

        com.lowagie.text.Font titleFont = new com.lowagie.text.Font(com.lowagie.text.Font.HELVETICA, 16, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font headerFont = new com.lowagie.text.Font(com.lowagie.text.Font.HELVETICA, 12, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font bodyFont = new com.lowagie.text.Font(com.lowagie.text.Font.HELVETICA, 10, com.lowagie.text.Font.NORMAL);

        document.add(new com.lowagie.text.Paragraph(type.toUpperCase() + " VILLAGES REPORT", titleFont));
        document.add(new com.lowagie.text.Paragraph(" "));

        com.lowagie.text.pdf.PdfPTable table = new com.lowagie.text.pdf.PdfPTable("submitted".equalsIgnoreCase(type) ? 4 : 2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);

        String[] headers = "submitted".equalsIgnoreCase(type)
                ? new String[]{"Village Name", "Mandal Name", "Submitted Date", "Submitted Time"}
                : new String[]{"Village Name", "Mandal Name"};
        for (String h : headers) {
            table.addCell(new com.lowagie.text.Phrase(h, headerFont));
        }

        for (MandalReportItem item : items) {
            table.addCell(new com.lowagie.text.Phrase(item.getVillageName() != null ? item.getVillageName() : "", bodyFont));
            table.addCell(new com.lowagie.text.Phrase(item.getMandalName() != null ? item.getMandalName() : "", bodyFont));
            if ("submitted".equalsIgnoreCase(type)) {
                table.addCell(new com.lowagie.text.Phrase(item.getSubmittedDate() != null ? item.getSubmittedDate() : "", bodyFont));
                table.addCell(new com.lowagie.text.Phrase(item.getSubmittedTime() != null ? item.getSubmittedTime() : "", bodyFont));
            }
        }

        document.add(table);
        document.close();

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_PDF);
        httpHeaders.setContentDispositionFormData("attachment", "reports_" + type + ".pdf");
        httpHeaders.setContentLength(out.size());

        return ResponseEntity.ok().headers(httpHeaders).body(out.toByteArray());
    }

    private org.apache.poi.ss.usermodel.CellStyle getHeaderStyle(org.apache.poi.ss.usermodel.Workbook wb) {
        org.apache.poi.ss.usermodel.CellStyle style = wb.createCellStyle();
        org.apache.poi.ss.usermodel.Font font = wb.createFont();
        font.setBold(true);
        font.setColor(org.apache.poi.ss.usermodel.IndexedColors.WHITE.getIndex());
        style.setFont(font);
        style.setFillForegroundColor(org.apache.poi.ss.usermodel.IndexedColors.DARK_BLUE.getIndex());
        style.setFillPattern(org.apache.poi.ss.usermodel.FillPatternType.SOLID_FOREGROUND);
        return style;
    }

    private List<MandalReportItem> buildSubmittedDetails() {
        List<Village> allVillages = villageRepository.findAll();
        return allVillages.stream()
                .filter(v -> complaintRepository.countByUserVillage(v) > 0)
                .map(v -> {
                    List<Complaint> complaints = complaintRepository.findByUserVillage(v);
                    Complaint latest = complaints.get(0);
                    String date = null;
                    String time = null;
                    if (latest.getCreatedAt() != null) {
                        LocalDateTime dt = latest.getCreatedAt();
                        date = dt.toLocalDate().toString();
                        time = dt.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm:ss"));
                    }
                    return new MandalReportItem(
                            v.getName(),
                            v.getMandal() != null ? v.getMandal().getName() : "N/A",
                            date,
                            time
                    );
                })
                .toList();
    }

    private List<MandalReportItem> buildPendingDetails() {
        List<Village> allVillages = villageRepository.findAll();
        return allVillages.stream()
                .filter(v -> complaintRepository.countByUserVillage(v) == 0)
                .map(v -> new MandalReportItem(
                        v.getName(),
                        v.getMandal() != null ? v.getMandal().getName() : "N/A",
                        null,
                        null
                ))
                .toList();
    }
}
