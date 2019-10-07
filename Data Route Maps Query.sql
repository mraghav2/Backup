select DRM.ID,Data_Element_Group.Name, Data_Element_Group.Description, DEG.Name as DEGName, DET_G.Name,Route.Name as RteName, DE2.Value, DE2.Description, DET_E.Name,Route.VariableMapAddressID as Type
       
from Data_Element_Group LEFT OUTER JOIN Data_Route_Map_Member as DRMM
                                 ON DRMM.DataElementGroupID = Data_Element_Group.ID
                           INNER JOIN Data_Route_Map as DRM
                                 ON DRMM.DataRouteMapID = DRM.ID
                           INNER JOIN Data_Route_Map_Member as DRMM2
                                 ON DRMM2.DataRouteMapID = DRM.ID
                           INNER JOIN Route
                                 ON DRM.RouteID = Route.ID
                           LEFT JOIN Data_Element as DE2
                                 ON DRMM2.DataElementID = DE2.ID
                                        LEFT JOIN Data_Element_Type as DET_E
                                               on DET_E.ID = DE2.DataElementTypeID
                           LEFT JOIN Data_Element_Group as DEG
                                 ON DRMM2.DataElementGroupID = DEG.ID
                                        LEFT JOIN Data_Element_Type as DET_G
                                               on DET_G.ID = DEG.DataElementTypeID

where  (1=1)

and Data_Element_Group.Name like '%UIG%'--'NHPSTFNGroup','NHPSTFN-EBRSvryGroup','NHPSDNIS-EBRSvryGroup')
--and Route.Name like ('%8444586738%')
--and DE2.Value in ('NA') 
--and Data_Element_Group.Name in ('38806XXN06')--CMD-00-TFNsMedicaCE','StagingTFNForCMD-00','CMD-MedicaCEAppGroup','CMDS-AppGroup')--MEMS-EVP_MemberAppGroup') MEM-CoreMemberAppGroup


Group By DRM.ID,Data_Element_Group.Name, Data_Element_Group.Description, DEG.Name, DET_G.Name,
       Route.Name, DE2.Value, DE2.Description,DET_E.Name, Route.VariableMapAddressID
       
order by DRM.ID,Route.Name,DE2.Value ASC
