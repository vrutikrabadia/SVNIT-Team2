const Stock = require("./../../models/stock.model");

const router = require("express").Router();

router.get("/", (req,res)=>{
    res.send("welcome to nt");
})

router.post("/get_data", async(req,res)=>{
    let {symbol, start_date, end_date, interval} = req.body;

    let stocks = await Stock.find({
        symbol: symbol,
    });
      let startDate = new Date(start_date);
      let endDate = new Date(end_date);
      let data = [];
      console.log(stocks[0].prices);
      let returnObj = {};
      for (let i = 0; i < stocks[0].prices.length; i++) {
        let date = new Date(stocks[0].prices[i].date);
        if (date >= startDate && date <= endDate) {
          data.push(stocks[0].prices[i]);
        }
      }
      if (stocks.length > 0)
        res.status(200).json({ status: "success", message: data });
      else res.status(404).json({ status: "error", message: "No stocks found" });
    // stockSchema.findOne({symbol: symbol}, (err, found)=>{
    //     if(err){
    //         res.sendStatus(500);
    //     }
    //     else{
            
    //     }
    // })

})

module.exports = router;