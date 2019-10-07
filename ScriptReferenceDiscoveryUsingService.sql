select Master_Script.EnterpriseName, Script.Version, Master_Script.CurrentVersion, Script_Cross_Reference.LocalID, Script_Cross_Reference.TargetType, Script_Cross_Reference.ForeignKey, Peripheral.PeripheralName, Service.PeripheralNumber 

from Script_Cross_Reference, Master_Script, Script, Service, Peripheral

where Service.PeripheralNumber in (32075)  -- add VDN number here. To add multiple entries separate them with a comma.
and Peripheral.PeripheralName='PLY_PG19'   -- add Peripheral Name. Refer the sheet sent by Jalisco.
and Peripheral.PeripheralID = Service.PeripheralID
and Service.SkillTargetID = Script_Cross_Reference.ForeignKey
and ScriptType = 1
and TargetType = 1
and Master_Script.CurrentVersion = Script.Version
and Script_Cross_Reference.ScriptID = Script.ScriptID
and Script.MasterScriptID = Master_Script.MasterScriptID

order by Master_Script.EnterpriseName, Script.Version