# sap-mfg-industry40-innovation

# Install
- Install nodejs and npm from https://nodejs.org/download/
- Install gulp globally `npm install gulp -g`
- Enter project directory, install required modules `npm install`
- Run gulp `gulp` This will produce js and css files. If you need gulp to watch change of less and coffee file for real time update, 
keep this cmd run and open another cmd to do following actions
- Start node server with `npm start` or `node bin/www` in project directory
- If you want the node server auto restart when files changes, install nodemon with `npm install nodemon -g` 
Then start node server with `nodemon bin/www`
- Open [http://localhost:3000](http://localhost:3000) to check server started
- If mongodb is needed for your development, refer to [http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)

# Code Style
- Use 2 spaces as tab size and indent size in almost all files(coffee, js, json, jade, less, css)

# Issues
- If face issue in npm install, add parameter -ddd like `npm install gulp -g -ddd` to check detailed log

# Tool
- Recommend some tools WebStorm, Sublime, SourceTree, iTerm
