<sql:query var="rs" dataSource="jdbc/mmas">
</sql:query>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
    <%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Foundation | Welcome</title>
    <link rel="stylesheet" href="Css/artist_style.css" type="text/css"/>
    <script src="JS/album_script.js" defer></script>
  </head>
<body>
    <section>
<%
        String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
      	String username = "test";
      	String password = "1234";
      	String userId = request.getParameter("id");
      	String artistName="";
      	String bio = "";
      	String birthDate = "";
      	String debutDate="";
      	String country="";
      	String recordLabel="";
      	int count =-1;
        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(DATABASE_URL,username,password);
            artistName = request.getParameter("artist_name").trim().replace("_"," ");
            System.out.println("artist search artistName: "+artistName);
            String requestType=request.getParameter("formIdentifier");
            PreparedStatement statement=null;
            int status=0;
            String sql="";
            if(requestType!=null && requestType.compareTo("update_artist")==0){
                sql ="UPDATE artist SET artist_name='"+artistName+"',bio='"+request.getParameter("bio").trim()+"',birth_date='"+request.getParameter("birth_date").trim()+"',debut_date='"+request.getParameter("debut_date").trim()+"',country='"+request.getParameter("country").trim()+"',label_record=get_record_id('"+request.getParameter("records").trim().replace("_"," ")+"') WHERE artist.artist_id="+request.getParameter("artist_id").trim().replace("_"," ")+";";
                System.out.println(sql);
                statement = con.prepareStatement(sql);
                status = statement.executeUpdate();
                System.out.println(status);
                statement.close();
            }
            sql="SELECT * FROM artist INNER JOIN record_label ON artist.label_record=record_label.rec_id WHERE artist.artist_name ILIKE ? ;";
            statement = con.prepareStatement(sql);
            statement.setString(1,artistName);
            ResultSet rs = statement.executeQuery();
            String coverUrl="";
            while(rs.next()){
            bio = rs.getString("bio");
            birthDate = rs.getString("birth_date");
            debutDate = rs.getString("debut_date");
            country = rs.getString("country");
            recordLabel = rs.getString("rec_name");
            String artistId=rs.getString("artist_id");
            System.out.println(artistId);
            coverUrl = "background-image:url('."+rs.getString("artist_pic")+"')";
            System.out.println(coverUrl);
        %>
        <form class="img" action="index.jsp" method="get">
            <input type="hidden" name="formIdentifier" value="searchSong">
            <input type="hidden" name="artist" value=<%=artistName.trim().replace(" ","_")%>>
            <input type="hidden" name="id" value=<%=userId%>>
            <div class="blur"></div>
            <button type="submit" class="more">see music</button>
            <div class="profile_pic"  style=<%=coverUrl.replace(" ","/")%>></div>
        </form>

        <div class="data">

            <ul>
              <li>
                <h3>artist name:</h3>
                <p><%=artistName%></p>
              </li>

              <li>
                <h3>country:</h3>
                <p><%=country%></p>
              </li>

              <li>
                <h3>bio:</h3>
                <p>
                  <%=bio%>
                </p>
              </li>

              <li>
                <h3>birth date:</h3>
                <p><%=birthDate%></p>
              </li>

              <li>
                <h3>debut date:</h3>
                <p><%=debutDate%></p>
              </li>

              <li>
                <h3>record label:</h3>
                <p><%=recordLabel%></p>
              </li>

              <li>
                <h3>total album:</h3>
<%
                sql="WITH album_count AS(SELECT DISTINCT album.album_title AS title FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id WHERE artist.artist_name ILIKE ? AND main_query.user_id="+userId+") SELECT COUNT(title) FROM album_count;";
                statement = con.prepareStatement(sql);
                statement.setString(1,artistName);
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
                sql="WITH song_count AS(SELECT main_query.title AS title FROM main_query INNER JOIN album ON main_query.album=album.album_id INNER JOIN artist ON album.artist=artist.artist_id WHERE artist.artist_name ILIKE ? AND main_query.user_id="+userId+") SELECT COUNT(title) FROM song_count;";
                statement = con.prepareStatement(sql);
                statement.setString(1,artistName);
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
              <button class="update_btn" type="button">update artist info</button>
              <button class="delete_btn" type="button">delete artist</button>
            </nav>
      </div>

      <div class="div_remove--album hidden">
        <div class="close_btn">
         <svg
              xmlns="http://www.w3.org/2000/svg"
              xmlns:xlink="http://www.w3.org/1999/xlink"
              version="1.1"
              x="0px"
              y="0px"
              viewBox="0 0 100 125"
              style="enable-background: new 0 0 100 100"
              xml:space="preserve">
              <style type="text/css">
              .st0 {
                fill-rule: evenodd;
                clip-rule: evenodd;
                }
              </style>
              <path class="st0" d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"/>
         </svg>
        </div>
        <form class="delete_form" action="delete_page.jsp" method="get">
            <input type="hidden" name="artist_id" value=<%=artistId %>>
            <input type="hidden" name="id" value=<%=userId %>>
            <input type="hidden" name="request_type" value="delete_artist">
              <p>are you sure you want to delete this ?</p>
              <button type="submit">remove</button>
        </form>
      </div>

      <div class="div_update--album hidden">
        <div class="close_btn">
        <svg
              xmlns="http://www.w3.org/2000/svg"
              xmlns:xlink="http://www.w3.org/1999/xlink"
              version="1.1"
              x="0px"
              y="0px"
              viewBox="0 0 100 125"
              style="enable-background: new 0 0 100 100"
              xml:space="preserve">
              <style type="text/css">
              .st0 {
                fill-rule: evenodd;
                clip-rule: evenodd;
                }
              </style>
              <path class="st0" d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"/>
         </svg>
        </div>
        <h1>update album</h1>
        <form action="artist_info.jsp" method="get">
          <input type="hidden" name="formIdentifier" value="update_artist" />
          <input type="hidden" name="artist_id" value=<%=artistId%> />
          <input type="hidden" name="id" value=<%=userId %>>

          <div class="input_container">
            <label for="artist_name">artist name</label>
            <input type="text" id="artist_name" placeholder="artist name" name="artist_name" value="<%=artistName%>" required />
          </div>

         <div class="input_container">
           <label for="bio">bio</label>
           <input type="text" id="bio" placeholder="bio" name="bio" value="<%=bio%>" required />
         </div>

         <div class="input_container date selectable">
           <label for="birth_date">birth date</label>
           <input type="date" id="birth_date" name="birth_date" value="<%=birthDate%>" required/>
         </div>

         <div class="input_container date selectable">
           <label for="debut_date">debut date</label>
           <input type="date" id="debut_date" name="debut_date" value="<%=debutDate%>" required />
         </div>

         <div class="input_container">
           <label for="country">country</label>
           <input type="text"id="country" placeholder="country" name="country" value="<%=country%>" required />
         </div>

          <div class="input_container">
             <label for="record_ref">record label</label>
             <select id="record_ref" name="records">
             <%
                sql = "select rec_name FROM record_label WHERE user_id="+userId+";";
                statement = con.prepareStatement(sql);
                ResultSet recordList = statement.executeQuery();
                String recNameResult="";
                 while(recordList.next())
                 {
                 recNameResult=recordList.getString("rec_name").trim().replace(" ","_");
             %>
                <option value=<%=recNameResult %> <%= recordLabel.trim().replace(" ","_").equalsIgnoreCase(recNameResult) ? "selected" : "" %> ><%=recordList.getString("rec_name") %></option>
                <%}
                recordList.close();
                %>
                       </select>
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

