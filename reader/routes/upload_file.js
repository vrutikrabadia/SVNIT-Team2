const fs = require('fs');
const uploadDisk = require("../middleware/multer");
const stockSchema = require("./../models/stocks.model");


const router = require("express").Router();



router.post("/", uploadDisk.single("file") , async(req,res)=>{
    let rawdata = fs.readFileSync(__dirname+"/../uploads/data.json");
    let data = JSON.parse(rawdata);

    // console.log(data.slice(0,10));

    data = await clean_data(data);

    console.log(data[0].prices[0]);

    stockSchema.insertMany(data)
        .then(function(mongooseDocuments) {
            res.sendStatus(200);
        })
        .catch(function(err) {
            res.sendStatus(500);
            console.log(err);
        });

    // res.send(data);

    fs.writeFileSync('./data.json', JSON.stringify(data) , 'utf-8'); 

    function clean_data(data) {
        
        let output = [];
        for(let i=0;i<Object.keys(data).length;i++) {
            let prices = {};
            prices['high'] = data[i].high;
            prices['low'] = data[i].low;
            prices['open'] = data[i].open;
            prices['close'] = data[i].close;
            prices['date'] = data[i].date;
            prices['volume'] = data[i].volume;
            let obj = {};
            obj['symbol'] = data[i].symbol;
            
            let id = already_exists_in_json(output, data[i].symbol);
            if( id==-1 ) {
                obj['name'] = 'Defaultname';
                //obj['name'] = get_name_from_symbol(symbol);
                //output.push({ obj['symbol'], obj['name'], [] });
                obj['prices']=[];
                output.push(obj);
                id = Object.keys(output).length-1;
            }
            
            output[id]['prices'].push(prices)
        }

        return output;
    }
    function already_exists_in_json(output, symbol){
        for(let i=0;i<Object.keys(output).length;i++){
            if(output[i]['symbol']==symbol)return i;
        }
        return -1;
    }
})

module.exports = router;