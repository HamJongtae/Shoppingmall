package kr.util;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

public class FileUtil {
	//업로드 상대경로
	private static final String UPLOAD_PATH = "/upload";
	//파일 생성
	public static String createFile(
			   HttpServletRequest request,String param)
			     throws IllegalStateException,IOException,
	                                     ServletException{
		//업로드 절대경로
		String upload = 
		request.getServletContext().getRealPath(UPLOAD_PATH);
		//파일 정보 얻기
		Part part = request.getPart(param);
		//파일명 구하기
		String filename = part.getSubmittedFileName();
		if(!filename.isEmpty()) {
			//파일 중복 방지를 위해 임의의 값_원래 파일명 형식으로 변경
			filename = UUID.randomUUID()+"_"+filename;
			part.write(upload+"/"+filename);
		}
		return filename;
	}
	
	//다중파일 생성
	public static String createFiles(HttpServletRequest request) throws IllegalStateException,IOException, ServletException{
		//업로드 절대경로
		String upload = request.getServletContext().getRealPath(UPLOAD_PATH);
		
		//폼 정보 얻기
		// parts에는 모든 폼의 모든 부분이 들어가기 때문에 null이 아닌 값만 처리해야 한다.
		// 처리 속도가 너무 느릴 것으로 예상되어 다 나은 방법을 찾아야 한다.
		Collection<Part> parts = request.getParts();
		
		//파일명 ,로 구분해서 구하기
		StringBuilder totalFileName = new StringBuilder();
		for(Part part : parts) {
			if(part.getSubmittedFileName()!=null) {
				String filename = part.getSubmittedFileName();
				if(filename!=null&&!filename.isEmpty()) {
					//파일 중복 방지를 위해 임의의 값_원래 파일명 형식으로 변경
					filename = UUID.randomUUID()+""+filename.substring(filename.lastIndexOf("."));
					part.write(upload+"/"+filename);
				}
				totalFileName.append(filename).append(",");
			}
		}
		// 마지막 , 지우기
	    if (totalFileName.length() > 0) {
	        totalFileName.setLength(totalFileName.length() - 1);
	    }
		
		return totalFileName.toString();
	}
	
	//파일 삭제
	public static void removeFile(
			               HttpServletRequest request,
			                             String filename) {
		if(filename!=null) {
			//업로드 절대경로
			String upload = 
			request.getServletContext().getRealPath(UPLOAD_PATH);
			File file = new File(upload+"/"+filename);
			if(file.exists()) file.delete();
		}
	}
}