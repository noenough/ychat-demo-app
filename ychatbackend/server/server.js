const ws = require('ws');
const mysql = require('mysql')
const wsServer=ws.WebSocketServer;
const wsport=5000;
const wss=new wsServer({port:wsport,host:'0.0.0.0'});

const con=mysql.createConnection({
'host':'localhost',
'user':'root',
'password':'0delixsioxnal8',
'port':3306,
'database':'db',
});

var curmes=new Array();
con.connect(function(err) {
    if (err) console.log("msql error:"+err);
    con.query("select mes from messages",function (err,data) {
        for (let index = 0; index < data.length; index++) {
            curmes.push(data[index].mes);
        }
    })
});

wss.on('connection',(wsocket)=>{
console.log('Connected!');
curmes.forEach((msg)=>{
    wsocket.send("user "+msg);

})
  wsocket.on('message',(message)=>{
  curmes.push(message.toString());
  wss.clients.forEach(function each(client) {
  client.send(message.toString()); 
        
    });
     
     console.log(message.toString());

    var s=message.toString();
    var x=s.replaceAll('"',"'");
    con.query("insert messages(mes) values(\""+x+"\")");
});  
});