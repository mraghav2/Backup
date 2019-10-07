select Master_Script.EnterpriseName, Script.Version, Master_Script.CurrentVersion, 
Script_Cross_Reference.LocalID, Script_Cross_Reference.TargetType, Script_Cross_Reference.ForeignKey, 
Peripheral.PeripheralName, Service.PeripheralNumber 
,case (Peripheral.PeripheralName)
when 'PLY_PG19' then 'Node1'
when 'CTC_PG35' then 'Node2'
when 'PLY_PG25' then 'Node3'
when 'CTC_PG34' then 'Node4'
when 'EGN_PG29' then 'Node5'
when 'PLY_PG28' then 'Node6'
when 'EGN_PG30' then 'Node7'
when 'ELR_PG38' then 'Node8'
when 'PLY_PG9' then 'Node9'
when 'EGN_PG10' then 'Node10'
when 'CTC_PG41' then 'Node11'
when 'CTC_PG44' then 'Node14'
when 'CTC_PG45' then 'Node15'
when 'ELR_PG46' then 'Node16'
when 'CTC_PG47' then 'Node17'
when 'CTC_PG48' then 'Node18'
when 'CTC_PG49' then 'Node19'
when 'ELR_PG50' then 'Node20'
end  AS Node
from Script_Cross_Reference, Master_Script, Script, Service, Peripheral

where Service.PeripheralNumber in (19935353262)  -- add VDN number here seperated by comma
and Peripheral.PeripheralID = Service.PeripheralID
and Service.SkillTargetID = Script_Cross_Reference.ForeignKey
and ScriptType = 1
and Master_Script.CurrentVersion = Script.Version
and Script_Cross_Reference.ScriptID = Script.ScriptID
and Script.MasterScriptID = Master_Script.MasterScriptID

order by Master_Script.EnterpriseName, Script.Version



