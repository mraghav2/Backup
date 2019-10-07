Select SR.*,Count(*) as Calls

From
(select 
--ANI,
--DialedNumberString, 
--substring(Variable7,11,2) as CallerType,
--substring(Variable7,13,2) as ProductType,
--substring(Variable7,15,2) as QuestionType,
--substring(Variable2,38,1) as Survey,
MS.EnterpriseName,Label.Description,
left(Route_Call_Detail.Label,4) as L1,
Left(TargetLabel,1) as TL1,
substring(Variable9,26,3) as App

from Route_Call_Detail
      left outer join Script as S on S.ScriptID = Route_Call_Detail.ScriptID
      left outer join Master_Script as MS on MS.MasterScriptID = S.MasterScriptID
      left outer join Label on Label.LabelID = Route_Call_Detail.LabelID
      
where (1=1)
and ((Route_Call_Detail.DateTime > '08/01/18 00:00:00'
and Route_Call_Detail.DateTime < '08/17/18 23:59:59')

)
--and MS.EnterpriseName in ('RRE_CVPRouting')
--and DialedNumberString in ('8666043267')
--and ANI in ()
and left(Route_Call_Detail.Label,1) in ('D')
and left(Route_Call_Detail.TargetLabel,1) not in ('D')
) as SR

Group By
SR.Description,
SR.TL1,
SR.L1,
SR.EnterpriseName,
SR.App

order by Calls Desc
