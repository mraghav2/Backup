-- Preprod = dbset0995 (new) uhg_routing
-- Preprod = dbset0995 (new) uhg_routing
-- Old Preprod = dbses1367cls - uhg_routing
-- Prod = dbsep1884cls - uhg_routing
-- Dev = dbsed2344 - uhg_routing

select Data_Element.Value, Data_Element.Description, DEG.Name as DEGName, Route.Name as RteName
       
from Data_Element LEFT OUTER JOIN Data_Element_Group_Map as DEGM
                    ON DEGM.DataElementID = Data_Element.ID
               LEFT JOIN Data_Element_Group as DEG
                    ON DEGM.DataElementGroupID = DEG.ID
               LEFT JOIN Data_Route_Map_Member as DRMM
                    ON DRMM.DataElementGroupID = DEG.ID
                           INNER JOIN Data_Route_Map as DRM
                                 ON DRMM.DataRouteMapID = DRM.ID
                           INNER JOIN Route
                                 ON DRM.RouteID = Route.ID

where   DEG.DataElementTypeID in (4) and Route.VariableMapAddressID in (42)
       and Route.Name not in ('CONNECT','SAP01400','SAPXCv01','SAXC01','ICNICv01','ICNICv02','MEM10200')
       and left(Data_Element.Value,1) in ('8') --substring (Route.Name,1,6) in ('AB1020') --Data_Element.Value in ('EN') -- 
       and substring(Route.Name,1,4) in ('MEMS')--,'UIG','PRV','CCD','COB','PHP','CHP','CMD','PHS','MAP','OVA')
       and Data_Element.Value in (select Data_Element.Value from Data_Element where Value in (select Data_Element.Value
       from Data_Element_Group LEFT OUTER JOIN Data_Element_Group_Map 
             ON Data_Element_Group.ID = Data_Element_Group_Map.DataElementGroupID 
                    INNER JOIN Data_Element
                           ON Data_Element_Group_Map.DataElementID = Data_Element.ID 
                           and Data_Element_Group.DataElementTypeID in (4,14)-- in (48)
                           --and Data_Element_Group.Name in ('SMS-CallContainDNIS-Grp')
                           )
                           group by Data_Element.Value)

Group By Data_Element.Value,Route.Name,Data_Element.Description, DEG.Name,Data_Element.ID 
order by Data_Element.Value ASC,Route.Name
