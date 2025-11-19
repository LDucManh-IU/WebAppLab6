<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - MVC</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
        }
        
        .navbar {
            background: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .navbar h2 {
            font-size: 20px;
            margin: 0;
        }
        
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .role-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .role-admin {
            background: #e74c3c;
        }
        
        .role-user {
            background: #3498db;
        }
        
        .btn-nav {
            padding: 8px 20px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s;
        }
        
        .btn-nav:hover {
            background: #2980b9;
        }
        
        .btn-logout {
            padding: 8px 20px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s;
        }
        
        .btn-logout:hover {
            background: #c0392b;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .content-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 32px;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-style: italic;
        }
        
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }
        
        tbody tr {
            transition: background-color 0.2s;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .actions {
            display: flex;
            gap: 10px;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        
        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        
        /* EXERCISE 5: Search form styles */
        .search-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 2px solid #e9ecef;
        }
        
        .search-box form {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .search-box input[type="text"] {
            flex: 1;
            min-width: 250px;
            padding: 10px 15px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .search-box input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .search-box button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .search-results-info {
            background-color: #e7f3ff;
            color: #004085;
            padding: 12px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #004085;
        }
        
        /* EXERCISE 7: Filter and sort styles */
        .filter-box {
            background-color: #fff3cd;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 2px solid #ffc107;
        }
        
        .filter-box form {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .filter-box select {
            padding: 10px 15px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        th a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        th a:hover {
            text-decoration: underline;
        }
        
        /* EXERCISE 8: Pagination styles */
        .pagination {
            margin: 30px 0;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .pagination a,
        .pagination strong {
            padding: 10px 15px;
            border: 2px solid #667eea;
            border-radius: 5px;
            text-decoration: none;
            color: #667eea;
            font-weight: 500;
            transition: all 0.3s;
            min-width: 45px;
            text-align: center;
        }
        
        .pagination a:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            transform: translateY(-2px);
        }
        
        .pagination strong {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .pagination-info {
            text-align: center;
            color: #666;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <h2>📚 Student Management System</h2>
        <div class="navbar-right">
            <div class="user-info">
                <span>Welcome, ${sessionScope.fullName}</span>
                <span class="role-badge role-${sessionScope.role}">
                    ${sessionScope.role}
                </span>
            </div>
            <a href="dashboard" class="btn-nav">Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="content-card">
        <h1>📚 Student List</h1>
        <p class="subtitle">MVC Pattern with Jakarta EE & JSTL</p>
        
        <!-- Success Message -->
        <c:if test="${not empty param.message}">
            <div class="message success">
                ✅ ${param.message}
            </div>
        </c:if>
        
        <!-- Error Message -->
        <c:if test="${not empty param.error}">
            <div class="message error">
                ❌ ${param.error}
            </div>
        </c:if>
        
        <!-- Add New Student Button - Admin only -->
        <c:if test="${sessionScope.role eq 'admin'}">
            <div style="margin-bottom: 20px;">
                <a href="student?action=new" class="btn btn-primary">
                    ➕ Add New Student
                </a>
            </div>
        </c:if>
        
        <!-- EXERCISE 5: Search Form -->
        <div class="search-box">
            <form action="student" method="get">
                <input type="hidden" name="action" value="search">
                <input type="text" 
                       name="keyword" 
                       placeholder="🔍 Search by code, name, or email..." 
                       value="${keyword}">
                <button type="submit" class="btn btn-primary">Search</button>
                <c:if test="${not empty keyword}">
                    <a href="student?action=list" class="btn btn-secondary">Clear Search</a>
                </c:if>
            </form>
        </div>
        
        <!-- EXERCISE 5: Search Results Message -->
        <c:if test="${not empty keyword}">
            <div class="search-results-info">
                🔍 Search results for: <strong>"${keyword}"</strong>
            </div>
        </c:if>
        
        <!-- EXERCISE 7: Filter by Major -->
        <div class="filter-box">
            <form action="student" method="get">
                <input type="hidden" name="action" value="filter">
                <label style="font-weight: 600;">Filter by Major:</label>
                <select name="major">
                    <option value="">All Majors</option>
                    <option value="Computer Science" ${selectedMajor == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                    <option value="Information Technology" ${selectedMajor == 'Information Technology' ? 'selected' : ''}>Information Technology</option>
                    <option value="Software Engineering" ${selectedMajor == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
                    <option value="Business Administration" ${selectedMajor == 'Business Administration' ? 'selected' : ''}>Business Administration</option>
                </select>
                <button type="submit" class="btn btn-primary">Apply Filter</button>
                <c:if test="${not empty selectedMajor}">
                    <a href="student?action=list" class="btn btn-secondary">Clear Filter</a>
                </c:if>
            </form>
        </div>
        
        <c:if test="${not empty selectedMajor}">
            <div class="search-results-info">
                🎓 Filtered by major: <strong>${selectedMajor}</strong>
            </div>
        </c:if>
        
        <!-- Student Table -->
        <c:choose>
            <c:when test="${not empty students}">
                <table>
                    <thead>
                        <tr>
                            <th>
                                <a href="student?action=sort&sortBy=id&order=${sortBy == 'id' && order == 'asc' ? 'desc' : 'asc'}">
                                    ID ${sortBy == 'id' ? (order == 'asc' ? '▲' : '▼') : ''}
                                </a>
                            </th>
                            <th>
                                <a href="student?action=sort&sortBy=student_code&order=${sortBy == 'student_code' && order == 'asc' ? 'desc' : 'asc'}">
                                    Student Code ${sortBy == 'student_code' ? (order == 'asc' ? '▲' : '▼') : ''}
                                </a>
                            </th>
                            <th>
                                <a href="student?action=sort&sortBy=full_name&order=${sortBy == 'full_name' && order == 'asc' ? 'desc' : 'asc'}">
                                    Full Name ${sortBy == 'full_name' ? (order == 'asc' ? '▲' : '▼') : ''}
                                </a>
                            </th>
                            <th>
                                <a href="student?action=sort&sortBy=email&order=${sortBy == 'email' && order == 'asc' ? 'desc' : 'asc'}">
                                    Email ${sortBy == 'email' ? (order == 'asc' ? '▲' : '▼') : ''}
                                </a>
                            </th>
                            <th>
                                <a href="student?action=sort&sortBy=major&order=${sortBy == 'major' && order == 'asc' ? 'desc' : 'asc'}">
                                    Major ${sortBy == 'major' ? (order == 'asc' ? '▲' : '▼') : ''}
                                </a>
                            </th>
                            <c:if test="${sessionScope.role eq 'admin'}">
                                <th>Actions</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${students}">
                            <tr>
                                <td>${student.id}</td>
                                <td><strong>${student.studentCode}</strong></td>
                                <td>${student.fullName}</td>
                                <td>${student.email}</td>
                                <td>${student.major}</td>
                                
                                <!-- Action buttons - Admin only -->
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <td>
                                        <div class="actions">
                                            <a href="student?action=edit&id=${student.id}" class="btn btn-secondary">
                                                ✏️ Edit
                                            </a>
                                            <a href="student?action=delete&id=${student.id}" 
                                               class="btn btn-danger"
                                               onclick="return confirm('Are you sure you want to delete this student?')">
                                                🗑️ Delete
                                            </a>
                                        </div>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <!-- EXERCISE 8: Pagination Controls -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <!-- Previous button -->
                        <c:if test="${currentPage > 1}">
                            <a href="student?action=list&page=${currentPage - 1}">« Previous</a>
                        </c:if>
                        
                        <!-- Page numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <strong>${i}</strong>
                                </c:when>
                                <c:otherwise>
                                    <a href="student?action=list&page=${i}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        
                        <!-- Next button -->
                        <c:if test="${currentPage < totalPages}">
                            <a href="student?action=list&page=${currentPage + 1}">Next »</a>
                        </c:if>
                    </div>
                    
                    <div class="pagination-info">
                        Showing page ${currentPage} of ${totalPages}
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <h3>No students found</h3>
                    <p>Start by adding a new student</p>
                </div>
            </c:otherwise>
        </c:choose>
        </div>
    </div>
</body>
</html>
