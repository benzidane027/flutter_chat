# flutter_chat
this is an open source flutter and nodejs app with mysql database server

to run the aplication :
firstly make sure you installed flutter + nodejs + mysql on your pc

1)***************************************************************

start your mysql server 
to import database tap the command: 

mysql --user root --password  < sendify.sql

note: root is user account name  for mysql

2)***************************************************************

go to sendify-server open the terminla and tap :

        nodemone  
or:
        node bin/wwww
        
3)***************************************************************

start vscode or any editor import sendify folde tap the command: flutter run

****************************************************************
very important:
          in sendify server in the function toDatabase change your right creadinial 
          in flutter model change the host ip to right on your network
          make sure application and serever in same network
