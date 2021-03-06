package com.command.write;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.ProductDAO;

public class ShopDeleteCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		ProductDAO dao = new ProductDAO();
		
		int pNum = Integer.parseInt(request.getParameter("pNum"));
		System.out.println(pNum);
		try {
			cnt = dao.deleteByNum(pNum);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("result", cnt);
	}
}
