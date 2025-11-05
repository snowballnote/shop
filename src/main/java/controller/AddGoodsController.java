package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MulticastSocket;
import java.nio.file.Files;
import java.util.UUID;

import dto.Emp;
import dto.Goods;
import dto.GoodsImg;


@WebServlet("/emp/addGoods")
public class AddGoodsController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/emp/addGoods.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String goodsName = request.getParameter("goodsName");
		String goodsPrice = request.getParameter("goodsPrice");
		String pointRate = request.getParameter("pointRate");
		// 파일업로드는 Part 라이브러리 사용
		Part part = request.getPart("goodsImg");
		String originName = part.getSubmittedFileName();		
		String fileName = UUID.randomUUID().toString().replace("-", "");
		
		// fileName += originName의 확장자
		fileName +=	originName.substring(originName.lastIndexOf("."));
		String contentType = part.getContentType();
		long filesize = part.getSize();
		
		System.out.println("originName"+ originName);
		System.out.println("fileName" + fileName);
		System.out.println("contentType" + contentType);
		System.out.println("filesize" + filesize);
		
		if(!(contentType.equals("Img/png") || contentType.equals("Img/jpeg") || contentType.equals("Img/gif"))) {
			System.out.println("png, jpg, gif 파일만 허용");
			response.sendRedirect(request.getContextPath() + "/emp/addGoods");
			return;
		}
		
		Emp loginEmp = (Emp)(request.getSession().getAttribute("loginEmp"));
		
		Goods goods = new Goods();
		goods.setGoodsName(goodsName);
		goods.setGoodsPrice(Integer.parseInt(goodsPrice));
		goods.setPointRate(Double.parseDouble(pointRate));
		goods.setEmpCode(loginEmp.getEmpCode());
		int goodsCode = 0; // insertGoods() 
		
		GoodsImg goodsImg = new GoodsImg();
		goodsImg.setGoodsCode(goodsCode);
		goodsImg.setFileName(fileName);
		goodsImg.setOriginName(originName);
		goodsImg.setFilesize(filesize);
		// insertGoodsImg()
		
		// 이미지를 저장
		String realPath =request.getServletContext().getRealPath("upload");
		File saveFile = new File(realPath, fileName); // 빈(스트림) 파일
		InputStream is = part.getInputStream();
		OutputStream os = Files.newOutputStream(saveFile.toPath());
		
		// 스트림을 is -> os 전송
		is.transferTo(os);
	}
}
