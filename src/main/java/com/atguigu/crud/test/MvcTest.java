package com.atguigu.crud.test;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.*;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @Description
 * @Author Satan
 * @Date 2020/2/210:39
 * @Version 1.0
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcher-servlet.xml"})
public class MvcTest {
	// 传入Springmvc的ioc
	@Autowired
	WebApplicationContext context;
	// 虚拟mvc请求，获取到处理结果。
	MockMvc mockMvc;

	@Before
	public void initMockMvc(){
		mockMvc= MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception {
		ResultActions resultActions = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "1"));
		MvcResult mvcResult = resultActions.andReturn();
		MockHttpServletRequest request = mvcResult.getRequest();
		PageInfo pageInfo =(PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码："+pageInfo.getPageNum());
		System.out.println("总页码："+pageInfo.getPages());
		System.out.println("总记录数："+pageInfo.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] navigatepageNums = pageInfo.getNavigatepageNums();
		for (int navigatepageNum : navigatepageNums) {
			System.out.print(navigatepageNum);
		}
		System.out.println();
		List<Employee> list = pageInfo.getList();
		for (Employee employee : list) {
			System.out.println(employee);
		}


	}


}
