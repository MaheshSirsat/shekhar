using RiskService as service from '../../srv/risk-service';

annotate service.Risks with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Title',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Owner',
            Value : owner,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Descr',
            Value : descr,
        },
        {
            $Type : 'UI.DataField',
            Label : 'PrioCriticality',
            Value : PrioCriticality,
            Criticality : PrioCriticality,
        },
        {
            $Type : 'UI.DataField',
            Value : miti.descr,
            Label : 'Mitidescr',
        },
        {
            $Type : 'UI.DataField',
            Label : 'Impact',
            Value : impact,
            Criticality : criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : prio_code,
            Label : 'prio_code',
            Criticality : PrioCriticality,
        },
        {
            $Type : 'UI.DataField',
            Value : bp.BusinessPartner,
            Label : 'BusinessPartner',
        },
        {
            $Type : 'UI.DataField',
            Value : bp.FullName,
            Label : 'FullName',
        },
    ]
);
annotate service.Risks with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'title',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'owner',
                Value : owner,
            },
            {
                $Type : 'UI.DataField',
                Label : 'descr',
                Value : descr,
            },
            {
                $Type : 'UI.DataField',
                Label : 'impact',
                Value : impact,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PrioCriticality',
                Value : PrioCriticality,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Risk Section',
            ID : 'RiskSection',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Risks',
                    ID : 'Risks',
                    Target : '@UI.FieldGroup#Risks',
                },],
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Mitigation Section',
            ID : 'MitigationSection',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Mitigation',
                    ID : 'Mitigation',
                    Target : '@UI.FieldGroup#Mitigation',
                },],
        },]
);
annotate service.Risks with @(
    UI.FieldGroup #Risks : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },{
                $Type : 'UI.DataField',
                Value : createdBy,
            },{
                $Type : 'UI.DataField',
                Value : descr,
                Label : 'Descr',
            },{
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },{
                $Type : 'UI.DataField',
                Value : impact,
                Label : 'Impact',
                Criticality : criticality,
            },{
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },{
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },{
                $Type : 'UI.DataField',
                Value : title,
                Label : 'Title',
            },{
                $Type : 'UI.DataField',
                Value : PrioCriticality,
                Label : 'PrioCriticality',
                Criticality : PrioCriticality,
            },{
                $Type : 'UI.DataField',
                Value : owner,
                Label : 'Owner',
            },
            {
                $Type : 'UI.DataField',
                Value : prio_code,
                Label : 'prio_code',
                Criticality : PrioCriticality,
            },],
    }
);
annotate service.Risks with @(
    UI.HeaderInfo : {
        TypeName : 'Risk',
        TypeNamePlural : 'Risks',
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
    }
);
annotate service.Risks with @(
    UI.FieldGroup #Mitigation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : miti.timeline,
                Label : 'Timeline',
            },{
                $Type : 'UI.DataField',
                Value : miti.owner,
                Label : 'Owner',
            },
            {
                $Type : 'UI.DataField',
                Value : miti_ID,
                Label : 'Descripiotn',
            },],
    }
);
annotate service.Risks with {
    miti @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Mitigations',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : miti_ID,
                    ValueListProperty : 'ID',
                },
            ],
            Label : 'Mitigation',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Mitigations with {
    ID @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

annotate service.Risks with {
    miti @Common.Text : descr
};
