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
                <p>Explore</p>
                <%
                 String sql = "SELECT COUNT(main_query.title) AS count FROM main_query WHERE user_id ="+userId+";";
                 PreparedStatement statement = con.prepareStatement(sql);
                 ResultSet result = statement.executeQuery();
                 result = statement.executeQuery();
                 while(result.next()){
                 %>
                <p><%=result.getString("count") %> songs available</p>
                <%}%>
                </button>
               </form>
             </li>

              <li class="main_btn" data-model=".div_add--song">
               <svg
                          xmlns="http://www.w3.org/2000/svg"
                          version="1.1"
                          viewBox="-5.0 -10.0 110.0 135.0"
                        >
                          <path
                            d="m81.285 17.258-29.824-14.914c-1.0117-0.50391-2.2148-0.45312-3.1758 0.14453-0.96094 0.59375-1.5469 1.6445-1.5469 2.7734v60.633c-4.2656-3.5586-9.918-4.9727-15.355-3.8359-5.4336 1.1367-10.051 4.6953-12.531 9.6602-2.4805 4.9648-2.5547 10.793-0.19922 15.824 2.3516 5.0273 6.8789 8.6992 12.281 9.9727 5.4062 1.2734 11.094 0.003906 15.445-3.4414 4.3516-3.4492 6.8867-8.6992 6.8828-14.25v-69.285l25.102 12.551v0.003906c0.77344 0.39062 1.6719 0.45703 2.4961 0.18359 0.82031-0.27344 1.5039-0.86328 1.8906-1.6367 0.38672-0.77734 0.44922-1.6758 0.17578-2.4961-0.27734-0.82422-0.86719-1.5039-1.6445-1.8867zm-46.199 74.219c-4.7148 0-8.9648-2.8398-10.766-7.1914-1.8047-4.3555-0.80859-9.3672 2.5234-12.699 3.332-3.332 8.3438-4.3281 12.699-2.5234 4.3516 1.8008 7.1914 6.0508 7.1914 10.762-0.007813 6.4297-5.2188 11.641-11.648 11.652z"
                          />
                        </svg>
                <p class="add_song" >Add song</p>
               </li>

             <li class="main_btn" data-model=".div_add--album">
              <svg
                         xmlns="http://www.w3.org/2000/svg"
                         version="1.1"
                         viewBox="-5.0 -10.0 110.0 135.0"
                       >
                         <path
                           d="m9.8125 30.227h57.602v-5.7188h-57.602zm25.492 31.543c-1.5664 0.37109-3.207 0.27734-4.7188-0.27344-1.4727-0.4375-2.5977-1.6367-2.9336-3.1367-0.33594-1.5 0.16406-3.0664 1.3086-4.0938 1.1094-1.125 2.5195-1.9062 4.0625-2.25 0.074218-0.023437 0.15234-0.039063 0.23047-0.050781 1.5391-0.35156 3.1523-0.25 4.6367 0.29297 0.28516 0.10938 0.5625 0.24609 0.82812 0.39844l1.9062-14.629c0.046875-0.35156 0.23047-0.67188 0.51172-0.88672s0.63672-0.3125 0.98828-0.26562c0.23047 0.03125 0.44531 0.11719 0.62891 0.25781l6.3281 4.3008 0.003907-0.003906c0.60937 0.41406 0.76562 1.2461 0.35156 1.8555s-1.2422 0.76953-1.8516 0.35547l-4.5859-3.1211-2.0898 16.008c-0.10938 1.1172-0.60156 2.1602-1.3945 2.9531-1.1094 1.1289-2.5273 1.9102-4.0703 2.2539-0.046874 0.011719-0.09375 0.023437-0.14062 0.035156zm-0.52344-2.6289 0.054688-0.011719c1.0352-0.22266 1.9844-0.73438 2.7305-1.4805 0.32031-0.31641 0.54688-0.71094 0.65234-1.1445l0.023438-0.17969c0.007812-0.11719 0-0.23438-0.027344-0.34766-0.20703-0.59766-0.69141-1.0547-1.3008-1.2305-1.0234-0.35938-2.1328-0.41406-3.1914-0.14844-1.0625 0.21094-2.043 0.73438-2.8164 1.5-0.53125 0.37109-0.78906 1.0312-0.64453 1.668 0.14453 0.63281 0.65625 1.1211 1.2969 1.2305 1.0273 0.36328 2.1367 0.41406 3.1914 0.15234zm7.3633 10.16c-0.35938 0.007813-0.71094-0.12891-0.96875-0.37891-0.26172-0.25391-0.40625-0.60156-0.40625-0.96094 0-0.36328 0.14453-0.71094 0.40625-0.96094 0.25781-0.25391 0.60938-0.39062 0.96875-0.38281h25.266v-33.711h-57.598v33.715h25c0.72656 0.019531 1.3047 0.61328 1.3047 1.3398 0 0.72656-0.57813 1.3203-1.3047 1.3398h-25v6.1875h57.602v-6.1875zm27.949-17.32h0.085938c1.0938 0 1.9805-0.88672 1.9805-1.9844 0-1.0938-0.88672-1.9805-1.9805-1.9805h-0.085938zm0-6.6406v-3.3984h0.085938v-0.003906c4.4531 0 8.0586 3.6094 8.0586 8.0625s-3.6055 8.0625-8.0586 8.0625h-0.085938v-3.3984h0.085938v-0.003906c2.5742 0 4.6602-2.0859 4.6602-4.6602s-2.0859-4.6641-4.6602-4.6641zm0 24.668v-9.2656h0.085938c5.9336 0 10.742-4.8086 10.742-10.742s-4.8086-10.742-10.742-10.742h-0.085938v-9.2656h0.085938c7.1484 0 13.754 3.8125 17.328 10.004 3.5742 6.1914 3.5742 13.816 0 20.008-3.5742 6.1914-10.18 10.004-17.328 10.004zm0-42.699h0.085938c8.1055 0 15.598 4.3242 19.648 11.344 4.0547 7.0195 4.0547 15.672 0 22.691-4.0508 7.0195-11.543 11.344-19.648 11.344h-0.085938v4.1445c0 0.35547-0.14062 0.69531-0.39453 0.94531-0.25 0.25391-0.58984 0.39453-0.94531 0.39453h-60.281c-0.74219 0-1.3398-0.60156-1.3398-1.3398v-53.664c0-0.73828 0.59766-1.3398 1.3398-1.3398h60.281c0.35547 0 0.69531 0.14062 0.94531 0.39062 0.25391 0.25391 0.39453 0.59375 0.39453 0.94922z"
                           fill-rule="evenodd"
                         />
                       </svg>
               <p class="add_album" >add album</p>
             </li>

             <li class="main_btn" data-model=".div_add--artist">
             <svg
                         xmlns="http://www.w3.org/2000/svg"
                         version="1.1"
                         viewBox="-5.0 -10.0 110.0 135.0"
                       >
                         <path
                           d="m54.168 54.793c4.418 0 8.6602-1.7578 11.785-4.8828s4.8789-7.3633 4.8789-11.785-1.7539-8.6602-4.8789-11.785-7.3672-4.8828-11.785-4.8828c-4.4219 0-8.6602 1.7578-11.785 4.8828s-4.8828 7.3633-4.8828 11.785 1.7578 8.6602 4.8828 11.785 7.3633 4.8828 11.785 4.8828zm0-27.375c4.3125 0 8.2031 2.5977 9.8516 6.582 1.6523 3.9883 0.74219 8.5742-2.3086 11.625-3.0508 3.0508-7.6406 3.9648-11.625 2.3125-3.9883-1.6523-6.5859-5.5391-6.5859-9.8555 0-5.8906 4.7773-10.664 10.668-10.664zm29.168 50-2.457-4.168h-0.003906c-3.6133-6.2695-9.3203-11.066-16.117-13.543-6.8008-2.4766-14.258-2.4766-21.055 0-6.8008 2.4766-12.508 7.2734-16.121 13.543l-2.457 4.168c-1.7539 2.9258-1.7812 6.5742-0.078125 9.5312 1.7031 2.9609 4.875 4.7617 8.2852 4.7188h41.875c3.3984 0.0625 6.5664-1.707 8.2891-4.6328 1.7266-2.9258 1.7461-6.5508 0.046875-9.4922zm-5.207 6.418-0.003906-0.003907c-0.60938 1.0547-1.7422 1.6953-2.957 1.668h-41.836c-1.2148 0.027344-2.3477-0.61328-2.957-1.668-0.60938-1.0547-0.60938-2.3594 0-3.4141l2.457-4.168c2.9102-5.043 7.5039-8.8945 12.973-10.887 5.4688-1.9922 11.465-1.9922 16.934 0 5.4688 1.9922 10.062 5.8438 12.969 10.887l2.457 4.168h0.003907c0.66016 1.0859 0.66016 2.4531 0 3.5391zm-55.297-43.461c-1.9062 0.44141-3.9102-0.007812-5.4414-1.2266-1.5352-1.2148-2.4258-3.0664-2.4258-5.0234s0.89062-3.8086 2.4258-5.0234c1.5312-1.2188 3.5352-1.668 5.4414-1.2266v-16.668c-0.089843-0.76953 0.17188-1.543 0.71484-2.1016 0.53906-0.55469 1.3047-0.83984 2.0781-0.77344h10.293c0.67969 0 1.332 0.27344 1.8125 0.76172 0.47656 0.48438 0.73828 1.1406 0.72656 1.8242 0 1.4023-1.1367 2.5391-2.5391 2.5391h-7.7109v20.211c0.066407 3.2383-2.1953 6.0625-5.375 6.707z"
                         />
                       </svg>
               <p class="add_artist" >add artist</p>
             </li>

             <li class="main_btn" data-model=".div_add--record">
             <svg
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink"
                         version="1.1"
                         x="0px"
                         y="0px"
                         viewBox="0 0 64 80"
                         style="enable-background: new 0 0 64 64"
                         xml:space="preserve"
                       >
                         <g>
                           <path
                             d="M32,5c-7.168,0-13,5.832-13,13s5.832,13,13,13s13-5.832,13-13S39.168,5,32,5z M42.949,17h-7.091   c-0.185-0.711-0.549-1.349-1.058-1.849l3.537-6.126C40.897,10.837,42.651,13.709,42.949,17z M30,18c0-1.103,0.897-2,2-2   s2,0.897,2,2s-0.897,2-2,2S30,19.103,30,18z M36.605,8.024l-3.544,6.137C32.721,14.067,32.37,14,32,14s-0.721,0.067-1.061,0.161   l-3.544-6.137C28.798,7.373,30.355,7,32,7S35.202,7.373,36.605,8.024z M25.663,9.024l3.537,6.126   c-0.509,0.5-0.873,1.138-1.058,1.849h-7.091C21.349,13.709,23.103,10.837,25.663,9.024z M21.051,19h7.091   c0.185,0.711,0.549,1.349,1.058,1.849l-3.537,6.126C23.103,25.163,21.349,22.291,21.051,19z M27.395,27.976l3.544-6.137   C31.279,21.933,31.63,22,32,22s0.721-0.067,1.061-0.161l3.544,6.137C35.202,28.627,33.645,29,32,29S28.798,28.627,27.395,27.976z    M38.337,26.976L34.8,20.849c0.509-0.5,0.873-1.138,1.058-1.849h7.091C42.651,22.291,40.897,25.163,38.337,26.976z"
                           />
                           <rect x="10" y="5" width="7" height="2" />
                           <rect x="10" y="9" width="7" height="2" />
                           <rect x="19" y="5" width="2" height="2" />
                           <rect x="47" y="29" width="7" height="2" />
                           <rect x="47" y="25" width="7" height="2" />
                           <rect x="43" y="29" width="2" height="2" />
                           <path
                             d="M51,39h1.781l1-4H55c1.654,0,3-1.346,3-3V4c0-1.654-1.346-3-3-3H9C7.346,1,6,2.346,6,4v28c0,1.654,1.346,3,3,3h1.219l1,4   H13v22H5v2h54v-2h-8V39z M19,39h1.781l1-4h20.438l1,4H45v22H19V39z M47,59h2v2h-2V59z M49,57h-2V39h2V57z M51.219,37h-6.438l-0.5-2   h7.438L51.219,37z M8,32V4c0-0.551,0.449-1,1-1h46c0.551,0,1,0.449,1,1v28c0,0.551-0.449,1-1,1H9C8.449,33,8,32.551,8,32z    M12.281,35h7.438l-0.5,2h-6.438L12.281,35z M17,39v18h-2V39H17z M15,59h2v2h-2V59z"
                           />
                           <rect x="1" y="61" width="2" height="2" />
                           <rect x="61" y="61" width="2" height="2" />
                         </g>
                       </svg>
               <p class="add_artist" >add record label</p>
             </li>

             <li class="main_btn" data-model=".div_search--song">
             <svg
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:cc="http://creativecommons.org/ns#"
                         xmlns:dc="http://purl.org/dc/elements/1.1/"
                         xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                         version="1.1"
                         viewBox="0 0 48 60"
                         x="0px"
                         y="0px"
                       >
                         <g shape-rendering="auto">
                           <path
                             d="m29.999 31a0.9996 0.99958 0 0 0-0.69691 1.7159l6.977 6.9768a0.9996 0.99958 0 1 0 1.4134-1.4133l-6.977-6.9768a0.9996 0.99958 0 0 0-0.71644-0.30258z"
                             color="#000000"
                             color-rendering="auto"
                             dominant-baseline="auto"
                             image-rendering="auto"
                             solid-color="#000000"
                             style="
                               font-feature-settings: normal;
                               font-variant-alternates: normal;
                               font-variant-caps: normal;
                               font-variant-ligatures: normal;
                               font-variant-numeric: normal;
                               font-variant-position: normal;
                               isolation: auto;
                               mix-blend-mode: normal;
                               shape-padding: 0;
                               text-decoration-color: #000000;
                               text-decoration-line: none;
                               text-decoration-style: solid;
                               text-indent: 0;
                               text-orientation: mixed;
                               text-transform: none;
                               white-space: normal;
                             "
                           />
                           <path
                             d="m21 10c-7.1679 0-13 5.8321-13 13s5.8321 13 13 13 13-5.8321 13-13c0-2.5523-0.75115-5.0476-2.1602-7.1758a1.0001 1.0001 0 1 0-1.668 1.1035c1.1923 1.8009 1.8281 3.9124 1.8281 6.0723 0 6.087-4.913 11-11 11s-11-4.913-11-11 4.913-11 11-11c1.2505 0 2.4911 0.21358 3.6699 0.63086a1.0001 1.0001 0 1 0 0.66797-1.8848c-1.3931-0.49314-2.8601-0.74609-4.3379-0.74609z"
                             color="#000000"
                             color-rendering="auto"
                             dominant-baseline="auto"
                             image-rendering="auto"
                             solid-color="#000000"
                             style="
                               font-feature-settings: normal;
                               font-variant-alternates: normal;
                               font-variant-caps: normal;
                               font-variant-ligatures: normal;
                               font-variant-numeric: normal;
                               font-variant-position: normal;
                               isolation: auto;
                               mix-blend-mode: normal;
                               paint-order: fill markers stroke;
                               shape-padding: 0;
                               text-decoration-color: #000000;
                               text-decoration-line: none;
                               text-decoration-style: solid;
                               text-indent: 0;
                               text-orientation: mixed;
                               text-transform: none;
                               white-space: normal;
                             "
                           />
                           <path
                             d="m33.998 34a1.9979 1.9978 0 0 0-1.3929 3.4296l3.9564 3.9563a1.9979 1.9978 0 1 0 2.8249-2.8248l-3.9564-3.9563a1.9979 1.9978 0 0 0-1.432-0.60476z"
                             color="#000000"
                             color-rendering="auto"
                             dominant-baseline="auto"
                             image-rendering="auto"
                             solid-color="#000000"
                             style="
                               font-feature-settings: normal;
                               font-variant-alternates: normal;
                               font-variant-caps: normal;
                               font-variant-ligatures: normal;
                               font-variant-numeric: normal;
                               font-variant-position: normal;
                               isolation: auto;
                               mix-blend-mode: normal;
                               shape-padding: 0;
                               text-decoration-color: #000000;
                               text-decoration-line: none;
                               text-decoration-style: solid;
                               text-indent: 0;
                               text-orientation: mixed;
                               text-transform: none;
                               white-space: normal;
                             "
                           />
                           <path
                             d="m25 6.0001a1 1.0001 0 0 0-0.99992 0.99996v15.986a1 1.0001 0 1 0 1.9998 0v-14.986h4.9859a1 1.0001 0 1 0 0-1.9999z"
                             color="#000000"
                             color-rendering="auto"
                             dominant-baseline="auto"
                             image-rendering="auto"
                             solid-color="#000000"
                             style="
                               font-feature-settings: normal;
                               font-variant-alternates: normal;
                               font-variant-caps: normal;
                               font-variant-ligatures: normal;
                               font-variant-numeric: normal;
                               font-variant-position: normal;
                               isolation: auto;
                               mix-blend-mode: normal;
                               shape-padding: 0;
                               text-decoration-color: #000000;
                               text-decoration-line: none;
                               text-decoration-style: solid;
                               text-indent: 0;
                               text-orientation: mixed;
                               text-transform: none;
                               white-space: normal;
                             "
                           />
                           <path
                             d="m21 18c-2.7496 0-5 2.2504-5 5s2.2504 5 5 5 5-2.2504 5-5-2.2504-5-5-5zm0 2c1.6687 0 3 1.3313 3 3s-1.3313 3-3 3-3-1.3313-3-3 1.3313-3 3-3z"
                             color="#000000"
                             color-rendering="auto"
                             dominant-baseline="auto"
                             image-rendering="auto"
                             solid-color="#000000"
                             style="
                               font-feature-settings: normal;
                               font-variant-alternates: normal;
                               font-variant-caps: normal;
                               font-variant-ligatures: normal;
                               font-variant-numeric: normal;
                               font-variant-position: normal;
                               isolation: auto;
                               mix-blend-mode: normal;
                               paint-order: fill markers stroke;
                               shape-padding: 0;
                               text-decoration-color: #000000;
                               text-decoration-line: none;
                               text-decoration-style: solid;
                               text-indent: 0;
                               text-orientation: mixed;
                               text-transform: none;
                               white-space: normal;
                             "
                           />
                         </g>
                       </svg>
               <p >search song</p>
             </li>

             <li class="main_btn" data-model=".div_search--album">
             <svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="-5.0 -10.0 110.0 135.0">
              <path d="m12.598 21.762c6.9023-9.1406 16.914-15.441 28.141-17.703 11.23-2.2656 22.902-0.33594 32.805 5.418 2.8008 1.625 5.4258 3.5312 7.832 5.6953 2.2227 1.9961 4.2461 4.207 6.043 6.5898h6.2539c1.7695 0.003906 3.2031 1.4375 3.2031 3.207v68.703c-0.003906 1.7656-1.4336 3.1992-3.2031 3.2031h-87.344c-1.7695-0.003906-3.1992-1.4375-3.2031-3.2031v-68.703c0-1.7695 1.4336-3.2031 3.2031-3.207zm66.426 59.098c0.55859 0.003906 1.0586 0.33984 1.2695 0.85156 0.21094 0.51172 0.089843 1.1055-0.30078 1.4961-0.39453 0.39062-0.98438 0.50781-1.4961 0.29297-0.51562-0.21094-0.84766-0.71484-0.84766-1.2695 0-0.36328 0.14453-0.71484 0.40234-0.96875 0.25781-0.25781 0.60938-0.40234 0.97266-0.40234zm5.4922 0c0.55469 0 1.0586 0.33594 1.2695 0.84766 0.21484 0.51172 0.097656 1.1055-0.29688 1.4961-0.39062 0.39453-0.98438 0.51172-1.4961 0.29688-0.51172-0.21094-0.84766-0.71484-0.84766-1.2695 0.003907-0.75391 0.61719-1.3672 1.3711-1.3711zm5.4922 0c0.55469 0 1.0586 0.33594 1.2695 0.84766 0.21484 0.51172 0.097656 1.1055-0.29688 1.4961-0.39062 0.39453-0.98438 0.51172-1.4961 0.29688-0.51172-0.21094-0.84766-0.71484-0.84766-1.2695 0-0.36328 0.14453-0.71094 0.40234-0.96875 0.25781-0.25781 0.60547-0.40234 0.96875-0.40234zm-6.082-59.098c-8.3906-10.066-20.82-15.887-33.922-15.887-13.105 0-25.535 5.8203-33.922 15.887h3.6797c5.2422-5.6094 11.949-9.6484 19.363-11.656 0.35156-0.097657 0.72656-0.050781 1.043 0.12891 0.31641 0.17969 0.54688 0.47656 0.64062 0.82812 0.097656 0.35156 0.046875 0.72656-0.13281 1.0391-0.18359 0.31641-0.48047 0.54688-0.83203 0.64063-6.0586 1.6445-11.625 4.7422-16.215 9.0195h4.2344c1.6055-1.2578 3.3164-2.3711 5.1133-3.3359 1.9492-1.0469 3.9883-1.9102 6.0977-2.582 0.71875-0.22656 1.4883 0.17188 1.7148 0.89062 0.22656 0.71875-0.17187 1.4883-0.89062 1.7148-1.9414 0.625-3.8281 1.4258-5.625 2.3906-0.54688 0.29688-1.0781 0.60156-1.6094 0.92578h10.738v-0.003906c0.57812 0 1.0977 0.36328 1.293 0.91016 0.46875 0.99609 1.2031 1.8398 2.1289 2.4375 1.9375 1.2461 4.4219 1.2461 6.3594 0 0.92188-0.59766 1.6562-1.4414 2.1211-2.4375 0.19922-0.54688 0.71484-0.90625 1.293-0.91016zm-41.352 2.7461h-36.246c-0.25391 0.003907-0.45703 0.21094-0.45703 0.46094v6.5664h88.258v-6.5664c0-0.25-0.20312-0.45703-0.45703-0.46094h-36.238c-1.5352 2.6523-4.3672 4.2852-7.4297 4.2852-3.0664 0-5.8984-1.6328-7.4297-4.2852zm-36.703 9.7773v52.066h88.258v-52.066zm0 54.812v4.5742c0 0.25 0.20703 0.45312 0.45703 0.45703h87.344c0.25391-0.003906 0.45703-0.20703 0.45703-0.45703v-4.5742zm44.129-49.293c6.375 0 12.391 2.9648 16.273 8.0234 3.8828 5.0586 5.1914 11.637 3.5391 17.797-1.6484 6.1602-6.0703 11.203-11.961 13.641-5.8906 2.4414-12.582 2.0039-18.105-1.1836-5.5234-3.1875-9.25-8.7617-10.082-15.086-0.83594-6.3203 1.3203-12.672 5.8281-17.18 3.8438-3.8555 9.0625-6.0195 14.508-6.0117zm12.566 7.9531c-3.9062-3.9062-9.4062-5.7695-14.879-5.0469-5.4766 0.72266-10.305 3.9492-13.062 8.7305-2.7617 4.7852-3.1367 10.578-1.0234 15.68 2.1133 5.1016 6.4805 8.9297 11.812 10.355 5.3359 1.4297 11.031 0.29688 15.41-3.0664 4.3828-3.3633 6.9492-8.5703 6.9492-14.094 0.003906-4.7109-1.8711-9.2344-5.207-12.559zm-16.801 3.2891 13.547-1.2812c0.082031-0.015625 0.16406-0.027344 0.25-0.027344 0.75781 0.003907 1.3711 0.61719 1.3672 1.375v13.793c0 2.0781-1.3711 3.9062-3.3672 4.4883-1.9961 0.58594-4.1367-0.21484-5.2578-1.9609-1.125-1.75-0.96094-4.0273 0.39844-5.6016 1.3594-1.5703 3.5898-2.0586 5.4805-1.1992v-2.7969l-11.031 1.043v7.3281h0.003906c0 2.0781-1.3711 3.9102-3.3672 4.4961-1.9922 0.58594-4.1328-0.21094-5.2578-1.9609-1.125-1.7461-0.96484-4.0273 0.39453-5.6016 1.3594-1.5703 3.5938-2.0586 5.4844-1.1992v-9.5234c0-0.75 0.60547-1.3594 1.3555-1.3711zm12.422 1.5742-11.031 1.043v2.4648l11.031-1.043zm-0.57031 10.91h-0.003907c-0.65234-0.65234-1.6758-0.75-2.4414-0.23438-0.76562 0.51172-1.0625 1.4961-0.71094 2.3477 0.35547 0.85156 1.2617 1.3359 2.1641 1.1562 0.90625-0.17969 1.5586-0.97266 1.5586-1.8945v-0.011719c0-0.51172-0.20703-1.0039-0.57031-1.3633zm-13.77 1.3047-0.003906-0.003907c-0.65625-0.66406-1.6914-0.76953-2.4688-0.25391s-1.082 1.5078-0.73047 2.3711c0.35547 0.86328 1.2695 1.3555 2.1836 1.1758 0.91797-0.17578 1.5781-0.98047 1.582-1.9102v-0.015625c-0.003906-0.51172-0.20703-1.0039-0.56641-1.3672z"/>
             </svg>
               <p >search album</p>
             </li>

             <li class="main_btn" data-model=".div_search--artist">
             <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 32 40" style="enable-background:new 0 0 32 32;" xml:space="preserve"><path d="M31.12,26.88l-7.07-7.07C25.28,17.83,26,15.5,26,13c0-1.8-0.36-3.56-1.08-5.21c-0.22-0.51-0.81-0.74-1.32-0.52  c-0.51,0.22-0.74,0.81-0.52,1.32C23.69,9.99,24,11.47,24,13c0,3.47-1.62,6.57-4.14,8.59c-0.43-2.09-1.8-3.84-3.64-4.8  C17.3,15.87,18,14.52,18,13V6h3c1.65,0,3-1.35,3-3s-1.35-3-3-3h-2c-1.65,0-3,1.35-3,3v6.03C15.16,8.39,14.13,8,13,8  c-2.76,0-5,2.24-5,5c0,1.52,0.7,2.87,1.78,3.79c-1.84,0.96-3.21,2.71-3.64,4.8C3.62,19.57,2,16.47,2,13C2,6.93,6.93,2,13,2  c0.08,0,0.17,0,0.25,0.01c0.55,0.05,1.04-0.36,1.08-0.91c0.05-0.55-0.36-1.04-0.91-1.08C13.29,0,13.14,0,13,0C5.83,0,0,5.83,0,13  c0,7.17,5.83,13,13,13c2.5,0,4.83-0.72,6.81-1.95l7.07,7.07C27.45,31.69,28.21,32,29,32s1.55-0.31,2.11-0.88  C31.69,30.55,32,29.8,32,29S31.69,27.45,31.12,26.88z M18,3c0-0.55,0.45-1,1-1h2c0.55,0,1,0.45,1,1s-0.45,1-1,1h-3V3z M10,13  c0-1.65,1.35-3,3-3s3,1.35,3,3s-1.35,3-3,3S10,14.65,10,13z M8.02,22.8C8.13,20.14,10.31,18,13,18s4.87,2.14,4.98,4.8  C16.48,23.56,14.79,24,13,24S9.52,23.56,8.02,22.8z M29.7,29.7c-0.38,0.38-1.02,0.38-1.41,0l-6.86-6.84  c0.51-0.44,0.98-0.91,1.42-1.42l6.85,6.85C29.9,28.49,30,28.74,30,29S29.9,29.51,29.7,29.7z"/></svg>
               <p >search artist</p>
             </li>

             <li class="main_btn" data-model=".div_search--record">
             <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 40" x="0px" y="0px"><g data-name="disk jockey"><path d="M27.5,6H4.5a.49971.49971,0,0,0-.5.5v20a.49971.49971,0,0,0,.5.5h23a.49971.49971,0,0,0,.5-.5V6.5A.49971.49971,0,0,0,27.5,6ZM27,26H5V7H27ZM12.25,24.75A6.48818,6.48818,0,0,0,17.87048,15h1.09388l2.32342,5.39655a2.13735,2.13735,0,1,0,.91815-.39716l-2.453-5.69714A.50017.50017,0,0,0,19.29346,14H17.15668A6.49642,6.49642,0,1,0,12.25,24.75Zm11.25928-2.78125a1,1,0,0,1-2,0,.975.975,0,0,1,.20648-.57813l.334.77588a.50022.50022,0,0,0,.91895-.3955l-.33453-.77692A.99013.99013,0,0,1,23.50928,21.96875ZM12.25,12.75a5.47663,5.47663,0,0,1,3.80249,1.53564A.49119.49119,0,0,0,16,14.5a.49971.49971,0,0,0,.5.5h.17694A5.49329,5.49329,0,1,1,12.25,12.75Zm-2,5.5a2,2,0,1,0,2-2A2.002,2.002,0,0,0,10.25,18.25Zm2-1a1,1,0,1,1-1,1A1.0013,1.0013,0,0,1,12.25,17.25Zm2.01855,4.25049a3.741,3.741,0,0,0,1.79053-3.20508.5.5,0,1,1,1,0A4.73613,4.73613,0,0,1,14.793,22.352a.5.5,0,1,1-.52442-.85156ZM8.03271,18.79541a.49972.49972,0,0,1-.5-.5,4.769,4.769,0,0,1,2.83936-4.35889.50019.50019,0,0,1,.4043.915,3.76739,3.76739,0,0,0-2.24366,3.44385A.49971.49971,0,0,1,8.03271,18.79541ZM6,9.5A.49971.49971,0,0,1,6.5,9H13V8.5a.5.5,0,0,1,1,0V9h1.5a.5.5,0,0,1,0,1H14v.5a.5.5,0,0,1-1,0V10H6.5A.49971.49971,0,0,1,6,9.5ZM21.5,12h4a.49971.49971,0,0,0,.5-.5v-3a.49971.49971,0,0,0-.5-.5h-4a.49971.49971,0,0,0-.5.5v3A.49971.49971,0,0,0,21.5,12ZM22,9h3v2H22Z"/></g></svg>
              <p >search record label</p>
              </li>

           </ul>

      <div class="form div_search--song inactive">
        <button class="close_tab">
         <svg
                          xmlns="http://www.w3.org/2000/svg"
                          xmlns:xlink="http://www.w3.org/1999/xlink"
                          version="1.1"
                          x="0px"
                          y="0px"
                          viewBox="0 0 100 125"
                          style="enable-background: new 0 0 100 100"
                          xml:space="preserve"
                        >
                          <style type="text/css">
                            .st0 {
                              fill-rule: evenodd;
                              clip-rule: evenodd;
                            }
                          </style>
                          <path
                            class="st0"
                            d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"
                          />
                        </svg></button>
        <h1>search song</h1>
        <form action="index.jsp" method="get">
         <input type="hidden"  name="id" value=<%=userId%> />
          <div class="input_container">
            <label for="song_name">title</label>
            <input type="text" id="song_name" placeholder="song name" name="title" required />
          </div>
          <button class="search_song form-button">search song</button>
        </form>
      </div>

  <div class="form div_search--album inactive">
         <button class="close_tab">
          <svg
                           xmlns="http://www.w3.org/2000/svg"
                           xmlns:xlink="http://www.w3.org/1999/xlink"
                           version="1.1"
                           x="0px"
                           y="0px"
                           viewBox="0 0 100 125"
                           style="enable-background: new 0 0 100 100"
                           xml:space="preserve"
                         >
                           <style type="text/css">
                             .st0 {
                               fill-rule: evenodd;
                               clip-rule: evenodd;
                             }
                           </style>
                           <path
                             class="st0"
                             d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"
                           />
                         </svg></button>
         <h1>search album</h1>
         <form action="album_list.jsp" method="get">
         <input type="hidden"  name="id" value=<%=userId%> />
           <div class="input_container">
             <label for="song_name">title</label>
             <input type="text" id="album_name" placeholder="album name" name="album_title" required />
           </div>
           <button class="add form-button" >search album</button>
         </form>
       </div>

       <div class="form div_search--artist inactive">
         <button class="close_tab">
          <svg
                           xmlns="http://www.w3.org/2000/svg"
                           xmlns:xlink="http://www.w3.org/1999/xlink"
                           version="1.1"
                           x="0px"
                           y="0px"
                           viewBox="0 0 100 125"
                           style="enable-background: new 0 0 100 100"
                           xml:space="preserve"
                         >
                           <style type="text/css">
                             .st0 {
                               fill-rule: evenodd;
                               clip-rule: evenodd;
                             }
                           </style>
                           <path
                             class="st0"
                             d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"
                           />
                         </svg>
         </button>
         <h1>search artist</h1>
         <form action="artist_list.jsp" method="get">
         <input type="hidden"  name="id" value=<%=userId%> />
           <div class="input_container">
             <label for="artist_name">title</label>
             <input type="text" id="artist_name" placeholder="artist name" name="artist_name" required />
           </div>

           <button class="add form-button">search artist</button>
         </form>
       </div>

       <div class="form div_search--record inactive">
               <button class="close_tab">
                <svg
                                 xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink"
                                 version="1.1"
                                 x="0px"
                                 y="0px"
                                 viewBox="0 0 100 125"
                                 style="enable-background: new 0 0 100 100"
                                 xml:space="preserve"
                               >
                                 <style type="text/css">
                                   .st0 {
                                     fill-rule: evenodd;
                                     clip-rule: evenodd;
                                   }
                                 </style>
                                 <path
                                   class="st0"
                                   d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"
                                 />
                               </svg></button>
               <h1>search record label</h1>
               <form action="record_list.jsp" method="get">
               <input type="hidden"  name="id" value=<%=userId%> />
                 <div class="input_container">
                   <label for="record_title">title</label>
                   <input type="text" id="record_title" name="record_title" placeholder="record label title" required />
                 </div>
                 <button class="add form-button">search record label</button>
               </form>
       </div>

        <div class="form div_add--song inactive">
               <button class="close_tab">
                <svg
                                 xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink"
                                 version="1.1"
                                 x="0px"
                                 y="0px"
                                 viewBox="0 0 100 125"
                                 style="enable-background: new 0 0 100 100"
                                 xml:space="preserve"
                               >
                                 <style type="text/css">
                                   .st0 {
                                     fill-rule: evenodd;
                                     clip-rule: evenodd;
                                   }
                                 </style>
                                 <path
                                   class="st0"
                                   d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"
                                 />
                               </svg></button>
                       <h1>add song</h1>
                       <form action="add_page.jsp" enctype = "multipart/form-data" method="post">
                        <input type="hidden" name="addOption" value="addSong">
                        <input type="hidden"  name="id" value=<%=userId%> />
                         <div class="input_container">
                           <label for="song_title">song title</label>
                           <input type="text" id="song_title" placeholder="song title" name="song_title" required />
                         </div>

                         <div class="input_container selectable">
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

                         <div class="input_container release_date selectable">
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

                           <div class="input_container selectable">
                             <label for="song_cover">cover</label>
                             <input type="file" id="song_cover" accept="image/*"  name="song_cover" required/>
                           </div>

                         <button class="add add-song form-button">add</button>
                       </form>
        </div>

         <div class="form div_add--artist inactive">
                 <button class="close_tab">
                  <svg
                                   xmlns="http://www.w3.org/2000/svg"
                                   xmlns:xlink="http://www.w3.org/1999/xlink"
                                   version="1.1"
                                   x="0px"
                                   y="0px"
                                   viewBox="0 0 100 125"
                                   style="enable-background: new 0 0 100 100"
                                   xml:space="preserve"
                                 >
                                   <style type="text/css">
                                     .st0 {
                                       fill-rule: evenodd;
                                       clip-rule: evenodd;
                                     }
                                   </style>
                                   <path
                                     class="st0"
                                     d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"
                                   />
                                 </svg></button>
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
                   <div class="input_container release_date selectable">
                     <label for="birth_date">birth date</label>
                     <input type="date" id="birth_date" name="birth_date" required/>
                   </div>
                  <div class="input_container release_date selectable">
                       <label for="debut_date">debut date</label>
                       <input type="date" id="debut_date" name="debut_date" required/>
                  </div>
                  <div class="input_container">
                        <label for="artist_country">country</label>
                        <input type="text" id="artist_country" placeholder="artist country" name="artist_country" required/>
                  </div>
                  <div class="input_container selectable">
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
                  <div class="input_container selectable">
                     <label for="artist_cover">cover</label>
                     <input type="file" id="artist_cover" accept="image/*"  name="artist_cover" required/>
                  </div>
                   <button class="add form-button">add</button>
                 </form>
         </div>

       <div class="form div_add--album inactive">
         <button class="close_tab">
          <svg
                           xmlns="http://www.w3.org/2000/svg"
                           xmlns:xlink="http://www.w3.org/1999/xlink"
                           version="1.1"
                           x="0px"
                           y="0px"
                           viewBox="0 0 100 125"
                           style="enable-background: new 0 0 100 100"
                           xml:space="preserve"
                         >
                           <style type="text/css">
                             .st0 {
                               fill-rule: evenodd;
                               clip-rule: evenodd;
                             }
                           </style>
                           <path
                             class="st0"
                             d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"
                           />
                         </svg></button>
         <h1>add album</h1>
            <form action="add_page.jsp" enctype = "multipart/form-data" method="post">
               <input type="hidden" name="addOption" value="addAlbum">
               <input type="hidden"  name="id" value=<%=userId%> />

           <div class="input_container selectable">
             <label for="album_title">album title</label>
             <input type="text" id="album_title" placeholder="album title" name="album_title" required/>
           </div>

           <div class="input_container selectable">
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

           <div class="input_container release_date selectable">
                <label for="release_date">release date</label>
                <input type="date" id="release_date" name="release_date" required/>
           </div>

           <div class="input_container selectable">
             <label for="album_cover">cover</label>
             <input type="file" id="album_cover" accept="image/*"  name="album_cover" required/>
           </div>

           <button class="add form-button">add</button>
         </form>
       </div>

       <div class="form div_add--record inactive">
               <button class="close_tab">
                <svg
                                 xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink"
                                 version="1.1"
                                 x="0px"
                                 y="0px"
                                 viewBox="0 0 100 125"
                                 style="enable-background: new 0 0 100 100"
                                 xml:space="preserve"
                               >
                                 <style type="text/css">
                                   .st0 {
                                     fill-rule: evenodd;
                                     clip-rule: evenodd;
                                   }
                                 </style>
                                 <path
                                   class="st0"
                                   d="M50,10.024c22.078,0,39.976,17.899,39.976,39.976S72.078,89.976,50,89.976  c-22.078,0-39.976-17.898-39.976-39.976C10.024,27.922,27.922,10.024,50,10.024L50,10.024z M64.85,61.987L52.863,50L64.85,38.013  c1.884-1.884-0.978-4.746-2.862-2.862L50,47.138L38.013,35.15c-1.884-1.884-4.746,0.978-2.862,2.862L47.138,50L35.151,61.987  c-1.884,1.884,0.978,4.746,2.862,2.862L50,52.862l11.987,11.987C63.871,66.733,66.734,63.871,64.85,61.987L64.85,61.987z   M75.405,24.595c-14.03-14.031-36.78-14.031-50.811,0c-14.03,14.03-14.031,36.78,0,50.811c14.031,14.031,36.78,14.03,50.811,0  C89.436,61.375,89.436,38.625,75.405,24.595z"
                                 />
                               </svg></button>
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

                                <div class="input_container release_date selectable">
                                     <label for="record_label_date">date</label>
                                     <input type="date" id="record_label_date"  name="record_label_date" required/>
                                </div>

                                <div class="input_container">
                                      <label for="record_label_country">country</label>
                                      <input type="text" id="record_label_country" placeholder="record_label_country" name="record_label_country" required/>
                                </div>
                 <div class="input_container selectable">
                      <label for="record_label_cover">cover</label>
                      <input type="file" id="record_label_cover" accept="image/*"  name="record_label_cover" required/>
                 </div>

                 <button class="add form-button">add record label</button>
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