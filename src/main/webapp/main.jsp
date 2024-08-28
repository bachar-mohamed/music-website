<sql:query var="rs" dataSource="jdbc/mmas">
</sql:query>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Foundation | Welcome</title>
    <style>
       @import url("https://fonts.googleapis.com/css2?family=Lexend:wght@100..900&family=Libre+Franklin:ital,wght@0,100..900;1,100..900&family=Old+Standard+TT:ital,wght@0,400;0,700;1,400&family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap");
     </style>
    <link rel="stylesheet" href="Css/main_style.css" type="text/css"/>
    <script src="JS/script.js" defer></script>
  </head>
<body>
    <header>
      <h1>welcome</h1>
    </header>
    <%
                    String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
                	String username = "test";
                	String password = "1234";
                	String artistName="";
                	String albumName="";
                	String userId = request.getParameter("id");
                    System.out.println("id is: "+userId);

                    try {
                       Class.forName("org.postgresql.Driver");
                       Connection con = DriverManager.getConnection(DATABASE_URL,username,password);
                    %>
    <main>
     <ul class="menu">
              <li class="discover">
               <form action="index.jsp" method="get">
               <input type="hidden"  name="id" value=<%=userId%> />
                <button type="submit">
                <p>explore</p>
                <%
                 String sql = "SELECT COUNT(main_query.title) AS count FROM main_query WHERE user_id ="+userId+";";
                 PreparedStatement statement = con.prepareStatement(sql);
                 ResultSet result = statement.executeQuery();
                 result = statement.executeQuery();
                 while(result.next()){
                 %>
                <p><%=result.getString("count") %> songs</p>
                <%}%>
                </button>
               </form>
             </li>

              <li class="main_btn" data-model=".div_add--song">
              <div class="add-song_icon"></div>
                <p class="add_song" >Add song</p>
               </li>

             <li class="main_btn" data-model=".div_add--album">
             <div class="add-album_icon"></div>
               <p class="add_album" >add album</p>
             </li>

             <li class="main_btn" data-model=".div_add--artist">
             <div class="add-artist_icon"></div>
               <p class="add_artist" >add artist</p>
             </li>

             <li class="main_btn" data-model=".div_add--record">
             <div class="add-label_icon"></div>
               <p class="add_artist" >add record label</p>
             </li>

             <li class="main_btn" data-model=".div_search--song">
             <div class="search-song_icon"></div>
               <p >search song</p>
             </li>

             <li class="main_btn" data-model=".div_search--album">
             <div class="search-album_icon"></div>
               <p >search album</p>
             </li>

             <li class="main_btn" data-model=".div_search--artist">
             <div class="search-artist_icon"></div>
               <p >search artist</p>
             </li>

             <li class="main_btn" data-model=".div_search--record">
             <div class="search-label_icon"></div>
              <p >search record label</p>
              </li>

           </ul>

      <div class="form div_search--song inactive">
        <button class="close_tab"></button>
        <h1>search song</h1>
        <form action="index.jsp" method="get">
         <input type="hidden"  name="id" value=<%=userId%> />
          <div class="input_container">
            <label for="song_name">title</label>
            <input type="text" id="song_name" placeholder="song name" name="title" required />
          </div>
          <button class="search_song">search song</button>
        </form>
      </div>

  <div class="form div_search--album inactive">
         <button class="close_tab"></button>
         <h1>search album</h1>
         <form action="album_list.jsp" method="get">
         <input type="hidden"  name="id" value=<%=userId%> />
           <div class="input_container">
             <label for="song_name">title</label>
             <input type="text" id="album_name" placeholder="album name" name="album_title" required />
           </div>
           <button class="add" >search album</button>
         </form>
       </div>

       <div class="form div_search--artist inactive">
         <button class="close_tab"></button>
         <h1>search artist</h1>
         <form action="artist_list.jsp" method="get">
         <input type="hidden"  name="id" value=<%=userId%> />
           <div class="input_container">
             <label for="artist_name">title</label>
             <input type="text" id="artist_name" placeholder="artist name" name="artist_name" required />
           </div>

           <button class="add">search artist</button>
         </form>
       </div>

       <div class="form div_search--record inactive">
               <button class="close_tab"></button>
               <h1>search record label</h1>
               <form action="record_list.jsp" method="get">
               <input type="hidden"  name="id" value=<%=userId%> />
                 <div class="input_container">
                   <label for="record_title">title</label>
                   <input type="text" id="record_title" name="record_title" placeholder="record label title" required />
                 </div>
                 <button class="add">search record label</button>
               </form>
       </div>

        <div class="form div_add--song inactive">
               <button class="close_tab"></button>
                       <h1>add song</h1>
                       <form action="add_page.jsp" enctype = "multipart/form-data" method="post">
                        <input type="hidden" name="addOption" value="addSong">
                        <input type="hidden"  name="id" value=<%=userId%> />
                         <div class="input_container">
                           <label for="song_title">song title</label>
                           <input type="text" id="song_title" placeholder="song title" name="song_title" required />
                         </div>

                         <div class="input_container selecteable">
                            <label for="album_ref">album</label>
                            <select id="record_ref" name="albums">
                             <%
                                  sql = "select album_title from album WHERE user_id="+userId+";";
                                  statement = con.prepareStatement(sql);
                                  result = statement.executeQuery();
                                  while(result.next())
                                  {
                                    albumName=result.getString("album_title").trim().replace(" ","_");
                          %>
               <option value=<%=albumName%>><%=result.getString("album_title") %></option>
               <%}%>
                            </select>
                         </div>

                         <div class="input_container">
                           <label for="description">description</label>
                           <input type="text" id="song_name" placeholder="song description" name="song_genre" required/>
                         </div>

                         <div class="input_container">
                           <label for="release_date">release data</label>
                           <input type="date" id="release_date" placeholder="release date" name="release_date" required/>
                         </div>

                         <div class="input_container">
                            <label for="language">language</label>
                            <input type="text" id="language" placeholder="language" name="language" required/>
                         </div>

                         <div class="input_container">
                            <label for="song_url">song url</label>
                            <input type="text" id="song_url" placeholder="song url" name="song_url" required/>
                         </div>

                           <div class="input_container selecteable">
                             <label for="song_cover">cover</label>
                             <input type="file" id="song_cover" accept="image/*"  name="song_cover" required/>
                           </div>

                         <button class="add add-song">add</button>
                       </form>
        </div>

         <div class="form div_add--artist inactive">
                 <button class="close_tab"></button>
                 <h1>add artist</h1>
                 <form action="add_page.jsp" enctype = "multipart/form-data" method="post">
                  <input type="hidden" name="addOption" value="addArtist">
                  <input type="hidden"  name="id" value=<%=userId%> />
                 <div class="input_container">
                 <label for="artist_id">artist name</label>
                 <input type="text" id="artist_name" placeholder="artist name" name="artist_name" required/>
                 </div>
                 <div class="input_container">
                    <label for="artist_bio">bio</label>
                    <input type="text" id="artist_bio" placeholder="artist bio" name="artist_bio" required/>
                 </div>
                   <div class="input_container">
                     <label for="birth_date">birth date</label>
                     <input type="date" id="birth_date" name="birth_date" required/>
                   </div>
                  <div class="input_container">
                       <label for="debut_date">debut date</label>
                       <input type="date" id="debut_date" name="debut_date" required/>
                  </div>
                  <div class="input_container">
                        <label for="artist_country">country</label>
                        <input type="text" id="artist_country" placeholder="artist country" name="artist_country" required/>
                  </div>
                  <div class="input_container selecteable">
                      <label for="record_ref">record label</label>
                      <select id="record_ref" name="records">
                          <%
                                  sql ="select rec_name FROM record_label WHERE user_id="+userId+";";
                                  statement = con.prepareStatement(sql);
                                  result = statement.executeQuery();
                                  while(result.next())
                                  {
                          %>
               <option value=<%=result.getString("rec_name").trim().replace(" ","_") %>><%=result.getString("rec_name") %></option>
               <%}%>
                      </select>
                  </div>
                  <div class="input_container selecteable">
                     <label for="artist_cover">cover</label>
                     <input type="file" id="artist_cover" accept="image/*"  name="artist_cover" required/>
                  </div>
                   <button class="add">add</button>
                 </form>
         </div>

       <div class="form div_add--album inactive">
         <button class="close_tab"></button>
         <h1>add album</h1>
            <form action="add_page.jsp" enctype = "multipart/form-data" method="post">
               <input type="hidden" name="addOption" value="addAlbum">
               <input type="hidden"  name="id" value=<%=userId%> />

           <div class="input_container">
             <label for="album_title">album title</label>
             <input type="text" id="album_title" placeholder="album title" name="album_title" required/>
           </div>

           <div class="input_container selecteable">
             <label for="artist_id">artist</label>
             <select id="artist_ref" name="artists">
              <%
                  sql = "select artist_name from artist WHERE user_id="+userId+";";
                  statement = con.prepareStatement(sql);
                  result = statement.executeQuery();
                    while(result.next())
                  {
                  %>
               <option value=<%=result.getString("artist_name").trim().replace(" ","_") %>><%=result.getString("artist_name") %></option>
               <%}%>
             </select>
           </div>

           <div class="input_container">
             <label for="album_description">description</label>
             <input type="text" id="album_description" placeholder="album description" name="album_description" required/>
           </div>

           <div class="input_container">
                <label for="release_date">release date</label>
                <input type="date" id="release_date" name="release_date" required/>
           </div>

           <div class="input_container selecteable">
             <label for="album_cover">cover</label>
             <input type="file" id="album_cover" accept="image/*"  name="album_cover" required/>
           </div>

           <button class="add">add</button>
         </form>
       </div>

       <div class="form div_add--record inactive">
               <button class="close_tab"></button>
               <h1>add record label</h1>
               <form action="add_page.jsp" enctype = "multipart/form-data" method="post">
               <input type="hidden" name="addOption" value="addRecord">
               <input type="hidden"  name="id" value=<%=userId%> />
                  <div class="input_container">
                                  <label for="record_label_name">title</label>
                                  <input type="text" id="record_label_name" placeholder="record label name" name="record_label_name" required/>
                                </div>

                                <div class="input_container">
                                  <label for="record_label_description">description</label>
                                  <input type="text" id="record_label_description" placeholder="record label description" name="record_label_description" required/>
                                </div>

                                <div class="input_container">
                                     <label for="record_label_founder">founder</label>
                                     <input type="text" id="record_label_founder" placeholder="record label founder" name="record_label_founder" required/>
                                </div>

                                <div class="input_container">
                                     <label for="record_label_date">date</label>
                                     <input type="date" id="record_label_date"  name="record_label_date" required/>
                                </div>

                                <div class="input_container">
                                      <label for="record_label_country">country</label>
                                      <input type="text" id="record_label_country" placeholder="record_label_country" name="record_label_country" required/>
                                </div>
                 <div class="input_container selecteable">
                      <label for="record_label_cover">cover</label>
                      <input type="file" id="record_label_cover" accept="image/*"  name="record_label_cover" required/>
                 </div>

                 <button class="add">add record label</button>
               </form>
        </div>

       <div class="overlay inactive"></div>
       <%
                                   result.close();
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