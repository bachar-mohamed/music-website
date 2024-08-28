<sql:query var="rs" dataSource="jdbc/mmas">
</sql:query>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
    <%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Foundation | Welcome</title>
    <link rel="stylesheet" href="Css/song_preview_style.css" type="text/css"/>
    <script src="JS/album_script.js" defer></script>
  </head>
<body>
    <section>
      <%

    String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
	String username = "test";
	String password = "1234";
	String userId= request.getParameter("id");
	%>
    <%
	try {

        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection(DATABASE_URL,username,password);
        PreparedStatement statement=null;
        ResultSet rs=null;
        String requestType = request.getParameter("formIdentifier");
        String songId = request.getParameter("song_id");
        String query="";
        String title="";
        String album="";
        String duration="";
        String songUrl="";
        String description="";
        String releaseDate="";
        String language="";
        if(requestType!=null && requestType.compareTo("update_song")==0){
            title = request.getParameter("song_title");
            songUrl= request.getParameter("song_url")==""?"":request.getParameter("song_url");
            album = request.getParameter("albums").trim().replace("_"," ");
            description = request.getParameter("song_description");
            releaseDate = request.getParameter("release_date");
            language = request.getParameter("language");
            query=  songUrl.equals("")? "UPDATE song set title='"+title+"',description='"+description+"',release_date='"+releaseDate+"',language='"+language+"',album=get_album_id('"+album+"') WHERE song.song_id="+songId+";" :"UPDATE song set title='"+title+"',description='"+description+"',release_date='"+releaseDate+"',song_url='"+songUrl+"',language='"+language+"',album=get_album_id('"+album+"') WHERE song.song_id="+songId+";";
            System.out.println(query);
            statement = con.prepareStatement(query);
            int status = statement.executeUpdate();
            System.out.println(status);
        }
        String sql = "SELECT * FROM song where song_id="+songId;
        System.out.println(sql);
        statement = con.prepareStatement(sql);
        rs = statement.executeQuery();
        while(rs.next()){
        title = rs.getString("title");
        description = rs.getString("description");
        releaseDate =rs.getString("release_date");
        language = rs.getString("language");
            %>

      <h1>music preview</h1>
      <div class="main">
        <iframe width="560" height="315" src=<%="https://www.youtube.com/embed/"+rs.getString("song_url") %> title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen ></iframe>
        <div class="info">
          <h2>title: <span><%=title%></span></h2>
          <h2>artist: <span>
          <%
          query = "SELECT artist.artist_name from album INNER JOIN artist ON album.artist=artist.artist_id WHERE album.album_id="+rs.getString("album")+";";
          System.out.println(query);
          PreparedStatement secondaryStatement = con.prepareStatement(query);
          ResultSet result = secondaryStatement.executeQuery();
          while(result.next()){
          %>
          <%=result.getString("artist_name")%>
          <%}%>
          </span></h2>
          <h2>album:<span>
          <%
          query = "SELECT album.album_title from album WHERE album.album_id="+rs.getString("album")+";";
          secondaryStatement = con.prepareStatement(query);
          result = secondaryStatement.executeQuery();
          while(result.next()){
          album =result.getString("album_title");
          %>
          <%=album%>
          <%}
          %>
          </span>
          </h2>
          <h2>description: <span><%=description%></span></h2>
          <h2>release date: <span><%=releaseDate %></span></h2>
          <h2>language: <span><%=language%></span></h2>
        </div>
      </div>
      <nav>
        <button class="update_btn">update</button>
        <button class="delete_btn">delete</button>
      </nav>

    <div class="div_remove--song hidden">
      <div class="close_btn"></div>
      <form class="delete_form" action="delete_page.jsp" method="get">
      <input type="hidden" name="song_id" value=<%=songId%> />
      <input type="hidden" name="request_type" value="delete_song" />
      <input type="hidden" name="id" value=<%=userId%> />
        <p>are you sure you want to delete this ?</p>
        <button type="submit">remove</button>
      </form>
    </div>

    <div class="div_update--song hidden">
      <div class="close_btn"></div>
      <h1>update album</h1>
      <form action="" method="get">
        <input id="identifier" type="hidden" name="formIdentifier" value="update_song" />
        <input id="songId" type="hidden" name="song_id" value=<%=songId%> />
        <input id="userId" type="hidden" name="id" value=<%=userId%> />

        <div class="input_container">
          <label for="song_title">title</label>
          <input type="text" id="song_title" placeholder="song title" name="song_title" value="<%=title%>"  />
        </div>


        <div class="input_container">
          <label for="album_id">album</label>
          <select id="album_id" name="albums">
            <%
          query ="select album_title from album WHERE user_id="+userId+";";
          secondaryStatement = con.prepareStatement(query);
          result = secondaryStatement.executeQuery();
          String albumValue="";
          while(result.next()){
          albumValue=result.getString("album_title").trim().replace(" ","_");
          %>
          <%
            System.out.println(albumValue+","+album.trim().replace(" ","_")+": "+album.trim().replace(" ","_").equalsIgnoreCase(albumValue));
          %>
          <option value=<%=albumValue%> <%= album.trim().replace(" ","_").equalsIgnoreCase(albumValue) ? "selected" : "" %> ><%=result.getString("album_title")%></option>
          <%}
          %>
          </select>
        </div>

        <div class="input_container">
          <label for="album_description">description</label>
          <input type="text" id="song_description" placeholder="description" name="song_description" value="<%=description%>" />
        </div>

        <div class="input_container">
          <label for="release_date">release date</label>
          <input type="date" id="release_date" name="release_date" value=<%=releaseDate%> />
        </div>

        <div class="input_container">
          <label for="language">language</label>
          <input type="text" id="language" placeholder="language" name="language" value=<%=language%> />
        </div>
        <div class="input_container">
          <label for="song_url">Song Url</label>
          <input type="text" id="song_url" placeholder="youtube url" name="song_url" />
        </div>

        <button class="add update-btn">update</button>
      </form>
    </div>
    <%
          result.close();
          secondaryStatement.close();
    }
          rs.close();
          statement.close();
          con.close();
          }catch(Exception e)
          {
            e.printStackTrace();
          }
          %>
    <div class="overlay hidden"></div>
    </section>
  </body>
</html>
