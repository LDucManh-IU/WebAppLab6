STUDENT INFORMATION:<br>
Name: Lưu Đức Mạnh<br>
Student ID: ITITIU23016<br>

COMPLETED EXERCISES:<br>
[x] Exercise 1: Database & User Model<br>
[x] Exercise 2: User Model & DAO<br>
[x] Exercise 3: Login/Logout Controllers<br>
[x] Exercise 4: Views & Dashboard<br>
[x] Exercise 5: Authentication Filter<br>
[x] Exercise 6: Admin Authorization Filter<br>
[x] Exercise 7: Role-Based UI<br>
[x] Exercise 8: Change Password<br>

AUTHENTICATION COMPONENTS:<br>
- Models: User.java<br>
- DAOs: UserDAO.java<br>
- Controllers: LoginController.java, LogoutController.java, DashboardController.java<br>
- Filters: AuthFilter.java, AdminFilter.java<br>
- Views: login.jsp, dashboard.jsp, updated student-list.jsp, change-password.jsp<br>

TEST CREDENTIALS:<br>
Admin:<br>
- Username: admin<br>
- Password: password123<br>

Regular User:<br>
- Username: john<br>
- Password: password123<br>

FEATURES IMPLEMENTED:<br>
- User authentication with BCrypt<br>
- Session management<br>
- Login/Logout functionality<br>
- Dashboard with statistics<br>
- Authentication filter for protected pages<br>
- Admin authorization filter<br>
- Role-based UI elements<br>
- Password security<br>

SECURITY MEASURES:<br>
- BCrypt password hashing<br>
- Session regeneration after login<br>
- Session timeout (30 minutes)<br>
- SQL injection prevention (PreparedStatement)<br>
- Input validation<br>
- XSS prevention (JSTL escaping)<br>

KNOWN ISSUES:<br>


BONUS FEATURES:<br>


TIME SPENT: [3 hours]<br>

TESTING NOTES:<br>
