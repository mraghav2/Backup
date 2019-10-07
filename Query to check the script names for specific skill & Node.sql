Declare @start as smalldatetime, @end as smalldatetime, @end1 as smalldatetime
Declare @TheNode as int, @TheSkill as int
Declare @Node01 int = 5053, @Node02 int = 5127, @Node03 int = 5062, @Node04 int = 5128
Declare @Node05 int = 5080, @Node06 int = 5079, @Node07 int = 5083, @Node08 int = 5126
Declare @Node09 int = 5089, @Node10 int = 5092, @Node11 int = 5129, @Node12 int = 5000
Declare @Node14 int = 5142, @Node15 int = 5311, @Node16 int = 5212, @Node17 int = 5140, @Node18 int = 5141

Set @start = GetDate() - 24 --'07/20/2016 6:00:00'
Set @end   = GetDate() - 1 -- '07/20/2016 22:59:59'
Set @end1  = GetDate() -- always set this atleast 20 mins greater than the time in the line above this

---------------------------------------------------
Set @TheNode = @Node07
Set @TheSkill = 1760
-------------------------------

select RouteScript.Script,--R1.DialedNumberString, 
      /*RouteScript.Vers, RouteScript.Curr, RouteScript.ScriptID, */RouteScript.RouteID, RouteScript.route, RouteScript.VDNnum,
            RouteScript.ServiceName, RouteScript.SkillSvc, RouteScript.SkillSvcNum, RouteScript.VDNnumRte, RouteScript.ServiceRte, 
            RouteScript.Skill,RouteScript.SkillNum,
            R1.RouteID, /*R1.FinalObjectID,*/ R1.ScriptID, T1.RouteID, 
Count(*) From 

(select  convert (char(30),Master_Script.EnterpriseName) as Script, convert (char(4), Script.Version) as Vers, Script.ScriptID,
      convert (char(4),Master_Script.CurrentVersion) as Curr,/*Script.MasterScriptID, Script_Cross_Reference.ScriptID, Script_Cross_Reference.LocalID,
      Skill_Group.SkillTargetID,Script_Cross_Reference.TargetType, Script_Cross_Reference.ForeignKey,Script_Cross_Reference.ForeignKey,*/ 
      Route.RouteID, Route.EnterpriseName as route,
      Service.PeripheralNumber as VDNnum, Service.EnterpriseName as ServiceName,
      SG.EnterpriseName as SkillSvc, SG.PeripheralNumber as SkillSvcNum,
      SvcRt.PeripheralNumber as VDNnumRte, SvcRt.EnterpriseName as ServiceRte,
      Skill_Group.EnterpriseName as Skill,Skill_Group.PeripheralNumber as SkillNum    /*, User_Variable.VariableName ,User_Formula.EnterpriseName, Peripheral.EnterpriseName, Script.DateTime */

FROM ((Master_Script INNER JOIN Script ON Master_Script.MasterScriptID = Script.MasterScriptID) 
     INNER JOIN Script_Cross_Reference ON Script.ScriptID = Script_Cross_Reference.ScriptID)
      INNER JOIN Route ON Route.RouteID = Script_Cross_Reference.ForeignKey and Script_Cross_Reference.TargetType = 17
         LEFT JOIN Service AS SvcRt ON SvcRt.SkillTargetID = Route.ServiceSkillTargetID
         LEFT JOIN Skill_Group ON Route.SkillTargetID = Skill_Group.SkillTargetID
         LEFT JOIN Service_Member ON Service_Member.ServiceSkillTargetID = Route.ServiceSkillTargetID
                  LEFT JOIN Skill_Group AS SG ON Service_Member.SkillGroupSkillTargetID = SG.SkillTargetID
                  LEFT JOIN Service ON Service.SkillTargetID = Service_Member.ServiceSkillTargetID       

-- PeripheralID Reference: 5053=1, 5127=2, 5062=3, 5128=4, 5080=5, 5079=6, 5083=7, 8126=8, 5089=9
--                         5092=10, 5129=11, 5000=12, 5142=14, 5311=15, 5212=16, 5140=17, 5141=18

where       ((SG.PeripheralID in (@TheNode) and SG.Priority = 0 and SG.PeripheralNumber in (@TheSkill)) or 
      (Skill_Group.PeripheralID in (@TheNode) and Skill_Group.Priority = 0 and Skill_Group.PeripheralNumber in (@TheSkill))
      or (Service.PeripheralID in (@TheNode) and Service.PeripheralNumber in (@TheSkill))
      or (SvcRt.PeripheralID in (@TheNode) and SvcRt.PeripheralNumber in (@TheSkill))
      --(Service.PeripheralID in (5053) and Service.PeripheralNumber in (35434))
      --or (Service.PeripheralID in (5053) and Service.EnterpriseName like ('%1230%'))
      --or (Service.PeripheralID in (5083) and Service.EnterpriseName like ('%1127%'))
      --or (Service.PeripheralID in (5105) and Service.EnterpriseName like ('%1360%'))
) 
      --or (Skill_Group.PeripheralID in (5059) and Skill_Group.Priority = 0 and Skill_Group.PeripheralNumber in (1207,1208,1209,1210,1211,1215,1219,1220,1224,1225,1226,1232,1237,1249,1264,1364,1366,1603,1617,1618,1619,1623,1625,1634,1652,1660))
      --or (Skill_Group.PeripheralID in (5083) and Skill_Group.Priority = 0 and Skill_Group.PeripheralNumber in (1200,1201,1206))
      --or (Skill_Group.PeripheralID in (5105) and Skill_Group.Priority = 0 and Skill_Group.PeripheralNumber in (214,123,156,186,270)))
and Master_Script.EnterpriseName not like  '%Test%' 
and Master_Script.EnterpriseName not like '%T_VETSS%' 
and Master_Script.EnterpriseName not like '%W_VETSS%'
and Master_Script.EnterpriseName not like 'Wendy%'
and Master_Script.EnterpriseName not like 'WBA_%'
and Master_Script.EnterpriseName not like 'BACKUP%'
and Master_Script.EnterpriseName not like 'MCI_%'
and Master_Script.EnterpriseName not like 'B_%'
and Master_Script.CurrentVersion = Script.Version
)

as RouteScript 
left outer join 



(select --DialedNumberString,
RouteID,FinalObjectID, ScriptID, RouterCallKeyDay, RouterCallKey  from Route_Call_Detail where (1=1)
and DateTime >= @start
and DateTime <= @end
) as R1
on R1.RouteID = RouteScript.RouteID and RouteScript.ScriptID = R1.ScriptID

left outer join 
(select RouteID, RouterCallKeyDay, RouterCallKey from Termination_Call_Detail where (1=1)
and DateTime >= @start
and DateTime <= @end1
--and PeripheralID not in (5074,5075,5076,5077,5086,5087)
--and CallTypeID not in (-1)
) as T1 
on T1.RouterCallKey = R1.RouterCallKey and T1.RouterCallKeyDay = R1.RouterCallKeyDay and T1.RouteID = R1.RouteID

Group By RouteScript.Script, /*RouteScript.Vers, RouteScript.Curr,R1.DialedNumberString,*/
            RouteScript.ScriptID, RouteScript.RouteID, RouteScript.route, RouteScript.VDNnum,
            RouteScript.ServiceName, RouteScript.SkillSvc, RouteScript.SkillSvcNum, 
            RouteScript.VDNnumRte, RouteScript.ServiceRte, RouteScript.Skill,RouteScript.SkillNum,
            R1.RouteID, /*R1.FinalObjectID,*/ R1.ScriptID, T1.RouteID

order by RouteScript.Script asc,Count(*) desc



