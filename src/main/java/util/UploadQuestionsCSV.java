package util;

import java.io.*;
import java.util.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import javax.servlet.annotation.WebServlet;
import models.questions.*;

@WebServlet("/UploadQuestionsCSV")
public class UploadQuestionsCSV extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String uploadedFilename = null;
	private static String UPLOAD_PATH = "D:\\uploads\\";

	public UploadQuestionsCSV() {
		super();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		doPost(request, response);
	}

	private void readData(String quizid) {
		if (uploadedFilename == null)
			return;
		File file = new File(uploadedFilename);
		try (BufferedReader reader = new BufferedReader(new FileReader(file));) {
			String line = reader.readLine();
			// int id = Integer.parseInt(quizid);

			int i = 1;
			while ((line = reader.readLine()) != null) {
				String[] qs = line.split(",");
				db.Database.addQuestion(new MCQ(qs[0], new String[] { qs[1], qs[2], qs[3], qs[4] }, qs[5]),
						Integer.parseInt(quizid), i);
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace(System.out);
		} finally {
			file.delete();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String quizid = request.getParameter("quizid");
		System.out.println("QUIZID: " + quizid);
		String file_name = null;
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
		if (!isMultipartContent) {
			return;
		}
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List<FileItem> fields = upload.parseRequest(request);
			Iterator<FileItem> it = fields.iterator();
			if (!it.hasNext()) {
				return;
			}

			while (it.hasNext()) {
				FileItem fileItem = it.next();
				System.out.println("Name: " + fileItem.getName());
				boolean isFormField = fileItem.isFormField();
				if (isFormField) {
					String fieldname = fileItem.getFieldName();
					String fieldvalue = fileItem.getString();
					if (fieldname.equals("quizid"))
						quizid = fieldvalue;
					if (file_name == null) {
						if (fileItem.getFieldName().equals("questionsFile")) {
							file_name = fileItem.getString();
						}
					}
				} else {
					if (fileItem.getSize() > 0) {
						uploadedFilename = UPLOAD_PATH + fileItem.getName();
						// uploadedFilename = "D:\\uploads\\" + fileItem.getName();
						fileItem.write(new File(uploadedFilename));
						readData(quizid);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			String referer = request.getHeader("referer");
			int index = referer.indexOf("quiz.jsp");
			response.sendRedirect(referer.substring(index));
			out.close();
		}
	}
}