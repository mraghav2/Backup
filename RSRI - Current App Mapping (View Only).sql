-- Preprod = dbset0995 (new) uhg_routing
-- Old Preprod = dbses1367cls - uhg_routing
-- Prod = dbsep1884cls - uhg_routing
-- Dev = dbsed2344 - uhg_routing

Use uhg_routing
select DataRouteMapID,
( select Name from Data_Element_Group where ID = DataElementGroupID) GroupName,
( select Value from Data_Element where ID = DataElementID) DataElement,
( select Name from Route where ID in (select RouteID from Data_Route_Map where ID = DataRouteMapID)) Route
from Data_Route_Map_Member 
where (1=1)
and DataRouteMapID in (select ID from Data_Route_Map where RouteID in (select ID from Route where Name like 'MEMS%') )
--and DataElementGroupID in (select ID from Data_Element_Group where Name like 'HP-MEM%')
--and DataElementID in (select ID from Data_Element where Value like '800123%')
order by DataRouteMapID,Route