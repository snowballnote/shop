package dao;

import java.sql.*;
import java.util.*;
import dto.Outid;

public class OutidDao {
    // 탈퇴 회원 목록 조회 (페이징)
    public List<Outid> selectOutIdListByPage(int beginRow, int rowPerPage) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Outid> list = new ArrayList<>();

        String sql = """
            SELECT id, memo, createdate
            FROM outid
            ORDER BY createdate DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        conn = DBConnection.getConn();
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, beginRow);
        stmt.setInt(2, rowPerPage);
        rs = stmt.executeQuery();

        while (rs.next()) {
            Outid o = new Outid();
            o.setId(rs.getString("id"));
            o.setMemo(rs.getString("memo"));
            o.setCreatedate(rs.getString("createdate"));
            list.add(o);
        }

        rs.close();
        stmt.close();
        conn.close();

        return list;
    }

    // 전체 탈퇴회원 수 (페이징 계산용)
    public int countOutId() throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int total = 0;

        String sql = "SELECT COUNT(*) cnt FROM outid";

        conn = DBConnection.getConn();
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        if (rs.next()) total = rs.getInt("cnt");

        rs.close();
        stmt.close();
        conn.close();

        return total;
    }
}
