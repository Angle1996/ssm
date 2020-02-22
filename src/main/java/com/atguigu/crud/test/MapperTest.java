package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Random;
import java.util.UUID;

/**
 * @Description
 * @Author Satan
 * @Date 2020/2/2020:00
 * @Version 1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	SqlSession sqlSession;
	@Test
	public void testCRUD(){

		System.out.println(departmentMapper);
		departmentMapper.insertSelective(new Department(null, "开发部"));
		departmentMapper.insertSelective(new Department(null, "设计部"));
	}
	@Test
	public void insertBatch(){
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 500; i++) {
			int j= (int) (Math.round(Math.random()*1)+1);
			String g=String.valueOf((int) Math.floor(Math.random()*2));
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			employeeMapper.insertSelective(new Employee(null,uid, g, uid+"@atguigu.com", j,null));
		}
		System.out.println("插入完成");
	}

	@Test
	public void test(){
		for (int i = 0; i < 100; i++) {
			System.out.println((int) Math.floor(Math.random()*2));
		}

	}
}
