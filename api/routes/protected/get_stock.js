const Stock = require("./../../models/stock.model");

const router = require("express").Router();

router.get("/", (req,res)=>{
    res.send("welcome to nt");
})

router.post("/", async(req,res)=>{
    let {symbol, start_date, end_date, interval} = req.body;

    let stocks = await Stock.find({
        symbol: symbol,
    });
    let startDate = new Date(start_date);
    let endDate = new Date(end_date);
    let data = [];
    // //console.log(stocks[0].prices);
    let returnObj = {};
    for (let i = 0; i < stocks[0].prices.length; i++) {
      let date = new Date(stocks[0].prices[i].date);
      if (date >= startDate && date <= endDate) {
        data.push(stocks[0].prices[i]);
      }
    }
    if (stocks.length > 0){
        // //console.log(data);
        let data_points = await get_dates_from_interval(data, new Date(start_date), new Date(end_date), interval);
        res.status(200).json({  datapoints: data_points });
    }
     
    else{
        res.status(404).json({ status: "error", message: "No stocks found" });
    } 

    function get_dates_from_interval(data, start_date, end_date, interval) {
        // //console.log(start_date, end_date, interval);
        let output = [];
        let n = Object.keys(data).length;
        let id = 0;
        let cur_date = new Date(start_date);
        //console.log(cur_date);
        let next_date = new Date(cur_date);
        // //console.log((next_date.getDate())+ interval);
        next_date.setDate(parseInt(next_date.getDate()) + parseInt(interval));
        //console.log(next_date);
        const default_values = {'high':-99999,'low':99999,'open':-1,'close':-1};
        var cur_values = {'high':-99999,'low':99999,'open':-1,'close':-1};
        //console.log(cur_date,end_date);
    
        while(cur_date <= end_date && id<n){
            xdate = new Date(data[id]['date']);
            //console.log('in for');
            //console.log(xdate);
            if(xdate<next_date && xdate<=end_date){
                //console.log('less');
                //process current
                cur_values['high']=Math.max(cur_values['high'],data[id]['high']);
                cur_values['low']=Math.min(cur_values['low'],data[id]['low']);
                cur_values['close']=data[id]['close'];
                if(cur_values['open']==-1){
                    cur_values['open']=data[id]['open'];
                }
                cur_values['date']=data[id]['date'];
                
                //cur_date=data[id]['date'];
                id++;
            }
            else{
                //console.log('more');
                //console.log(cur_values)
                //console.log(output);
                if(cur_values['open']!=-1){
                    const clone = JSON.parse(JSON.stringify(cur_values));
                    output.push(clone);
                }
                //console.log(output);
                //cur_values = JSON.parse(JSON.stringify(default_values));
                //cur_values = Object.assign({},default_values);
                cur_values = {'high':-99999,'low':99999,'open':-1,'close':-1};
                ////console.log('new defaULt')
                ////console.log(default_values);
                cur_date = new Date(next_date);
                //console.log(typeof(cur_date));
                //var endDate=cur_date.setDate(cur_date + 1);
    
                next_date.setDate(parseInt(next_date.getDate()) + parseInt(interval));
                //console.log('next date');
                //console.log(next_date);
                //console.log('cur_date');
                //console.log(cur_date);
            }
        }
        //console.log(cur_values);
        if(cur_values['open']!=-1)
            output.push(cur_values);
        return output;
    }

})

module.exports = router;