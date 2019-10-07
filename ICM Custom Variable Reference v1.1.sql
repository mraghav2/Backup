SELECT
	Master_Script.EnterpriseName as Script,
	Master_Script.CurrentVersion,
	User_Variable.VariableName,
	Convert (Varchar(20),Script.DateTime,100) 'Edit Date',
	Script.Author 'Last Editor'
	--Script_Cross_Reference.TargetType
	--Script_Cross_Reference.ForeignKey

FROM
	((Master_Script INNER JOIN Script ON Master_Script.MasterScriptID = Script.MasterScriptID) 
    INNER JOIN Script_Cross_Reference ON Script.ScriptID = Script_Cross_Reference.ScriptID)
    LEFT JOIN User_Variable ON User_Variable.UserVariableID = Script_Cross_Reference.ForeignKey
         and Script_Cross_Reference.TargetType = 31 -- (type 31 = User_Variable, Type 32 = User_Formula, uncomment 32 line below if needed for formula)
    --LEFT JOIN User_Formula ON User_Formula.UserFormulaID = Script_Cross_Reference.ForeignKey   --(32
    --LEFT JOIN Peripheral ON Peripheral.PeripheralID = Script_Cross_Reference.ForeignKey         --14

WHERE
      User_Variable.VariableName like  '%853%' 
	  --User_Variable.Description like ('%154%')
      and Master_Script.EnterpriseName not like '%test%'
	  and Master_Script.EnterpriseName not like '%Test%'
      and Master_Script.CurrentVersion = Script.Version

ORDER BY
	User_Variable.VariableName,
	Master_Script.EnterpriseName,
	Script.Version DESC