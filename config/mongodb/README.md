```sh
brew tap mongodb/brew
brew search mongodb
brew install mongodb-community@4.2

mongod --config /usr/local/etc/mongod.conf --fork
# brew services start mongodb-community

ps aux | grep mongod

tail -fn 100 /usr/local/var/log/mongodb/mongo.log
mongod --version

# ⌘+T 新窗口  Connect and Use MongoDB 
mongo
mongo --port 28015
mongo --host mongodb0.example.com:28015
```

