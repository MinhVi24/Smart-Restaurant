package service;

import dao.TableDAO;
import model.Tables;
import java.util.List;

/**
 * Service quản lý bàn dành cho Staff.
 * Controller chỉ gọi service này, không gọi DAO trực tiếp.
 */
public class StaffTableService {

    private final TableDAO tableDAO;

    public StaffTableService() {
        this.tableDAO = new TableDAO();
    }

    /**
     * Lấy tất cả bàn (mọi trạng thái, mọi khu vực)
     */
    public List<Tables> getAllTables() {
        return tableDAO.findAll();
    }

    /**
     * Lọc bàn theo khu vực và/hoặc trạng thái.
     * - Nếu cả 2 đều null/blank → trả tất cả
     * - Nếu chỉ có status → lọc theo status
     * - Nếu chỉ có area → lọc theo area
     * - Nếu cả 2 → lọc theo status, sau đó filter thêm area
     */
    public List<Tables> getTablesByFilter(String area, String status) {
        boolean hasArea = area != null && !area.isBlank();
        boolean hasStatus = status != null && !status.isBlank();

        if (hasStatus) {
            List<Tables> tables = tableDAO.findByStatus(status);
            if (hasArea) {
                tables.removeIf(t -> !area.equals(t.getArea()));
            }
            return tables;
        }

        if (hasArea) {
            return tableDAO.findByArea(area);
        }

        return tableDAO.findAll();
    }

    /**
     * Lấy danh sách khu vực (distinct) để dropdown filter
     */
    public List<String> getDistinctAreas() {
        return tableDAO.findDistinctAreas();
    }
}
