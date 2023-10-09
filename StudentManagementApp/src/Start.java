import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import com.student.manage.Student;
import com.student.manage.StudentDao;

public class Start {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		System.out.println("welcome to student management app");
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		while (true) {
			System.out.println("press 1 to add student");
			System.out.println("press 2 to delete student");
			System.out.println("press 3 to display student");
			System.out.println("press 4 to exit app");
			int c = Integer.parseInt(br.readLine());
			if (c == 1) {
				System.out.println("enter user name - ");
				String name = br.readLine();
				System.out.println("enter user phone - ");
				String phone = br.readLine();
				System.out.println("enter user city - ");
				String city = br.readLine();
				Student st = new Student(name, phone, city);
				boolean answer = StudentDao.insertStudentToDB(st);
				if(answer) {
					System.out.println("student added successfully");
				}
				else {
					System.out.println("something went wrong try again..");
				}
				System.out.println(st);
				
			} else if (c == 2) {
				//delete user by id
				System.out.println("enter student id to delete : ");
				int userId = Integer.parseInt(br.readLine());
				boolean answer = StudentDao.deleteStudent(userId);
				if(answer) {
					System.out.println("student deleted successfully");
				}
				else {
					System.out.println("something went wrong try again..");
				}
			} else if (c == 3) {
					StudentDao.showAllStudent();
			} else if (c == 4) {
				break;
			} else {

			}
		}
		System.out.println("thank you for using my application\nsee you soon...");
	}

}
