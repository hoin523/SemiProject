package com.command.write;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.beans.CustomerDAO;
import com.lec.beans.CustomerDTO;
import com.lec.beans.PetDAO;
import com.lec.beans.PetDTO;

public class PetListCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		PetDAO dao = new PetDAO(); // DAO
		PetDTO [] arr = null;
		
		CustomerDAO cdao = new CustomerDAO();
		CustomerDTO [] carr = null;
		
		int cus_num = Integer.parseInt((String) (session.getAttribute("c_num")));
		
		try {
			arr = dao.selectByUid(cus_num);
			request.setAttribute("list", arr);
			
			carr = cdao.selectByUid(cus_num);
			request.setAttribute("clist", carr);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	

}
