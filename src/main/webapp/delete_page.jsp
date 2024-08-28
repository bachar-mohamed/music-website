<sql:query var="rs" dataSource="jdbc/mmas">
</sql:query>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
    <%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Css/ops.css" type="text/css"/>
    <title>Foundation | Welcome</title>
  </head>
<body>
<div class="ops_info">
<%
    String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
	String username = "test";
	String password = "1234";
	int status = 0;
	String userId=request.getParameter("id");

	try {

            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(DATABASE_URL,username,password);
            String requestSrc = request.getParameter("request_type");
            String sql="";
            switch(requestSrc){
            case "delete_album":
            System.out.println("delete_album");
            String albumId = request.getParameter("album_id");
            System.out.println("album id: "+albumId);
            sql="DELETE FROM album WHERE album.album_id ="+albumId+";";
            System.out.println(sql);
            break;
            case "delete_artist":
            System.out.println("delete_artist");
            String artistId = request.getParameter("artist_id");
            System.out.println("album id: "+artistId);
            sql="DELETE FROM artist WHERE artist.artist_id ="+artistId+";";
            System.out.println(sql);
            break;
            case "delete_rec":
            System.out.println("delete_rec");
            String recordId = request.getParameter("rec_id");
            System.out.println("album id: "+recordId);
            sql="DELETE FROM record_label WHERE record_label.rec_id ="+recordId+";";
            System.out.println(sql);
            break;
            case "delete_song":
            System.out.println("delete_song");
            String SongId = request.getParameter("song_id");
            System.out.println("song id: "+SongId);
            sql="DELETE FROM song WHERE song.song_id ="+SongId.trim()+";";
            System.out.println(sql);
            }
             PreparedStatement statement = con.prepareStatement(sql);
             status = statement.executeUpdate();
             statement.close();
             con.close();
    }catch(Exception e){
    e.printStackTrace();
    }
    if(status==1){
    %>
    <div class="status_pic success"></div>
    <p>operation success</p>
    <%}else if(status==0){%>
    <div class="status_pic failure"></div>
        <p>operation failed</p>
    <%}%>
    <form action="main.jsp" action="get">
    <input type="hidden" name="id" value=<%=userId%>>
     <button type="submit">back</button>
    </form>
 </div>
</body>
</html>