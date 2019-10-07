select Data_Element.Value as PolTFN, Data_Element.Description, Data_Element_Group.Name, Route.Name as RoutingID --, Data_Element_Type.Name

from Data_Element LEFT OUTER JOIN Data_Element_Group_Map
   ON Data_Element_Group_Map.DataElementID = Data_Element.ID
      AND Data_Element.DataElementTypeID  in (4,14)
      AND Data_Element.VariableMapID  in (2)
    INNER JOIN Data_Element_Group
     ON Data_Element_Group.ID = Data_Element_Group_Map.DataElementGroupID
      AND Data_Element_Group.DataElementTypeID  in (4,14)
    INNER JOIN Data_Route_Map_Member 
     ON Data_Route_Map_Member.DataElementGroupID = Data_Element_Group.ID
    INNER JOIN Data_Route_Map
     ON Data_Route_Map_Member.DataRouteMapID = Data_Route_Map.ID
    INNER JOIN Route
     ON Data_Route_Map.RouteID = Route.ID
   INNER JOIN Variable_Map_Address
     ON Variable_Map_Address.ID = Route.VariableMapAddressID
    INNER JOIN Data_Element_Type
     ON Variable_Map_Address.DataElementTypeID = Data_Element_Type.ID
where Data_Element_Type.ID in (27,57) and Route.Name not in ('P1CP1XXXXX','P1EP1XXXXX')  and left(Data_Element_Group.Name,3) not in ('UBH') --and Data_Element_Group_Map.DataElementGroupID = 1522 --and Data_Element.Value in ('8006387287','0702030')
     --and left(Data_Element.Description,1)='"'
     --and ( Data_Element_Group.Name like ('%P') or  Data_Element_Group.Name like ('%T'))
     --and Data_Element_Group.ID in (760,761,762)

Group By Data_Element.Value, Data_Element.Description, Data_Element_Group.Name, Route.Name
order by Data_Element.Value ASC
