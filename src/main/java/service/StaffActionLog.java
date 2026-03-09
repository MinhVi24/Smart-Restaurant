package service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * POJO lưu thông tin một thao tác của staff (in-memory, không cần DB).
 */
public class StaffActionLog {

    private final Date timestamp;
    private final String staffName;
    private final String actionType;
    private final String targetType;
    private final Integer targetId;
    private final String details;

    public StaffActionLog(String staffName, String actionType, String targetType, Integer targetId, String details) {
        this.timestamp = new Date();
        this.staffName = staffName;
        this.actionType = actionType;
        this.targetType = targetType;
        this.targetId = targetId;
        this.details = details;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public String getStaffName() {
        return staffName;
    }

    public String getActionType() {
        return actionType;
    }

    public String getTargetType() {
        return targetType;
    }

    public Integer getTargetId() {
        return targetId;
    }

    public String getDetails() {
        return details;
    }

    // =========================================================================
    // Static in-memory storage (thread-safe, max 200 entries)
    // =========================================================================

    private static final List<StaffActionLog> logs = Collections.synchronizedList(new ArrayList<>());
    private static final int MAX_SIZE = 200;

    /**
     * Ghi một thao tác mới vào lịch sử.
     */
    public static void record(String staffName, String actionType, String targetType, Integer targetId,
            String details) {
        if (logs.size() >= MAX_SIZE) {
            logs.remove(0);
        }
        logs.add(new StaffActionLog(staffName, actionType, targetType, targetId, details));
    }

    /**
     * Lấy toàn bộ lịch sử (mới nhất trước).
     */
    public static List<StaffActionLog> getAll() {
        List<StaffActionLog> reversed = new ArrayList<>(logs);
        Collections.reverse(reversed);
        return reversed;
    }
}
