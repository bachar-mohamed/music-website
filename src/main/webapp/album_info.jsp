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
  	String userId = request.getParameter("id");
  	int count =-1;

  	try {

        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection(DATABASE_URL,username,password);
        String albumName = request.getParameter("album_title").trim().replace("_"," ");
        String artistName = request.getParameter("artists").trim().replace("_"," ");
        String recordLabel;
        String releaseDate;
        String description;
        System.out.println("initial: "+artistName);
        PreparedStatement statement =null;
        ResultSet rs=null;
        String updateRequest = request.getParameter("formIdentifier");
        String sql="";

        if(updateRequest!=null && updateRequest.compareTo("update_album")==0){
          System.out.println("album_info update request: "+updateRequest);
          String albumId= request.getParameter("album_id");
          description = request.getParameter("album_description");
          releaseDate = request.getParameter("release_date");
          int status=0;
          sql = "UPDATE album SET album_title='"+albumName+"',artist=get_artist_id('"+artistName+"'),description='"+description+"',release_date='"+releaseDate+"' WHERE album_id="+albumId+";";
          System.out.println(sql);
          statement = con.prepareStatement(sql);
          status = statement.executeUpdate();
          System.out.println("album_info update status: "+status);
          System.out.println("album_info update albumName: "+albumName);
          System.out.println("album_info update artistName: "+artistName);
          statement.close();
        }
        sql="SELECT * FROM album INNER JOIN artist ON album.artist=artist.artist_id INNER JOIN record_label ON artist.label_record = record_label.rec_id WHERE album.album_title ILIKE ? AND artist.artist_name ILIKE ?;";
        System.out.println("album_info search albumName: '"+albumName+"'");
         System.out.println("album_info search artistName: '"+artistName+"'");
        statement = con.prepareStatement(sql);
        statement.setString(1,albumName);
        statement.setString(2,artistName);
        rs = statement.executeQuery();
        String coverUrl="";
        while(rs.next()){
            albumName = rs.getString("album_title");
            artistName = rs.getString("artist_name");
            recordLabel = rs.getString("rec_name");
            description=rs.getString("description");
            releaseDate = rs.getString("release_date");
          String albumId = rs.getString("album_id");
          System.out.println("url is: "+rs.getString("album_cover"));
          coverUrl = "background-image:url('."+rs.getString("album_cover")+"')";
        %>
      <form class="img" style=<%=coverUrl.replace(" ","/")%>  action="index.jsp" method="get">
      <input type="hidden" name="formIdentifier" value="searchSong">
      <input type="hidden" name="options" value=<%=albumName.trim().replace(" ","_")%>>
      <input type="hidden" name="id" value=<%=userId%>>
        <button type="submit" class="more">see music</button>
      </form>
      <div class="data">
        <ul>

          <li>
            <h3>title:</h3>
            <p><%=albumName%></p>
          </li>

          <li>
            <h3>artist:</h3>
            <p><%=artistName%></p>
          </li>

          <li>
            <h3>record label:</h3>
            <p><%=recordLabel%></p>
          </li>

          <li>
            <h3>release date:</h3>
            <p><%=releaseDate%></p>
          </li>

          <li>
            <h3>Description:</h3>
            <p>
              <%=description%>
            </p>
          </li>

          <li>
            <h3>total songs:</h3>
            <%
            sql="WITH album_query AS (SELECT main_query.title AS song_title FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id WHERE album.album_title ILIKE ? AND artist.artist_name ILIKE ? AND main_query.user_id="+userId+") SELECT COUNT(song_title) FROM album_query;";
              statement = con.prepareStatement(sql);
              statement.setString(1,albumName.trim()+"%");
              statement.setString(2,artistName.trim()+"%");
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
          <button class="update_btn" type="button">update album info</button>
          <button class="delete_btn" type="button">delete album</button>
        </nav>
      </div>
      <div class="div_remove--album hidden">
      <div class="close_btn"></div>
      <form class="delete_form" action="delete_page.jsp" method="get">
      <input type="hidden" name="album_id" value=<%=albumId%>>
      <input type="hidden" name="request_type" value="delete_album">
      <input type="hidden" name="id" value=<%=userId %>>
        <p>are you sure you want to delete this ?</p>
        <button type="submit">remove</button>
      </form>
    </div>

    <div class="div_update--album hidden">
      <div class="close_btn"></div>
      <h1>update album</h1>
      <form action="album_info.jsp" method="get">
        <input type="hidden" name="formIdentifier" value="update_album" />
        <input type="hidden" name="album_id" value=<%=albumId%> />
        <input type="hidden" name="id" value=<%=userId %>>
        <div class="input_container">
          <label for="album_title">album title</label>
          <input type="text" id="album_title" placeholder="album title" name="album_title" value="<%=albumName%>" required />
        </div>

        <div class="input_container">
          <label for="artist_id">artist</label>
          <select id="artist_id" name="artists">
           <%
                sql = "select artist_name from artist WHERE user_id="+userId+";";
                statement = con.prepareStatement(sql);
                rs = statement.executeQuery();
                String artistNameResult="";
                while(rs.next())
                  {
                  artistNameResult=rs.getString("artist_name").trim().replace(" ","_") ;
                  %>
        <option value=<%=artistNameResult%> <%= artistName.trim().replace(" ","_") .trim().replace(" ","_").equalsIgnoreCase(artistNameResult) ? "selected" : "" %> ><%=rs.getString("artist_name") %></option>
            <%}%>
          </select>
        </div>

        <div class="input_container">
          <label for="album_description">description</label>
          <input type="text" id="album_description" placeholder="album description" name="album_description" value="<%=description%>" required />
        </div>

        <div class="input_container">
          <label for="release_date">release date</label>
          <input type="date" id="release_date" name="release_date" value="<%=releaseDate%>" required />
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
</html>
