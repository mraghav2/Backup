--select * from Data_Element_Group where Data_Element_Group.Name like ('%To105%')
--select * from Data_Element_Group where Data_Element_Group.ID in ('1792','1794')
--select * from Data_Element where Data_Element.Description like ('%Edward Jones%')
--select * from Data_Element where Data_Element.ID in ('44924')
--select * from Data_Element where Data_Element.Value like ('PRVS01%')


select  Data_Element_Group_Map.ID, Data_Element_Group.ID, Data_Element_Group.Name, Data_Element.ID, Data_Element.Value, Data_Element.Description 
      from Data_Element_Group LEFT OUTER JOIN Data_Element_Group_Map 
            ON Data_Element_Group.ID = Data_Element_Group_Map.DataElementGroupID 
                  INNER JOIN Data_Element
                        ON Data_Element_Group_Map.DataElementID = Data_Element.ID 
                        --and Data_Element_Group.DataElementTypeID in (34)-- in (48)
                        --and Data_Element_Group.Name like ('%1097')
                        and substring (Data_Element_Group.Name,1,6) in ('ST0859')
                        --or substring (Data_Element_Group.Name,8,1) in ('6'))
                        --and (substring (Data_Element_Group.Name,11,1) in ('P') or substring (Data_Element_Group.Name,11,1) in ('T'))                    
                        --and Data_Element_Group.ID in ('1672')
                        --and Data_Element.Value like ('GLH%')
                        --and Data_Element_Group.Name in ('MEMS-00-DNISgroup')
                        --and substring(Data_Element.Value,6,1) != 'v'
                        --and Data_Element.Description like ('%ADP%')   
                        --and substring(Data_Element_Group.Name,9,1) != '8'
                        --and Data_Element.ID > 44745
                        --and Data_Element.ID = 44911
                              --and  Data_Element_Group.Name like ('%ADP%') --or  Data_Element_Group.Name like ('%T'))
                              --and Data_Element_Group.Name not like '%Group'
order by Data_Element.ID ASC,Data_Element_Group.Name, Data_Element.Value ASC, Data_Element_Group.ID ASC

