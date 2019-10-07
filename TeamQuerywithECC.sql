Declare @start as smalldatetime
Declare @end as smalldatetime
Declare @end1 as smalldatetime
Set @start = '08/03/2017 00:00:00am'
Set @end   = '08/03/2017 23:59:59pm'
Set @end1  = '08/03/2017 23:59:59pm'-- always set this atleast 20 mins greater than the time in the line above this
select left(R1.DateTime,20) DateAndMountainTime, left(R1.ANI,10) ANI, substring(R1.Variable9,26,5) CVP_App, substring(R1.Variable9,14,6) CVP_App2,
(case R1.RoutingClientID when 5079 then 'Prod-UVP' when 5080 then 'Prod-UVP' when 5081 then 'PreProd-UVP'
when 5082 then 'PreProd-UVP' when 5091 then 'SysTest-UVP' when 5092 then 'Dev-UVP' when 5101 then 'EGN-CVP-Prod1' when 5109 then 'EGN-CVP-Prod1'
when 5110 then 'EGN-CVP-Prod1' when 5102 then 'EGN-CVP-DevQA1' when 5118 then 'EGN-CVP-DevQA2' when 5103 then 'EGN-CVP-Prod2' when 5104 then 'EGN-CVP-Prod2'
when 5107 then 'EGN-CVP-PreProd1' when 5108 then 'EGN-CVP-PreProd2' when 5105 then 'TRU-CVP-Prod3' when 5106 then 'TRU-CVP-Prod3'
else RC.EnterpriseName end) Environment,
R1.DialedNumberString CustomerDialedTFN, ECV.EnterpriseName ECCVariableName, RCV.ECCValue ECCVariableValue,--R1.CED, 
left(R1.Label,20) BackDoorTFN, left(R1.TargetLabel,20) VDNOrTFN, substring(R1.Variable7,11,2) CT, substring(R1.Variable7,13,2) PT, 
substring(R1.Variable7,15,2) QT, substring(R1.Variable7,35,1) Language, substring(R1.Variable10,1,1) BizLine, substring(R1.Variable3,26,1) TransferReason, left(R1.Variable4,10) RoutingID,left(R1.Variable2,9) TIN,  
substring(R1.Variable7,17,9) MID, substring(R1.Variable3,18,8) DOB, substring(R1.Variable3,2,8) Policy, 
(case T1.PeripheralID 
when 5026 then 'UnifedApp' when 5038 then 'VETSS' when 5039 then 'VETSS' when 5040 then 'VETSS' when 5050 then 'LegacyGreenPBX'
when 5041 then 'VETSS' when 5047 then 'UnifiedApp' when 5049 then 'VETSS' when 5051 then 'PhoenixPBX' when 5053 then 'Node1'
when 5059 then 'Node2' when 5060 then 'UnifiedApp' when 5061 then 'UnifiedApp' when 5062 then 'Node3' when 5063 then 'UnifiedApp'
when 5064 then 'UnifiedApp' when 5067 then 'CVP' when 5068 then 'CVP' when 5069 then 'Node4' when 5070 then 'UnifiedApp'
when 5071 then 'UnifiedApp'  when 5072 then 'UnifiedApp' when 5073 then 'GBayPBX' when 5074 then 'UVP' when 5075 then 'UVP'
when 5076 then 'UVP' when 5077 then 'UVP' when 5079 then 'Node6' when 5080 then 'Node5' when 5083 then 'Node7'
when 5084 then 'WestPBX32' when 5085 then 'WestPBX31' when 5086 then 'UVP' when 5087 then 'UVP' when 5089 then 'Node9'
when 5091 then 'WestPBX33' when 5092 then 'Node10' when 5093 then 'CVP' when 5094 then 'CVP' when 5095 then 'CVP'
when 5096 then 'CVP' when 5097 then 'CVP' when 5098 then 'CVP' when 5099 then 'CVP' when 5100 then 'CVP' when 5101 then 'CVP'
when 5102 then 'CVP' when 5105 then 'Node11' when 5106 then 'AspectIVR' when 5107 then 'AspectIVR' when 5108 then 'AspectIVR'
when 5109 then 'AspectIVR' when 5110 then 'CVP'
else P.EnterpriseName end) DestinationNode,
T1.AgentPeripheralNumber AgentID,
T1.InstrumentPortNumber AgentExtn, T1.TalkTime , T1.TimeToAband, T1.LocalQTime QueueTime,datediff(s,R1.BeganRoutingDateTime, R1.DateTime) TimeInIVR,
T1.CallDisposition, T1.PeripheralCallType,
substring(R1.Variable3,13,3) PlanType, substring(R1.Variable3,10,3) DivCode, substring(R1.Variable3,27,4) SAOI, 
substring(R1.Variable3,31,1) iPlan, 
substring(R1.Variable3,32,1) NHAPlan,  
substring(R1.Variable7,40,1) SeniorSupport,substring(R1.Variable9,25,1) GovtInd, R1.FinalObjectID, 
substring(R1.Variable2,22,8) DOS, substring (R1.Variable5,1,10) AcctMgrPhone, substring (R1.Variable5,19,10) AgencyID, 
substring (R1.Variable5, 29,1) MarketSegment, substring (R1.Variable5,30,2) DeptCode, substring(R1.Variable3,33,8) PVRC, 
substring(R1.Variable5,32,2) StateCode, substring (R1.Variable2,30,8) SubjectDOB, substring(R1.Variable2,38,1) UpFrontCallerSelection,
MS.EnterpriseName as ScriptName, 
SV.EnterpriseName as DestinationService,
SG.EnterpriseName as DestinationSkill,
left((select top 1 Skill_Group.EnterpriseName from Skill_Group,Route,Service,Service_Member 
where Route.ServiceSkillTargetID = Service.SkillTargetID and Service.SkillTargetID = Service_Member.ServiceSkillTargetID 
and Service_Member.SkillGroupSkillTargetID = Skill_Group.SkillTargetID and RouteID = R1.RouteID),32) as DestinationSkillBasedOnRoute,
R.EnterpriseName as VDNName,
L.Description as BackDoorTFNDescription,
R1.Variable1, R1.Variable2, R1.Variable3, R1.Variable4, R1.Variable5, R1.Variable6, R1.Variable7, R1.Variable8, R1.Variable9, R1.Variable10, RC.EnterpriseName,R1.RoutingClientID,R1.RouterCallKeyDay, R1.RouterCallKey
--, RCV.ArrayIndex ,RCV.ECCValue ECCVariableValue
from 
(select * from Route_Call_Detail where (1=1)
and DateTime >= @start
and DateTime <= @end
--and substring(Variable8,1,7) in ('3035010','3035011','3035089','3035090','3035254','3035256','3035009','3035255','3035258','3035259','3035260','3035363','3035264','3035266','3035267','3035012','3035013','3035014','3035015','3035016','3035017','3035006','3035002','3035003','3035004')
--and substring(Variable3,2,1) in ('C')
--and substring(Variable3,27,4) like '%03'
--and substring(Variable2,22,8) in ('20070607')
--and substring(Variable3,18,8) in ('19680829')
--and ANI ='5089302736'
and substring(Variable7,1,10)in ('8007899880')
--and ANI in ('8456286128','3474356307','7187161253','7186583500','7326982343','9143584740','9142738511','7186012235','5186228305','7184139731','5169221153','8457532320','2123484688','8453540907','7186338262','8453623097','3177157111','5163283321')
--and substring(Variable7,1,10) = '30295'
--and TargetLabel in ('3030204','3030219','3030220','3030222','3030238','3030239','3030240','3030241')
--and substring(Variable3,26,1) = '4'
--and substring(Variable10,1,1) = '0'
--and substring(Variable10,5,1) = '4'
--and DialedNumberString in ('8007899880')
--and DialedNumberString in ('8002237486')
--and Label in ('8662625360','8882189476','8882193164','8882194210')
--and Label like '%2565972610%'
--and Label like '%8009761849%'
--and RouterCallKey = '105905'
--and ANI in ('4254781345', '5094707346', '9204995326', '5099930000', '4178944847', '8603053705')--, '4178944847', '3018348676', '3018348067')
--and ANI in ('5087407244')--,'9107546463')
--and Variable7 like '%14782%'
--and (substring(Variable9,26,4) != 'ICNC' and substring(Variable9,26,4) != 'RXSS')
--and RouterCallKey in (503626)
--and ANI like '813%'-- Query by ANI
--and (substring(Variable9,14,4) in ('OXPS') or substring(Variable9,26,4) in ('OXPS')) 
--and Label like '%24307'
--and Label is not null
--and datepart(hh,DateTime) in (4,5)
--and left(ANI,3) in (select RegionPrefix from Region_Prefix where RegionID in (select RegionID from Region where EnterpriseName in ('Central')))
--and DialedNumberString like ('1992055%') -- Query by TFN
--and substring(Variable9,14,3) in ('SAP') -- Query by App Name
--and substring(Variable3,31,1) in ('2','3','4','5','6','7','8','9') -- Query by iPlan Level
--and RoutingClientID in (5088) -- Query by RoutingClient
--and substring( Variable4,17,3) in ('CLU')
--and substring(Variable3,26,1) in ('A','B','C', 'D','E','F','G','H','I','J') -- Query by Transfer Reason
--and left(Variable2,9) in ('147258369') -- Query by TIN
--and substring(Variable7,17,9) in ('312483883') -- Query by MID
--and ( (1=2)
--or RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like 'TRU_PG11%QS573%'))
--or RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like 'PLY_PG25%QS573%'))
--or RouteID in (select RouteID from Route where SkillTargetID in (select SkillTargetID from Skill_Group where EnterpriseName like 'TRU_PG11%QS573%'))
--or RouteID in (select RouteID from Route where SkillTargetID in (select SkillTargetID from Skill_Group where EnterpriseName like 'PLY_PG25%QS%573%'))
--)
--and TargetLabel in ('39465') -- Query by TargetLabel
--and len(TargetLabel) < 10
--and TargetLabel in (select PeripheralNumber from Service where EnterpriseName like '%1036%')
--and TargetLabel in (select Label from Label where NetworkTargetID in (select NetworkTargetID from Peripheral_Target where RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like '%BUF%1407%'))))
--and substring (Variable3,18,8)in ('19660614') -- Query by DOB
--and substring (Variable10,2,3)in ('A1E','A2E','UIE')
--and substring (Variable3,4,6) in ('023111') -- Query by UNET Policy
--and substring (Variable3,3,5) in ('70203') -- Query by Cosmos Policy
--and substring (Variable3,2,8) in ('P5R3497 ') -- Query by Prime Policy
--and substring (Variable7,11,2) in ('NA') -- Query by Caller Type
--and substring (Variable7,13,2) != ('OP') -- Query by Product Type
--and substring (Variable7,15,2) in ('d.') -- Query by Question Type
--and substring (Variable4,1,0) in ('0') -- Query by Routing ID
--and substring (Variable10,2,3) in ('001')
--and FinalObjectID in (2171) -- Query by FinalObjectID
--Query by Script Name
--and Variable1 like '%00082557731439559105????????????????????%'
--and ScriptID in (select ScriptID from Script, Master_Script where Master_Script.MasterScriptID = Script.MasterScriptID and 
--(
--EnterpriseName in ('USC_Master_Routing_SIP') 
--or 
--EnterpriseName like '%zDJ_Test%'
--or EnterpriseName like 'Provider%'
--))
--and Variable3 is not null -- Query for Calls that were connected to an agent
) as R1


