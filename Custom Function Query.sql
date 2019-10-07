Select 
	RUF.EnterpriseName 'Custom Function Name',
	RUFE.RowOrder 'Line',
	RUFE.EquationString
From
	Ref_User_Formula RUF
	Left Join Ref_User_Formula_Equation RUFE on RUF.UserFormulaID = RUFE.UserFormulaID
Where
	(1=1)
	AND RUFE.EquationString like ('%8778444999%')