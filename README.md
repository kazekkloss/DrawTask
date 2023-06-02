# DrawTask

  

DrawTask is a mobile game that involves drawing pictures based on received words. The user can play with friends or with random players. The game is being developed using the Flutter framework, while the backend is being written in Node.js.

  

If you would like to learn more about the project, please feel free to check out the case study

prepared by **Patrycja** [here](https://www.behance.net/gallery/168964301/DrawTask).

  

The application uses several essential libraries:

  **Flutter :**

* **bloc and flutter_bloc :** These libraries allow for easy state management in the application. Data retrieved from the database is directly passed to the state, which is then propagated to screens and other components.

* **http :** This library handles HTTP requests and retrieves data from the database, such as checking if a user is logged in or retrieving lists of friends.

* **socket_io_client :** With this library, data is retrieved from the database similar to http, but with the difference that the user joins a socket room where other users within the game are present. When a user makes changes in the game, such as voting, other users are notified, and the game state automatically updates.

* **go_router :** This extension is used for navigating between screens. It makes implementing a bottom navigation bar for specific screens easy and intuitive in the code.

**Node.js :**  

* **bcryptjs** - We prioritize the security of individuals logging into our application, which is why every password is hashed in the database. 

* **jsonwebtoken** - It is a Node.js extension that handles user token authentication. 

* **mongoose** - Mongoose is an object modeling tool for MongoDB, specifically designed to work in an asynchronous environment. 

* **nodemailer** - It sends account confirmation emails to the users' registered email addresses when they create an account. 

* **socket.io** - It handles real-time socket communication on the backend side.

*Please be aware that the project is still in progress! Enjoy! :)*