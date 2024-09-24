<sql:query var="rs" dataSource="jdbc/mmas">
</sql:query>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
    <%@ page import = "javax.servlet.http.*" %>
    <%@ page import = "org.apache.commons.fileupload.*" %>
    <%@ page import = "org.apache.commons.fileupload.disk.*" %>
    <%@ page import = "org.apache.commons.fileupload.servlet.*" %>
    <%@ page import = "org.apache.commons.io.output.*" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Foundation | Welcome</title>
    <link rel="stylesheet" href="Css/ops.css" type="text/css"/>
  </head>
<body>
 <div class="ops_info">
     <%
    String DATABASE_URL = "jdbc:postgresql://localhost:5432/music";
	String username = "test";
	String password = "1234";
	int status=0;
	String errorMessage="";
	PreparedStatement statement =null;
	ResultSet rs =null;
	String userId="";
	String songUrl="";
    %>

    <%!
	public  String getYouTubeEmbedLink(String videoUrl) {
       String videoId = extractVideoId(videoUrl);
       if (videoId != null) {
          return videoId;
       } else {
          return "Invalid YouTube URL";
       }
    }
    %>
    <%!
        private static   String extractVideoId(String videoUrl) {
            String videoId = null;
            String regex = "^(https?://)?(www\\.)?(youtube\\.com|youtu\\.?be)/.+$";
            if (videoUrl.matches(regex)) {
                String[] parts = videoUrl.split("\\?v=");
                if (parts.length > 1) {
                    videoId = parts[1].split("[^\\w-]")[0];
                }
            }
            return videoId;
        }
     %>
    <%
	try {

             Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(DATABASE_URL,username,password);
            File file ;
            String sql="";
            String path=application.getRealPath("")+ File.separator +"covers"+ File.separator;
            String fileName="";
            String url="";
            File uploadDir = new File(path);
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(15120000);
            factory.setRepository(uploadDir);
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(15120000);
            List<FileItem> fileItems = upload.parseRequest(request);
            ArrayList<String> fields = new ArrayList<>();
            String formOption= fileItems.get(0).getString();
            System.out.println("form option: "+formOption);
            String uploadPath="";
            FileItem temp = null;
            switch(formOption){
                        case "addSong":
                            errorMessage = "no album selected, select an album or add a new one";
                            uploadPath=path+"songCover"+File.separator;
                            for(int i=1;i<fileItems.size();i++){
                               temp = fileItems.get(i);
                               if (temp.isFormField () ) {
                                 fields.add(temp.getString().trim());
                               }else{
                                  fileName=temp.getName();
                                  if( fileName.lastIndexOf("\\") >= 0 ) {
                                    url=uploadPath + fileName.substring( fileName.lastIndexOf("\\"));
                                    file = new File(url) ;
                                  } else {
                                    url= uploadPath + fileName.substring(fileName.lastIndexOf("\\")+1);
                                    file = new File(url) ;
                                  }
                                  temp.write(file) ;
                                  fields.add(url.substring(url.lastIndexOf("\\\\")+1).replace("\\","/"));
                               }
                            }
                            for(String str:fields){
                              System.out.println(str);
                            }
                        userId=fields.get(0);
                        System.out.println("url is: "+getYouTubeEmbedLink(fields.get(7)));
                        songUrl = getYouTubeEmbedLink(fields.get(6));
                        if(songUrl.equalsIgnoreCase("Invalid YouTube URL")){
                        System.out.println("invalid youtube link!");
                        break;
                        }
                        System.out.println(songUrl);
                        //                                user_id,             title,            description,    release_date,          language,                 album,                                song_cover,          song_url
                        sql= "SELECT add_song_for_user("+fields.get(0)+",'"+fields.get(1)+"',0,'"+fields.get(3)+"','"+fields.get(4)+"','"+fields.get(5)+"','"+fields.get(2).trim().replace("_"," ")+"','"+fields.get(7)+"','"+songUrl+"');";
                        System.out.println("sql: "+sql);
                        break;
                        case "addAlbum":
                           errorMessage = "no artist selected, select an artist or add a new one";
                           uploadPath=path+"albumCover"+File.separator;
                           for(int i=1;i<fileItems.size();i++){
                             temp = fileItems.get(i);
                             if (temp.isFormField () ) {
                                fields.add(temp.getString().trim());
                             }else{
                                fileName=temp.getName();
                                if( fileName.lastIndexOf("\\") >= 0 ) {
                                  url=uploadPath + fileName.substring( fileName.lastIndexOf("\\"));
                                  file = new File(url) ;
                                } else {
                                  url= uploadPath + fileName.substring(fileName.lastIndexOf("\\")+1);
                                  file = new File(url) ;
                                }
                                fields.add(url.substring(url.lastIndexOf("\\\\")+1).replace("\\","/"));
                                temp.write(file) ;
                             }
                             }
                             userId=fields.get(0);
                             sql= "INSERT INTO album(album_title,artist,description,release_date,album_cover,user_id) VALUES('"+fields.get(1)+"',get_artist_id('"+fields.get(2).trim().replace("_"," ")+"'),'"+fields.get(3)+"','"+fields.get(4)+"','"+fields.get(5)+"',"+userId+");";
                        break;
                        case "addArtist":
                            errorMessage = "no record label selected, select a record label or add a new one";
                            uploadPath=path+"artistCover"+File.separator;
                           for(int i=1;i<fileItems.size();i++){
                             temp = fileItems.get(i);
                             if (temp.isFormField () ) {
                                fields.add(temp.getString().trim());
                             }else{
                                fileName=temp.getName();
                                if( fileName.lastIndexOf("\\") >= 0 ) {
                                  url=uploadPath + fileName.substring( fileName.lastIndexOf("\\"));
                                  file = new File(url) ;
                                } else {
                                  url= uploadPath + fileName.substring(fileName.lastIndexOf("\\")+1);
                                  file = new File(url) ;
                                }
                                fields.add(url.substring(url.lastIndexOf("\\\\")+1).replace("\\","/"));
                                temp.write(file) ;
                             }
                             }
                             userId=fields.get(0);
                             sql= "INSERT INTO artist(artist_name,bio,birth_date,debut_date,country,label_record,artist_pic,user_id) VALUES('"+fields.get(1)+"','"+fields.get(2)+"','"+fields.get(3)+"','"+fields.get(4)+"','"+fields.get(5)+"',get_record_id('"+fields.get(6).trim().replace("_"," ")+"'),'"+fields.get(7)+"',"+userId+");";
                        break;
                        case "addRecord":
                        uploadPath=path+"recordCover"+File.separator;
                             for(int i=1;i<fileItems.size();i++){
                             temp = fileItems.get(i);
                             if (temp.isFormField () ) {
                                fields.add(temp.getString().trim());
                             }else{
                                fileName=temp.getName();
                                if( fileName.lastIndexOf("\\") >= 0 ) {
                                  url=uploadPath + fileName.substring( fileName.lastIndexOf("\\"));
                                  file = new File(url) ;
                                } else {
                                  url= uploadPath + fileName.substring(fileName.lastIndexOf("\\")+1);
                                  file = new File(url) ;
                                }
                                fields.add(url.substring(url.lastIndexOf("\\\\")+1).replace("\\","/"));
                                temp.write(file) ;
                             }
                             }
                             userId=fields.get(0);
                        sql= "INSERT INTO record_label(rec_name,description,founder,founded_date,country,cover_url,user_id) VALUES('"+fields.get(1)+"','"+fields.get(2)+"','"+fields.get(3)+"','"+fields.get(4)+"','"+fields.get(5)+"','"+fields.get(6)+"',"+userId+");";

                        }

                        if(formOption.compareTo("addSong")==0){
                             if(songUrl.equalsIgnoreCase("Invalid YouTube URL")){
                               status=0;
                               errorMessage = "Invalid YouTube URL";
                              }
                            else{
                            statement = con.prepareStatement(sql);
                            rs = statement.executeQuery();
                            while(rs.next()){
                            System.out.println("the count is: "+rs.getInt(1));
                            status=rs.getInt(1);
                                }
                            }
                        }else{
                            statement = con.prepareStatement(sql);
                            status=statement.executeUpdate();
                        }
                        System.out.println("sql: "+sql);
                        System.out.println("status: "+status);
                        rs.close();
                        statement.close();
                        con.close();
                    }catch(Exception e)
                    {
                            e.getCause();
                    }
                    System.out.println("message is: "+errorMessage);
            if(status>0){
            %>
    <div class="status_pic success"></div>
    <p class="success_notification">operation success</p>
    <%}else if(status==0){%>
    <div class="status_pic failure"></div>
        <p class="error_notification">operation failed</p>
        <p class="error_message"><%=errorMessage%></p>
    <%}%>
    <form action="main.jsp" action="get">
    <input type="hidden" name="id" value=<%=userId%>>
     <button type="submit">go back home</button>
     </form>
 </div>
  </body>
  </html>