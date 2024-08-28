<%@ page language="java" contentType="application/json; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.alibaba.fastjson2.JSON" %>

<%
    class Result {
        public int code;
        public String message;
    }

    response.setHeader("Content-Type", "application/json;charset=UTF-8");

   String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
  	String username = "test";
  	String password = "1234";
  	Connection con=null;
  	PreparedStatement statement=null;
  	ResultSet rs=null;
     System.out.println("hello");
    Result result = new Result();
    try {
        Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(DATABASE_URL,username,password);
            String userName = request.getParameter("username");
            String email = request.getParameter("email");
            String inputPassword = request.getParameter("password");
            System.out.println(userName+":"+email+":"+inputPassword);
            String sql = "SELECT * FROM app_user";
            statement = con.prepareStatement(sql);
            rs = statement.executeQuery();
             while (rs.next()) {
               String dbEmail = rs.getString("email");
               System.out.println(dbEmail+" : "+email);
               if (dbEmail.equalsIgnoreCase(email)) {
                 result.code = -2;
                 result.message = "email already used";
                 break;
              }
             }
             if(result.code!=-2){
               sql = "INSERT INTO app_user(full_name,email,password)VALUES('"+userName+"','"+email+"','"+inputPassword+"');";
               statement = con.prepareStatement(sql);
               statement.execute();
               result.code = 200;
               result.message = "user added successfully";
            }
    } catch (Exception e) {
        e.printStackTrace();
        result.code = -500;
        result.message = e.getMessage();
    }finally{
        rs.close();
        statement.close();
        con.close();
    }

    String rsStr = JSON.toJSONString(result);
    out.print(rsStr);
%>