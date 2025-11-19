package controller;

import java.io.IOException;
import java.util.List;

import dao.StudentDAO;
import model.Student;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/student")
public class StudentController extends HttpServlet {
    
    private StudentDAO studentDAO;
    
    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            case "search":
                searchStudents(request, response);
                break;
            case "sort":
                sortStudents(request, response);
                break;
            case "filter":
                filterStudents(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "insert":
                insertStudent(request, response);
                break;
            case "update":
                updateStudent(request, response);
                break;
        }
    }
    
    // List all students (with pagination)
    private void listStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // EXERCISE 8: Pagination logic
        String pageParam = request.getParameter("page");
        int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
        int recordsPerPage = 10;
        
        // Calculate offset
        int offset = (currentPage - 1) * recordsPerPage;
        
        // Get paginated data
        List<Student> students = studentDAO.getStudentsPaginated(offset, recordsPerPage);
        int totalRecords = studentDAO.getTotalStudents();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        // Handle edge cases
        if (currentPage < 1) currentPage = 1;
        if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;
        
        // Set attributes
        request.setAttribute("students", students);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-list.jsp");
        dispatcher.forward(request, response);
    }
    
    // Show form for new student
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-form.jsp");
        dispatcher.forward(request, response);
    }
    
    // Show form for editing student
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Student existingStudent = studentDAO.getStudentById(id);
        
        request.setAttribute("student", existingStudent);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-form.jsp");
        dispatcher.forward(request, response);
    }
    
    // Insert new student
    private void insertStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        String studentCode = request.getParameter("studentCode");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String major = request.getParameter("major");
        
        Student newStudent = new Student(studentCode, fullName, email, major);
        
        // EXERCISE 6: Validate student
        if (!validateStudent(newStudent, request)) {
            request.setAttribute("student", newStudent);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-form.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        if (studentDAO.addStudent(newStudent)) {
            response.sendRedirect("student?action=list&message=Student added successfully");
        } else {
            response.sendRedirect("student?action=list&error=Failed to add student");
        }
    }
    
    // Update student
    private void updateStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String studentCode = request.getParameter("studentCode");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String major = request.getParameter("major");
        
        Student student = new Student(studentCode, fullName, email, major);
        student.setId(id);
        
        // EXERCISE 6: Validate student
        if (!validateStudent(student, request)) {
            request.setAttribute("student", student);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-form.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        if (studentDAO.updateStudent(student)) {
            response.sendRedirect("student?action=list&message=Student updated successfully");
        } else {
            response.sendRedirect("student?action=list&error=Failed to update student");
        }
    }
    
    // Delete student
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (studentDAO.deleteStudent(id)) {
            response.sendRedirect("student?action=list&message=Student deleted successfully");
        } else {
            response.sendRedirect("student?action=list&error=Failed to delete student");
        }
    }
    
    // EXERCISE 5: Search students
    private void searchStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        
        List<Student> students;
        if (keyword == null || keyword.trim().isEmpty()) {
            students = studentDAO.getAllStudents();
        } else {
            students = studentDAO.searchStudents(keyword);
            request.setAttribute("keyword", keyword);
        }
        
        request.setAttribute("students", students);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-list.jsp");
        dispatcher.forward(request, response);
    }
    
    // EXERCISE 6: Validate student
    private boolean validateStudent(Student student, HttpServletRequest request) {
        boolean isValid = true;
        
        // Validate student code
        String studentCode = student.getStudentCode();
        if (studentCode == null || studentCode.trim().isEmpty()) {
            request.setAttribute("errorCode", "Student code is required");
            isValid = false;
        } else if (!studentCode.matches("[A-Z]{2}[0-9]{3,}")) {
            request.setAttribute("errorCode", "Invalid format. Use 2 letters + 3+ digits (e.g., SV001)");
            isValid = false;
        }
        
        // Validate full name
        String fullName = student.getFullName();
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("errorName", "Full name is required");
            isValid = false;
        } else if (fullName.trim().length() < 2) {
            request.setAttribute("errorName", "Full name must be at least 2 characters");
            isValid = false;
        }
        
        // Validate email (only if provided)
        String email = student.getEmail();
        if (email != null && !email.trim().isEmpty()) {
            if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                request.setAttribute("errorEmail", "Invalid email format");
                isValid = false;
            }
        }
        
        // Validate major
        String major = student.getMajor();
        if (major == null || major.trim().isEmpty()) {
            request.setAttribute("errorMajor", "Major is required");
            isValid = false;
        }
        
        return isValid;
    }
    
    // EXERCISE 7: Sort students
    private void sortStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order");
        
        List<Student> students = studentDAO.getStudentsSorted(sortBy, order);
        
        request.setAttribute("students", students);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("order", order);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-list.jsp");
        dispatcher.forward(request, response);
    }
    
    // EXERCISE 7: Filter students by major
    private void filterStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String major = request.getParameter("major");
        
        List<Student> students;
        if (major == null || major.trim().isEmpty()) {
            students = studentDAO.getAllStudents();
        } else {
            students = studentDAO.getStudentsByMajor(major);
            request.setAttribute("selectedMajor", major);
        }
        
        request.setAttribute("students", students);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-list.jsp");
        dispatcher.forward(request, response);
    }
}
