const mysql = require('mysql')

const con=mysql.createConnection({
'host':'localhost',
'port':'3306',
'user':'root',
'password':'0delixsioxnal8',
'database':'db',
}
);

con.connect(function (err) {
    var mql="insert nick(name) values('Yhlas')";
    
    con.query(mql,function (err) {
        if (err) throw err;
        console.log("OK");
    })
})