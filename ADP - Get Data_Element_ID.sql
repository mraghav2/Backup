select Data_Element.ID,	Data_Element.Value, Data_Element.Description
 	from Data_Element where Value in ('03Y7370',
'03Y9723',
'09X9905',
'03Y7916',
'03Y8312',
'03Y7716',
'03Y8143',
'03Y8197',
'03Y8945',
'03Y8946',
'03Y8983',
'03Y9105',
'03Y9106',
'03Y9188',
'03Y9276',
'03Y9366',
'03Y9367',
'04Y0077',
'09X7115',
'03Y8169',
'04X3124')
--and Description in ('CE DNIS')
order by Data_Element.ID

--select * from Data_Element_Type where ID = 21
--select * from Route
--select * from Data_Route_Map_Member where 
--select * from Data_Element.ID

--select * from Data_Element_Group_Map where DataElementGroupID = 12749


--select * from Data_Element_Group_Map where ID > 37205
--insert into Data_Element_Group_Map values (1274,26583)
--insert into Data_Element_Group_Map values (1274,26584)
--insert into Data_Element_Group_Map values (1274,26585)
