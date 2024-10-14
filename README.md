# Project Description
I developed this project using Java, and PostgreSQL, creating a full web site where users can manage songs, albums, artists, and record labels, enabling them to perform all CRUD operations with ease. Java and JSP are used for server-side processing and dynamic content generation, while Java handles communication with the PostgreSQL database, Frontend technologies like HTML, CSS, and JavaScript are utilized to provide an interactive user experience, making this a comprehensive system for managing music-related data.



# Project preview
- singup/login page

![Screenshot 2024-10-14 115433](https://github.com/user-attachments/assets/38c65bb9-167c-4366-b733-aec071414a5f)

![Untitledvideo-MadewithClipchamp-ezgif com-resize](https://github.com/user-attachments/assets/d3f4f947-f11e-4ab3-96e3-d857ac0cecf5)

- Main page

![Screenshot 2024-10-14 115507](https://github.com/user-attachments/assets/4e30a430-e504-4c7e-a737-ab82c95ec076)

![mainmenu-ezgif com-resize (1)](https://github.com/user-attachments/assets/03aec7ae-dd5e-470a-899c-739baa1e63cd)

- Library page
  
![Screenshot 2024-10-14 120105](https://github.com/user-attachments/assets/7f8c33c2-81ce-409f-8bd5-542384cbf9b7)

![library-ezgif com-resize](https://github.com/user-attachments/assets/2cf7055e-36a6-4c14-a05d-0f01ddda9980)

- Song Preview Page
  
![Screenshot 2024-10-14 120309](https://github.com/user-attachments/assets/96227553-d7b6-4e64-81ea-4493aa77342b)


- Album Preview Page

![Screenshot 2024-10-14 120634](https://github.com/user-attachments/assets/e2e32341-26d1-41af-ae9c-145e18d8bb7f)

- Artist Page

![Screenshot 2024-10-14 181943](https://github.com/user-attachments/assets/84ce004e-0047-4e37-a94b-9851633785c1)



# Project features
- **User Authentication:**
  - User **Sign Up**: Register a new account.
  - User **Login**: Access the platform with credentials.

- **Record Label Management:**
  - **Add Record Labels**: Create new record label entries.
  - **Update Record Labels**: Modify details of existing record labels.
  - **Delete Record Labels**: Remove record labels.
  - **Search Record Labels**: Search for record labels by name.

- **Artist Management:**
  - **Add Artists**: Add new artists to the database.
  - **Update Artists**: Modify artist details.
  - **Delete Artists**: Remove artists from the system.
  - **Search Artists**: Find artists by name and record label.

- **Album Management:**
  - **Add Albums**: Create new album entries.
  - **Update Albums**: Edit details of existing albums.
  - **Delete Albums**: Remove albums.
  - **Search Albums**: Search for albums by title and artist.

- **Song Management:**
  - **Add Songs**: Add new songs to albums or artists.
  - **Update Songs**: Modify song details.
  - **Delete Songs**: Remove songs from the system.
  - **Search Songs**: Find songs by title and album.

- **Filtering and Retrieval:**
  - **Get Songs by Name:**:"Retrieve a song by its full name if provided, or fetch all songs that begin with the characters entered by the user."
  - **Get Songs by Album**: Retrieve all songs belonging to a specific album.
  - **Get Songs by Artist**: Retrieve all songs by a specific artist.
  - **Get Songs by Record Label**: Retrieve all songs under a specific record label.



# Tech stack

- **Frontend**: HTML, CSS, JavaScript
- **Backend**: Java, JSP
- **Database**: PostgreSQL


  
# Development environment

- **JDK**: jdk-18.0.1
- **Apache Tomcat**: Version 9.0.91
- **PostgreSQL**: Version 15
- **Intellij IDEA**: Version 2022.1.1


# Restoring the Database

1. Open **Git Bash** or your WSL terminal.
2. Ensure you have the path to the database file, in the project it is located at `src\main\webapp\Database`
3. Run the following command to restore the database:

   ```bash
   psql -U username -d database_name -f path_to_db_file.sql
   ```

   Replace the placeholders:
   - `username`: Your PostgreSQL username (usually `postgres`).
   - `database_name`: The name of the database where the backup will be restored.
   - `path_to_db_file.sql`: The path to your database file.

4. When prompted, enter the password for the PostgreSQL user.
