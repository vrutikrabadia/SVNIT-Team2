const fs = require('fs');
const uploadDisk = require("../middleware/multer");
const stockSchema = require("./../models/stocks.model");
const axios = require("axios");


const router = require("express").Router();



router.post("/", uploadDisk.single("file") , async(req,res)=>{
    let rawdata = fs.readFileSync(__dirname+"/../uploads/data.json");
    let data = JSON.parse(rawdata);

    // console.log(data.slice(0,10));

    data = await clean_data(data);

    console.log(data[0].prices[0]);

    // stockSchema.insertMany(data)
    //     .then(function(mongooseDocuments) {
    //         res.sendStatus(200);
    //     })
    //     .catch(function(err) {
    //         res.sendStatus(500);
    //         console.log(err);
    //     });

    // res.send(data);
    for(let i=0; i<data.length; i++) {
        console.log(i);
        let element = data[i];
        stockSchema.findOne({symbol: element.symbol }, (err,found)=>{
            if(err){
                console.log(err);
                return res.sendStatus(500);
                
            }
            if(found){
                stockSchema.updateMany({symbol: element.symbol}, {
                    $addToSet:{prices:{$each: element.prices}}
                },{
                    multi: true,
                  },
                  (err, done)=>{
                        if (err) 
                            return res.status(500)
                        else{
                            if(i == data.length-1){
                                res.sendStatus(200);
                            }
                        }
                            
                  })
            }
            else{
                let stock = new stockSchema(element);
                stock.save((err)=>{
                    if(err){
                        console.log(err);
                        return res.sendStatus(500);
                        
                    }
                    else{
                        if(i == data.length-1){
                            res.sendStatus(200);
                        }
                    }
                })
            }
        })
    } 

    fs.writeFileSync('./data.json', JSON.stringify(data) , 'utf-8'); 

    async function clean_data(data) {
        
        let output = [];
        for(let i=0;i<Object.keys(data).length;i++) {
            let prices = {};
            prices['high'] = data[i].high;
            prices['low'] = data[i].low;
            prices['open'] = data[i].open;
            prices['close'] = data[i].close;
            prices['date'] = new Date(data[i].date);
            prices['volume'] = data[i].volume;
            let obj = {};
            obj['symbol'] = data[i].symbol;
            
            let id = already_exists_in_json(output, data[i].symbol);
            if( id==-1 ) {
                obj['name'] = await makeGetRequest(obj.symbol);
                //obj['name'] = get_name_from_symbol(symbol);
                //output.push({ obj['symbol'], obj['name'], [] });
                obj['prices']=[];
                output.push(obj);
                id = Object.keys(output).length-1;
            }
            
            output[id]['prices'].push(prices)
        }
        for(let i=0;i<Object.keys(output).length;i++){
            output[i]['prices'].sort(GetSortOrder("date"))
        }
        return output;
    }
    function already_exists_in_json(output, symbol){
        for(let i=0;i<Object.keys(output).length;i++){
            if(output[i]['symbol']==symbol)return i;
        }
        return -1;
    }
    
    function GetSortOrder(prop) {    
        return function(a, b) {    
            if (new Date(a[prop]) > new Date(b[prop])) {    
                return 1;    
            } else if (new Date(a[prop]) < new Date(b[prop])) {    
                return -1;    
            }    
            return 0;    
        }    
    } 

    async function makeGetRequest(symbol) {
        console.log(symbol);
        // return new Promise(function (resolve, reject) {
            let API_KEY = process.env.IEX_KEY;
            
            let url = 'https://cloud.iexapis.com/stable/stock/'+symbol+'/company/tops?token='+API_KEY;
            console.log(url);
            await axios.get(url).then(
                (response) => {
                    var result = response.data;
                    return result.companyName;
                },
                    (error) => {
                    console.log(error);
                    return;
                }
            );
        // });
    }
})

module.exports = router;