Use uhg_routing
Declare @FromVer as varchar(8)
Declare @ToVer as varchar(8)
Set @FromVer = 'MEMS45'
Set @ToVer = 'MEMS55'
select * from Data_Element where Value like left(@FromVer,4)+'%' order by Value
select * from Route where Name like left(@FromVer,4)+'%' order by Name
select * from Data_Element where Value like left(@FromVer,6)+'%' order by Value --and Value not like '%00'
select * from Route where Name like left(@FromVer,6)+'%' order by Name --and Name not like '%00'
select * from Data_Element where Value like left(@ToVer,6)+'%' order by Value --and Value not like '%00'
select * from Route where Name like left(@ToVer,6)+'%' order by Name --and Name not like '%00'
--REMOVE TO PERFORM UPDATE
update Data_Element set Value = left(@ToVer,6)+substring(Value,7,2) where left(Value,6) = left(@FromVer,6) --and Value not like '%00'
update Route set Name = left(@ToVer,6)+substring(Name,7,2) where left(Name,6) = left(@FromVer,6) --and Name not like '%00'


--select 'insert into Route (Name,Description,VariableMapAddressID) values ("'+left(@ToVer,6)+substring(Name,7,2)+'","'+Description+'",42)' from Route where left(Name,6) = left(@FromVer,6)

--select 'insert into Data_Element (Value,VariableMapID,DataElementTypeID,Description) values ("'+left(@ToVer,6)+substring(Value,7,2)+'",2,48,"'+Description+'")' from Data_Element where left(Value,6) = left(@FromVer,6)

