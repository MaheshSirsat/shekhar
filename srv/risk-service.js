const cds = require("@sap/cds")
module.exports = cds.service.impl(async function () {
    // this contain instance of service and contains someof entitites
    const { Risks,BusinessPartners } = this.entities
    //after have 3 modes read
    this.after("READ", Risks, (data) => {
        const risks = Array.isArray(data) ? data : [data]
        risks.forEach((risk) => {
            if (risk.impact >= 100000) {
                risk.criticality = 1
            } else {
                risk.criticality = 3
            }
            switch(risk.prio_code){
                case 'H':
                    risk.PrioCriticality=1;
                    break;
                case 'L':
                    risk.PrioCriticality=2;
                    break;
                case 'M':
                    risk.PrioCriticality=3;
                    break;
                default:
                    break;
            }
       
        })
        


    })
    // ..BusinessPartners
    const BPsrv = await cds.connect.to("API_BUSINESS_PARTNER");

this.on("READ", BusinessPartners, async (req) => {

req.query.where("LastName <> '' and FirstName <> '' ");

return await BPsrv.transaction(req).send({
query: req.query,
headers: {
apikey: "mNoXz9PclUGQvTEBj8hqemBxTjX3BmJQ",
},
});
});
this.on("READ", Risks, async (req, next) => {

    /*

     Check whether the request wants an "expand" of the business partner

     As this is not possible, the risk entity and the business partner entity are in different systems (SAP BTP and S/4 HANA Cloud), 

     if there is such an expand, remove it

   */

    if (!req.query.SELECT.columns) return next();



    const expandIndex = req.query.SELECT.columns.findIndex(

        ({ expand, ref }) => expand && ref[0] === "bp"

    );



    if (expandIndex < 0) return next();



    // Remove expand from query

    req.query.SELECT.columns.splice(expandIndex, 1);



    // Make sure bp_BusinessPartner (ID) will be returned

    if (!req.query.SELECT.columns.find((column) =>

        column.ref.find((ref) => ref == "bp_BusinessPartner")

    )

    ) {

        req.query.SELECT.columns.push({ ref: ["bp_BusinessPartner"] });

    }



    const risks = await next();



    const asArray = x => Array.isArray(x) ? x : [x];



    // Request all associated BusinessPartners

    const bpIDs = asArray(risks).map(risk => risk.bp_BusinessPartner);

    const busienssPartners = await BPsrv.transaction(req).send({

        query: SELECT.from(this.entities.BusinessPartners).where({ BusinessPartner: bpIDs }),

        headers: {

            apikey:"mNoXz9PclUGQvTEBj8hqemBxTjX3BmJQ",

        }

    });



    // Convert in a map for easier lookup

    const bpMap = {};

    for (const businessPartner of busienssPartners)

        bpMap[businessPartner.BusinessPartner] = businessPartner;



    // Add BusinessPartners to result

    for (const note of asArray(risks)) {

        note.bp = bpMap[note.bp_BusinessPartner];

    }



    return risks;

});
})