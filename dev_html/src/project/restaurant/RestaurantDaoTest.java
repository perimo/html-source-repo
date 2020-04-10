package project.restaurant;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;

class RestaurantDaoTest {
	RestaurantDao rdao = new RestaurantDao();
	List<Map<String, Object>> rList = null;
	@Test
	void testProcRestaurant() {
		assertEquals(5, rdao.procRestList().size());
		assertSame(rList, rdao.procRestList());
	}

}
