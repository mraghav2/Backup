--Variable script reference

select Master_Script.EnterpriseName as Script, Script.Version, Master_Script.CurrentVersion,User_Variable.VariableName,Script.DateTime
      --,Script_Cross_Reference.TargetType, Script_Cross_Reference.ForeignKey

FROM ((Master_Script INNER JOIN Script ON Master_Script.MasterScriptID = Script.MasterScriptID) 
       INNER JOIN Script_Cross_Reference ON Script.ScriptID = Script_Cross_Reference.ScriptID)
            LEFT JOIN User_Variable ON User_Variable.UserVariableID = Script_Cross_Reference.ForeignKey  --31
                  and Script_Cross_Reference.TargetType = 31

where       (1=1)
      and User_Variable.VariableName like ('%SK1281%')
      --and User_Variable.VariableName in ('userVCC_PLY_SK1039_OPEN','userVCC_PLY_SK1039_ENABLED')
      and Master_Script.CurrentVersion = Script.Version -- Can use to only look for active scripts

order by  Master_Script.EnterpriseName ASC, User_Variable.VariableName asc,Script.Version DESC

