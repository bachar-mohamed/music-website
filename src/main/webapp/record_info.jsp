<sql:query var="rs" dataSource="jdbc/mmas">
</sql:query>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
    <%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Foundation | Welcome</title>
    <link rel="stylesheet" href="Css/album_style.css" type="text/css"/>
    <script src="JS/album_script.js" defer></script>
  </head>
<body>
    <section>
    <%
    String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
  	String username = "test";
  	String password = "1234";
  	int count =-1;

  	try {

  Class.forName("org.postgresql.Driver");
  Connection con = DriverManager.getConnection(DATABASE_URL,username,password);
  String recordName = request.getParameter("record_title").trim();
  String requestType = request.getParameter("formIdentifier");
  PreparedStatement statement =null;
  String userId = request.getParameter("id");
  System.out.println("id: "+userId);
  String sql="";
  int status=0;
  if(requestType!=null && requestType.compareTo("update_record")==0){
  sql = "UPDATE record_label SET rec_name='"+recordName+"',description='"+request.getParameter("record_description").trim()+"',founder='"+request.getParameter("founder").trim()+"',founded_date='"+request.getParameter("founded_date").trim()+"',country='"+request.getParameter("country").trim()+"' WHERE rec_id="+request.getParameter("record_id")+";";
    System.out.println(sql);
    statement = con.prepareStatement(sql);
    status = statement.executeUpdate();
    System.out.println(status);
    statement.close();
  }
  sql="SELECT * FROM record_label WHERE record_label.rec_name ILIKE ?;";
  statement = con.prepareStatement(sql);
  statement.setString(1,recordName);
  ResultSet rs = statement.executeQuery();
  String coverUrl="";
  while(rs.next()){
  String recordId=rs.getString("rec_id");
  String founder = rs.getString("founder");
  String description = rs.getString("description");
  String foundDate = rs.getString("founded_date");
  String country = rs.getString("country");
  coverUrl = "background-image:url('."+rs.getString("cover_url")+"')";
  System.out.println(coverUrl);
  %>
      <form class="img" style=<%=coverUrl.replace(" ","/")%>  action="index.jsp" method="get">
      <input type="hidden" name="formIdentifier" value="searchSong">
      <input type="hidden" name="record" value=<%=rs.getString("rec_name").trim().replace(" ","_")%> />
      <input type="hidden" name="id" value=<%=userId%> />
        <button type="submit" class="more">see music</button>
      </form>
      <div class="data">
        <ul>
          <li>
            <h3>record name:</h3>
            <p><%=recordName%></p>
          </li>
          <li>
            <h3>Description:</h3>
            <p><%=description%></p>
          </li>
          <li>
            <h3>founder:</h3>
            <p><%=founder%></p>
          </li>
          <li>
            <h3>founded date:</h3>
            <p><%=foundDate%></p>
          </li>
          <li>
            <h3>country:</h3>
            <p><%=country%></p>
          </li>
          <li>
            <h3>total artist:</h3>
            <%
            sql="WITH artist_count AS(SELECT DISTINCT artist.artist_name AS artist_name FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id INNER JOIN record_label ON artist.label_record=record_label.rec_id WHERE record_label.rec_name ILIKE ? AND main_query.user_id="+userId+") SELECT COUNT(artist_name) FROM artist_count;";
                System.out.println(sql);
              statement = con.prepareStatement(sql);
              statement.setString(1,recordName.trim());
              rs = statement.executeQuery();
              while(rs.next()){
                System.out.println("the count is: "+rs.getInt(1));
                count=rs.getInt(1);
                }
                %>
                <p><%=(count==-1)?0:count %></p>
          </li>
          <li>
            <h3>total album:</h3>
            <%
            sql="WITH album_count AS(SELECT DISTINCT album.album_title AS album_name FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id INNER JOIN record_label ON artist.label_record=record_label.rec_id WHERE record_label.rec_name ILIKE ? AND main_query.user_id="+userId+") SELECT COUNT(album_name) FROM album_count;";
            System.out.println(sql);
              statement = con.prepareStatement(sql);
              statement.setString(1,recordName.trim());
              rs = statement.executeQuery();
              while(rs.next()){
                System.out.println("the count is: "+rs.getInt(1));
                count=rs.getInt(1);
                }
                %>
                <p><%=(count==-1)?0:count %></p>
          </li>
          <li>
            <h3>total songs:</h3>
            <%
            sql= "WITH album_count AS(SELECT DISTINCT main_query.title AS album_name FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id INNER JOIN record_label ON artist.label_record=record_label.rec_id WHERE record_label.rec_name ILIKE ? AND main_query.user_id="+userId+") SELECT COUNT(album_name) FROM album_count;";
              statement = con.prepareStatement(sql);
              statement.setString(1,recordName.trim());
              rs = statement.executeQuery();
               while(rs.next()){
                System.out.println("the count is: "+rs.getInt(1));
                count=rs.getInt(1);
                }
                %>
                <p><%=(count==-1)?0:count %></p>
          </li>
        </ul>
        <nav>
          <button class="update_btn" type="button">update record label info</button>
          <button class="delete_btn" type="button">delete record label</button>
        </nav>
      </div>
      <div class="div_remove--album hidden">
      <div class="close_btn"></div>
      <form class="delete_form" action="delete_page.jsp" method="get">
      <input type="hidden" name="rec_id" value=<%=recordId%> />
      <input type="hidden" name="id" value=<%=userId %>>
      <input type="hidden" name="request_type" value="delete_rec" />
        <p>are you sure you want to delete this ?</p>
        <button type="submit">remove</button>
      </form>
    </div>
        <div class="div_update--album hidden">
      <div class="close_btn"></div>
      <h1>update record label</h1>
      <form action="record_info.jsp" method="get">
        <input type="hidden" name="formIdentifier" value="update_record"/>
        <input type="hidden" name="record_id" value=<%=recordId%> />
        <input type="hidden" name="id" value=<%=userId %>>

        <div class="input_container">
          <label for="record_title">record title</label>
          <input type="text" id="record_title" placeholder="record title" name="record_title" value="<%=recordName.replace("_"," ")%>" required />
        </div>

        <div class="input_container">
          <label for="record_description">description</label>
          <input type="text" id="record_description" placeholder="record description" name="record_description" value="<%=description%>" required />
        </div>

        <div class="input_container">
          <label for="founder">founder</label>
          <input type="text" id="founder" placeholder="founder" name="founder" value="<%=founder%>"  required/>
        </div>

        <div class="input_container">
          <label for="founded_date">founded date</label>
          <input type="date" id="founded_date" name="founded_date" value="<%=foundDate%>"  required />
        </div>

        <div class="input_container">
          <label for="country">country</label>
          <input type="text" id="country" placeholder="country" name="country" value="<%=country%>"  required />
        </div>
        <button class="add">update</button>
      </form>
    </div>

    <div class="overlay hidden"></div>
    </section>
    <%}
         rs.close();
         statement.close();
         con.close();
         }catch(Exception e)
         {
             e.printStackTrace();
         }
    %>
  </body>
