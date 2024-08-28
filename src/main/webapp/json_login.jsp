<%@ page language="java" contentType="application/json; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.alibaba.fastjson2.JSON" %>

<%
    class Result {
        public int code;
        public String message;
        public int userId;
    }

    response.setHeader("Content-Type", "application/json;charset=UTF-8");

   String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
  	String username = "test";
  	String password = "1234";

    Result result = new Result();
    try {
        Class.forName("org.postgresql.Driver");
        try (Connection con = DriverManager.getConnection(DATABASE_URL,username,password)) {

            String email = request.getParameter("email");
            String inputPassword = request.getParameter("password");

            if (email == null || email.trim().isEmpty() || inputPassword == null || inputPassword.trim().isEmpty()) {
                result.code = -3;
                result.message = "sid or password not passed!";
                result.userId= -1;
            } else {
                String sql = "SELECT * FROM app_user WHERE email = ? AND password = ?";
                try (PreparedStatement statement = con.prepareStatement(sql)) {
                    statement.setString(1, email);
                    statement.setString(2, inputPassword);

                    try (ResultSet rs = statement.executeQuery()) {
                        if (rs.next()) {
                            String dbPassword = rs.getString("password");
                            int id = rs.getInt("user_id");
                            if (dbPassword == null || !dbPassword.equals(inputPassword)) {
                                result.code = -2;
                                result.message = "password not correct!";
                                result.userId= -1;
                            } else {
                                result.code = 200;
                                result.message = "ok";
                                result.userId= id;
                            }
                        } else {
                            result.code = -1;
                            result.message = "sid not exist!";
                            result.userId= -1;
                        }
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        result.code = -500;
        result.message = "Server error!";
        result.userId= -1;
    }

    String rsStr = JSON.toJSONString(result);
    out.print(rsStr);
%>