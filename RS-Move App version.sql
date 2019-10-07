--Update all RS groups to new application version.  This query builds the queries to make the updates.

Select 'update Data_Route_Map set RouteID = ',NewAppVer.ID,' where RouteID = ',PrevAppVer.ID_Route,' and ID = ',PrevAppVer.ID
--Select * 
from(

(select Route.ID as ID_Route,Route.Name as Name_Route,(left(Name,4)+substring(Name,7,2)) as NameCheckPrev,DRM.*
from Route INNER JOIN Data_Route_Map as DRM ON DRM.RouteID = Route.ID
where  Route.Name like ('MEMS50%') 
--/*      ****use this section to single out DNIS groups for prod staging
and DRM.ID in 
       (select  DRMM.DataRouteMapID from Route INNER JOIN Data_Route_Map as DRM ON DRM.RouteID = Route.ID
          INNER JOIN Data_Route_Map_Member as DRMM ON DRMM.DataRouteMapID = DRM.ID
                           LEFT JOIN Data_Element as DE ON DRMM.DataElementID = DE.ID
                                 LEFT JOIN Data_Element_Type as DET ON DE.DataElementTypeID = DET.ID
                           LEFT JOIN Data_Element_Group as DEG ON DRMM.DataElementGroupID = DEG.ID
                                 LEFT JOIN Data_Element_Type as DETG ON DEG.DataElementTypeID = DETG.ID
       where  (1=1) --and DETG.ID = 34 -- 34 is DNIS and 4 is TFN - comment out this entire line to move everything
                           --and DEG.Name Like ('%DNIS%')
       ) 
--*/

) as PrevAppVer                  -- set old app version

inner join 

(select *,(left(Name,4)+substring(Name,7,2)) as NameCheckNew
from Route 
where  Route.Name like ('MEMS55%') ) as NewAppVer                  -- set new app version

on NewAppVer.NameCheckNew = PrevAppVer.NameCheckPrev)

