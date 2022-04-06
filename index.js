const express = require('express');

const app = express ();
var Client = require('node-rest-client').Client;

var client = new Client();

const  PORT = 3000;

// GET
app.get("/primarystudents", (request, res) => {
    
    
//     client.get("https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=35955b972e7856e5a652caf536cf27e4", function (data, response) {
// 	// parsed response body as js object
// 	//console.log(data);
// 	// raw response
// 	//console.log(response);
// });
res.send("qaz");
});
//POST
app.post("/create", (request, response) => {
    response.send("This is a POST request at /create");
});
//PUT
app.put("/edit", (request, response) => {
    response.send("This is a PUT request at /edit");
});
//DELETE
app.delete("/delete", (request, response) => {
    response.send("This is a DELETE request at /delete");
});

app.listen(PORT, () => {
    console.log (`The server is running on port ${PORT}`);
    // console.log(data);
});





