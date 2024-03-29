package backend;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionService {
    public void login(HttpServletRequest request, HttpServletResponse response, int sin, String userType) {
        try {
            HttpSession session = request.getSession();
            session.setAttribute("sin", sin);
            session.setAttribute("userType", userType);
            if (userType.equals("customer")) {
                response.sendRedirect("home-customer.jsp");
            } else if (userType.equals("employee")) {
                response.sendRedirect("home-employee.jsp");
            }
        } catch (IOException e) {
            System.out.println("Error logging in");
            e.printStackTrace();
        }
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("index.jsp");
        } catch (IOException e) {
            System.out.println("Error logging out");
            e.printStackTrace();
        }
    }

    public void authenticateCustomer(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();

            if (session.getAttribute("sin") == null) {
                response.sendRedirect("index.jsp");
            }

            if (session.getAttribute("userType") == null) {
                response.sendRedirect("index.jsp");
            }

            if (!session.getAttribute("userType").equals("customer")) {
                response.sendRedirect("index.jsp");
            }
        } catch (IOException e) {
            System.out.println("Error authenticating customer");
            e.printStackTrace();
        }
    }

    public void authenticateEmployee(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();

            if (session.getAttribute("sin") == null) {
                response.sendRedirect("index.jsp");
            }

            if (session.getAttribute("userType") == null) {
                response.sendRedirect("index.jsp");
            }

            if (!session.getAttribute("userType").equals("employee")) {
                response.sendRedirect("index.jsp");
            }
        } catch (IOException e) {
            System.out.println("Error authenticating employee");
            e.printStackTrace();
        }
    }
}
