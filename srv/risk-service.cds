using {riskmanagement as rm} from '../db/schema';

@path: 'service/risk'
service RiskService {
    //adding authorization


    entity Risks @(restrict: [
        {
            grant: [
                'READ',
                'UPDATE',
                'DELETE',
                'WRITE'
            ],
            to   : 'RiskManager'
        },
        {
            grant: ['READ'],
            to   : 'RiskViewer'
        }
    ])                      as projection on rm.Risks;

    annotate Risks with @odata.draft.enabled;

    entity Mitigations @(restrict: [
        {
            grant: ['*'],
            to   : 'RiskManager'
        },
        {
            grant: ['READ'],
            to   : 'RiskViewer'
        }
    ])                      as projection on rm.Mitigations;

    annotate Mitigations with @odata.draft.enabled;

    @readonly
    entity BusinessPartners as projection on rm.BusinessPartners;
// annotate Mitigations with @odata.draft.enabled ;


}
