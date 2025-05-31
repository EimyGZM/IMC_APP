const express = require("express");

const app = express();

app.use(express.json());

app.use(express.urlencoded({
    extended:true
}))


const userData = [];
port = 3000;


app.listen(port, ()=>{
    console.log('Successfully connected to port ${port}');
});

// POST API

app.post("/api/add_usuario", (req,res)=>{

    console.log("Result:",req.body);
    const pdata = {
        "id": userData.length+1,
        "nombre": req.body.nombre,
        "user":req.body.user,
        "pass":req.body.pass
    }

    userData.push(pdata);
    console.log("Final Result", pdata);

    res.statusCode(200).send({
        "Status_code":200,
        "Messafe":  "Usuario data fue agregado correctamente",
        "usuario": pdata
    })

})