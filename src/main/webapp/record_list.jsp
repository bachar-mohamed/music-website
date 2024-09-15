<sql:query var="rs" dataSource="jdbc/mmas">
</sql:query>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
    <%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
       @import url('https://fonts.googleapis.com/css2?family=Playwrite+CO:wght@100..400&family=Playwrite+NL:wght@100..400&family=Playwrite+PT:wght@100..400&family=Work+Sans:ital,wght@0,100..900;1,100..900&display=swap');
       @import url('https://fonts.googleapis.com/css2?family=Playwrite+IN:wght@100..400&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap');
    </style>
    <title>Foundation | Welcome</title>
    <link rel="stylesheet" href="Css/list_style.css" type="text/css"/>
    <script src="JS/pageScript.js" defer></script>
  </head>
<body>
   <header>
       <h1>music library</h1>
   </header>
 <main>
 <section>
 <ul>
     <%

    String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
	String username = "test";
	String password = "1234";
	String userId = request.getParameter("id");

	try {

             Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(DATABASE_URL,username,password);
            PreparedStatement statement=null;
            String sql="";
            String recordNameParam = request.getParameter("record_title");
            String recordName="";
            String founder="";
            String coverUrl="";
            sql = "SELECT rec_name,founder,cover_url FROM record_label WHERE rec_name ILIKE ? AND user_id="+userId+";";
             System.out.println(sql);
             statement = con.prepareStatement(sql);
             statement.setString(1,recordNameParam+"%");
            ResultSet rs = statement.executeQuery();
            boolean result = false;
            while(rs.next())
            {
                result = true;
                recordName=rs.getString("rec_name");
                founder=rs.getString("founder");
                coverUrl = "background-image:url('."+rs.getString("cover_url")+"')";
    %>
                <li>
                <div class="img_container" style=<%=coverUrl.replace(" ","/")%>>
                     <form  action="record_info.jsp" method="get">
                     <input type="hidden" name="id" value=<%=userId %>>
                     <input type="hidden" name="record_title" value=<%=recordName.trim().replace(" ","_") %>>
                      <button class="btn more_btn hidden" type="submit">
                      <div class="btn_text">learn more</div>
                      </button>
                     </form>
                </div>
                <h1 class="music_artist"><%=founder %></h1>
                <h2 class="music_title"><%=recordName %></h2>
                </li>
  <%}%>

        <input id="query-status" type="hidden" value="<%=result%>"/>
           <li class="error-msg hidden-li">
           <img src="./resources/large.png" width="100px" height="100px" alt"error"/>
           <p class="error-text">Sorry, no result was found.</p>
           </li>
        </ul>
        </section>
              <%
                       rs.close();
                       statement.close();
                       con.close();
                      }catch(Exception e)
                      {
                          e.printStackTrace();
                      }
                  %>

        </main>
        <footer></footer>
</body>
</html>