left outer join 
(select * from Termination_Call_Detail where (1=1)
and DateTime >= @start
and DateTime <= @end1
and PeripheralID not in (5074,5075,5076,5077,5086,5087)
and PeripheralID not in (5093,5094,5095,5096,5097,5098,5099,5100,5101,5102,5110) --Disregard CVP leg of the call
--and ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like 'TRU%AMC%')
and CallTypeID not in (-1)
) as T1 
on T1.RouterCallKey = R1.RouterCallKey and T1.RouterCallKeyDay = R1.RouterCallKeyDay

left outer join (select * from Route_Call_Variable where (1=1)
and DateTime >= @start
and DateTime <= @end1
and ExpandedCallVariableID in (5019)
) as RCV on RCV.RCDRecoveryKey = R1.RecoveryKey
left outer join Expanded_Call_Variable as ECV on ECV.ExpandedCallVariableID = RCV.ExpandedCallVariableID

left outer join Route as R on R.RouteID = R1.RouteID
left outer join Service as SV on SV.SkillTargetID = T1.ServiceSkillTargetID
left outer join Skill_Group as SG on SG.SkillTargetID = T1.SkillGroupSkillTargetID
left outer join Script as S on S.ScriptID = R1.ScriptID
left outer join Master_Script as MS on MS.MasterScriptID = S.MasterScriptID
left outer join Label as L on L.RoutingClientID = R1.RoutingClientID and L.Label = R1.Label
left outer join Routing_Client as RC on RC.RoutingClientID = R1.RoutingClientID
left outer join Peripheral as P on P.PeripheralID = T1.PeripheralID
where (1=1)
--and T1.TalkTime > 0 -- Uncomment this line to leave out abandoned calls
--and T1.TimeToAband > 0 -- Uncomment this line to retrieve only abandoned call
--and T1.InstrumentPortNumber in (53139) -- Query by agent extn
--and T1.PeripheralID in (5089) -- Query by VCC Node
--and T1.AgentPeripheralNumber in ('3041037')
--and T1.CallDisposition in (1)
--and R.EnterpriseName LIKE ('%EGN_PG29.OPT_33103_AVAIL%') --to query on DestinationService
order by R1.DateTime desc, R1.RouterCallKeyDay,R1.RouterCallKey
