package dao;

import java.util.Map;

public class StatsDao {
	// 11 개 chart메서드
	private Map<String, Object> selectOrderTotalCntByYM(String fromYM, String toYM){
		String sql = """
					SELECT t.ym
							, SUM(t.cnt) OVER(ORDER BY t.ym ASC)
					FROM
					    (SELECT TO_CHAR(createdate, 'YYYY-MM') ym, COUNT(*) cnt
					    FROM orders
					    WHERE createdate BETWEEN TO_DATE('2025-01-01', 'YYYY-MM-DD')
					    AND TO_DATE('2025-12-31', 'YYYY-MM-DD')
					    GROUP BY TO_CHAR(createdate, 'YYYY-MM')) t
				""";
		
		return null;
		
	}
	
	public Map<String, Object> selectOrderTotalPriceByYM(String fromYM, String toYM){
		String sql = """
					SELECT t.ym
							, SUM(t.total) OVER(ORDER BY t.ym ASC)
					FROM
					    (SELECT TO_CHAR(createdate, 'YYYY-MM') ym, SUM(order_price) total
					    FROM orders
					    WHERE createdate BETWEEN TO_DATE('2025-01-01', 'YYYY-MM-DD')
					    AND TO_DATE('2025-12-31', 'YYYY-MM-DD')
					    GROUP BY TO_CHAR(createdate, 'YYYY-MM')) t
				""";
		return null;
	}
}
