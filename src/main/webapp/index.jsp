<sql:query var="rs" dataSource="jdbc/mmas">
</sql:query>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
    <%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
           @import url("https://fonts.googleapis.com/css2?family=Lexend:wght@100..900&family=Libre+Franklin:ital,wght@0,100..900;1,100..900&family=Old+Standard+TT:ital,wght@0,400;0,700;1,400&family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap");
         </style>
    <title>Foundation | Welcome</title>
    <link rel="stylesheet" href="Css/list_style.css" type="text/css"/>
    <script src="JS/pageScript.js" defer></script>
  </head>
<body>
   <header>
       <h1>Library</h1>
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
            String coverUrl="";
            String recordName="";
            String songName = request.getParameter("title");
            String albumName = request.getParameter("options");
            recordName = request.getParameter("record");
            String artist = request.getParameter("artist");

            System.out.println("index searchSong title: "+songName);
            System.out.println("index searchSong album: "+albumName);
            System.out.println("index searchSong record: "+recordName);
            System.out.println("index searchSong artist: "+artist);

            if(songName!=null){
                System.out.println("index searchSong title: "+songName.trim().replace("_"," "));
               // System.out.println("index searchSong option: "+albumName.trim().replace("_"," "));
                sql = "SELECT song_id,main_query.title,song_cover,artist_name FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id WHERE main_query.title ILIKE ? AND main_query.user_id="+userId+";";
                System.out.println("sql: "+sql);
                statement = con.prepareStatement(sql);
                statement.setString(1,songName.trim().replace("_"," ")+"%");
            }else if(artist!=null){
                System.out.println("index searchSong artist: "+artist.trim().replace("_"," "));
                sql = "SELECT song_id,main_query.title,song_cover,artist_name FROM main_query INNER JOIN album ON main_query.album = album.album_id INNER JOIN artist ON album.artist=artist.artist_id where artist.artist_name ILIKE ? AND main_query.user_id="+userId+";";
                System.out.println(sql);
                statement = con.prepareStatement(sql);
                statement.setString(1,artist.trim().replace("_"," ")+"%");
                System.out.println("artist is: "+artist.trim().replace("_"," "));
            }else if(albumName!=null){
                sql = "SELECT song_id,main_query.title,song_cover,artist_name FROM main_query INNER JOIN album ON main_query.album = album.album_id INNER JOIN artist ON album.artist=artist.artist_id where album.album_title ILIKE ? AND main_query.user_id="+userId+";";
                System.out.println(sql);
                statement = con.prepareStatement(sql);
                statement.setString(1,albumName.trim().replace("_"," "));
            }else if(recordName!=null){
                sql="SELECT song_id,main_query.title,song_cover,artist_name FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id INNER JOIN record_label ON artist.label_record=record_label.rec_id WHERE record_label.rec_name ILIKE ? AND main_query.user_id="+userId+";";
                System.out.println("recordName: "+recordName);
                System.out.println("recordName: "+recordName.trim().replace("_"," "));
                statement = con.prepareStatement(sql);
                statement.setString(1,recordName.trim().replace("_"," "));
            }else{
                sql = "SELECT song_id,main_query.title,song_cover,artist_name FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id WHERE main_query.user_id="+userId+";";
                System.out.println(sql);
                statement = con.prepareStatement(sql);
            }
            ResultSet rs = statement.executeQuery();
            boolean result=false;
            while(rs.next())
            {
                result=true;
                songName=rs.getString("title");
                artist=rs.getString("artist_name");
                coverUrl = "background-image:url('."+rs.getString("song_cover")+"')";
    %>
                <li>
                <div class="img_container" style=<%=coverUrl.replace(" ","/")%>>
                     <form  action="song_preview.jsp" method="get">
                     <input type="hidden" name="song_id" value=<%=rs.getString("song_id") %>>
                     <input type="hidden" name="id" value=<%=userId%>>
                      <button class="btn play_btn hidden" type="submit">
                      <div class="play_rect"></div>
                      </button>
                     </form>
                </div>
                <h1 class="music_artist"><%= artist %></h1>
                <h2 class="music_title"><%=songName %></h2>
                </li>
  <%}
  %>
         <input id="query-status" type="hidden" value="<%=result%>"/>
         <li class="error-msg hidden-li">
         <img src="./resources/large.png" alt"error"/>
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
