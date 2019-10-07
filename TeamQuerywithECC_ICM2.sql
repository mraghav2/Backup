Declare @start as smalldatetime
Declare @end as smalldatetime
Declare @end1 as smalldatetime
Set @start = '07/01/2019 00:00:00am'
Set @end   = '07/01/2019 23:59:30pm'
--Set @end1  = '06/29/2018 23:59:59pm' -- always set this atleast 20 mins greater than the time in the line above this
select left(R1.DateTime,20) DateAndMountainTime, left(R1.ANI,10) ANI, R1.DialedNumberString CustomerDialedTFN, 
(case R1.RoutingClientID when 5079 then 'Prod-UVP' when 5080 then 'Prod-UVP' when 5081 then 'PreProd-UVP'
when 5082 then 'PreProd-UVP' when 5091 then 'SysTest-UVP' when 5092 then 'Dev-UVP' when 5101 then 'EGN-CVP-Prod1' when 5109 then 'EGN-CVP-Prod1'
when 5110 then 'EGN-CVP-Prod1' when 5102 then 'EGN-CVP-DevQA' when 5118 then 'EGN-CVP-DevQA' when 5103 then 'EGN-CVP-Prod2' when 5104 then 'EGN-CVP-Prod2'
when 5107 then 'EGN-CVP-PreProd1' when 5108 then 'EGN-CVP-PreProd2' when 5105 then 'TRU-CVP-Prod3' when 5106 then 'TRU-CVP-Prod3'
else RC.EnterpriseName end) Environment,
MS.EnterpriseName as ScriptName,
R1.FinalObjectID, 
R1.CED,
left(R1.Label,20) BackDoorTFN, left(R1.TargetLabel,20) VDNOrTFN, substring(R1.Variable7,11,2) CT, substring(R1.Variable7,13,2) PT, 
substring(R1.Variable7,15,2) QT,left(R1.Variable4,10) RoutingID,substring(R1.Variable6,32,7) Screenpop,
SV.EnterpriseName as DestinationService,SG.EnterpriseName as DestinationSkill,
left((select top 1 Skill_Group.EnterpriseName from Skill_Group,Route,Service,Service_Member 
where Route.ServiceSkillTargetID = Service.SkillTargetID and Service.SkillTargetID = Service_Member.ServiceSkillTargetID 
and Service_Member.SkillGroupSkillTargetID = Skill_Group.SkillTargetID and RouteID = R1.RouteID),32) as DestinationSkillBasedOnRoute,
R.EnterpriseName as VDNName,
L.Description as BackDoorTFNDescription, 
(case T1.PeripheralID 
when 5026 then 'UnifedApp' when 5038 then 'VETSS' when 5039 then 'VETSS' when 5040 then 'VETSS' when 5050 then 'LegacyGreenPBX'
when 5041 then 'VETSS' when 5047 then 'UnifiedApp' when 5049 then 'VETSS' when 5051 then 'PhoenixPBX' when 5053 then 'Node1'
when 5059 then 'Node2' when 5060 then 'UnifiedApp' when 5061 then 'UnifiedApp' when 5062 then 'Node3' when 5063 then 'UnifiedApp'
when 5064 then 'UnifiedApp' when 5067 then 'CVP' when 5068 then 'CVP' when 5069 then 'Node4' when 5070 then 'UnifiedApp'
when 5071 then 'UnifiedApp' when 5072 then 'UnifiedApp' when 5073 then 'GBayPBX' when 5074 then 'UVP' when 5075 then 'UVP'
when 5076 then 'UVP' when 5077 then 'UVP' when 5079 then 'Node6' when 5080 then 'Node5' when 5083 then 'Node7'
when 5084 then 'WestPBX32' when 5085 then 'WestPBX31' when 5086 then 'UVP' when 5087 then 'UVP' when 5089 then 'Node9'
when 5091 then 'WestPBX33' when 5092 then 'Node10' when 5093 then 'CVP' when 5094 then 'CVP' when 5095 then 'CVP'
when 5096 then 'CVP' when 5097 then 'CVP' when 5098 then 'CVP' when 5099 then 'CVP' when 5100 then 'CVP' when 5101 then 'CVP'
when 5102 then 'CVP' when 5105 then 'Node11' when 5106 then 'AspectIVR' when 5107 then 'AspectIVR' when 5108 then 'AspectIVR'
when 5109 then 'AspectIVR' when 5110 then 'CVP'
else P.EnterpriseName end) DestinationNode,
left(R1.Variable2,9) TIN, substring(R1.Variable7,17,9) MID, substring(R1.Variable3,18,8) DOB, substring(R1.Variable3,2,8) Policy,
T1.AgentPeripheralNumber AgentID,
T1.InstrumentPortNumber AgentExtn, T1.TalkTime , T1.TimeToAband, T1.LocalQTime QueueTime,datediff(s,R1.BeganRoutingDateTime, R1.DateTime) TimeInIVR,
T1.CallDisposition, T1.PeripheralCallType,
substring(R1.Variable3,13,3) PlanType, substring(R1.Variable3,10,3) DivCode, substring(R1.Variable3,27,4) SAOI, 
substring(R1.Variable3,31,1) iPlan, 
substring(R1.Variable3,32,1) NHAPlan, substring(R1.Variable7,35,1) Language, 
substring(R1.Variable7,40,1) SeniorSupport,substring(R1.Variable9,25,1) GovtInd, substring(R1.Variable3,26,1) TransferReason,  
substring(R1.Variable2,22,8) DOS, substring (R1.Variable6,1,10) AcctMgrPhone, substring (R1.Variable5,19,10) AgencyID, 
substring (R1.Variable5, 29,1) MarketSegment, substring (R1.Variable5,30,2) DeptCode, substring(R1.Variable3,33,8) PVRC, 
substring(R1.Variable5,32,2) StateCode, substring (R1.Variable2,30,8) SubjectDOB, substring(R1.Variable2,38,1) UpFrontCallerSelection,

R1.Variable1, R1.Variable2, R1.Variable3, R1.Variable4, R1.Variable5, R1.Variable6, R1.Variable7, R1.Variable8, R1.Variable9, R1.Variable10, RC.EnterpriseName,R1.RoutingClientID,R1.RouterCallKeyDay, R1.RouterCallKey
--,ECV.EnterpriseName ECCVariableName, RCV.ArrayIndex ,RCV.ECCValue ECCVariableValue
from 
(select * from Route_Call_Detail where (1=1)
and DateTime >= @start
and DateTime <= @end
--and substring(Variable3,2,1) in ('C')
--and substring(Variable3,27,4) like '%03'
--and substring(Variable2,22,8) in ('20070607')
--and substring(Variable3,18,8) in ('19680829')
and ANI in ('914033549931')
--and ANI in ('2039599999','9525127900')
--and ANI in ('5162698093')
--and DialedNumberString in ('8009058671','8667720859','8003855588','8005555757','8005775623','8007768876','8776995710','8005475514','8664773966','8662808862','8888343721','8003941666','8776123991')
--and DialedNumberString in ('8883897739','8772599428','8884383679','8882233008','8663251179','8007979794','8668155332','8558426337','8007114555','8778496482')
-- ** All RX SIP NUMBERS MOVED LIVE ON 18/JUL/12  **
--and DialedNumberString in ('8778855476','8882391301','8007114550','8662407070','8882232759','8882232292','8888779908','8882421009','8882232531','8007887871','8778896481','8007979791','8778449740','8007884863','8009089097','8007114551','8882252610','8888779907')
-- ** All RX SIP NUMBERS MOVED LIVE ON 19/JUL/12 **
--and DialedNumberString in ('8887168787','8005626223','8778896510','8778896358','8888779905','8008660931','8883063243','8007979794','8883897739','8772599428','8884383679','8882233008','8663251179','8007979794','8668155332','8558426337','8007114555','8778496482')
--and DialedNumberString in ('8774400833') -- TO QUERY THE SINGLE PROVIDER TFN (8778423210)
--and DialedNumberString in ('8778444999')
--and ScriptName like 'rf%'
--and RouterCallKey = '105905'
--and Variable7 like '19991%'
--and R1.TargetLabel like ('%38315%')
--and substring(Variable7,1,10) = '8662628071'
and substring(Variable7,1,10) = '8663481286'
--and substring(Variable7,17,2) = '00'
--and substring(Variable7,1,10) = '8778423210'
--4615
--4696
--and ANI in ('8555750143 ','4027181344','4026192962')
--and ANI = '6325883472'
--and substring(Variable7,37,1) in ('V')
--and RouterCallKey in (52187)
--and ANI like '%9140396852'-- Query by ANI
--and substring(Variable9,14,5) in ('OCNS')  
--and substring(Variable9,26,5) in ('OCNS') 
--and Label
--and Label is not null
--and datepart(hh,DateTime) in (4,5)
--and left(ANI,3) in (select RegionPrefix from Region_Prefix where RegionID in (select RegionID from Region where EnterpriseName in ('Central')))
--and DialedNumberString in ('8773188134') -- Query by TFN
--and substring(Variable9,14,4) in ('OCNS') -- Query by App Name
--and substring(Variable3,31,1) in ('2','3','4','5','6','7','8','9') -- Query by iPlan Level
--and RoutingClientID in (5103,5104) -- Query by RoutingClient
--and substring( Variable4,17,3) in ('CLU')
--and substring(Variable3,26,1) in ('A','B','C', 'D','E','F','G','H','I','J') -- Query by Transfer Reason
--and left(Variable2,9) in ('926081075') -- Query by TIN
--and substring(Variable7,17,9) in ('971028836') -- Query by MID
--and substring (Variable9,38,3) in ('E01')
--and substring(Variable4,11,3) in ('SNI')
--and Variable4 = 'HADVXXXXXX          149439    19129'
--and ANI in('6037703916')
--and ( (1=2)
--or RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like 'PLY_PG19%QS%1454%'))
--or RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like 'PLY_PG19%QS%1457%'))
--or RouteID in (select RouteID from Route where SkillTargetID in (select SkillTargetID from Skill_Group where EnterpriseName like 'PLY_PG19%QS%1457%'))
--or RouteID in (select RouteID from Route where SkillTargetID in (select SkillTargetID from Skill_Group where EnterpriseName like 'PLY_PG19%QS%1454%'))
--)
--and TargetLabel in (9724618433) -- Query by TargetLabel
--and len(TargetLabel) < 10
--and TargetLabel in (select PeripheralNumber from Service where EnterpriseName like '%1036%')
--and TargetLabel in (select Label from Label where NetworkTargetID in (select NetworkTargetID from Peripheral_Target where RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like '%BUF%1407%'))))
--and substring (Variable3,18,8)in ('19660614') -- Query by DOB
--and substring (Variable7,17,9) like ('%056486373%') -- Query by UNET Policy
--and substring (Variable3,3,5) in ('70203') -- Query by Cosmos Policy
--and substring (Variable3,2,8) in ('P5R3497 ') -- Query by Prime Policy
--and substring (Variable7,11,2) in ('PV') -- Query by Caller Type
--and substring (Variable9,383) in ('PC1','PN1',PS1,PW1,P01,PX1,PC2,PT1,BIC') -- Query by Product Type
--and substring (Variable7,15,2) in ('CR','DC','DS') -- Query by Question Type
--and substring (Variable4,1,0) in ('0') -- Query by Routing ID
--and substring (Variable10,2,3) in ('001')
--and FinalObjectID in (26) -- Query by FinalObjectID
--and Variable1 like '0015278400002034%'
--Query by Script Name
/*and ScriptID in 
	(
		select ScriptID 
		from Script, Master_Script 
		where Master_Script.MasterScriptID = Script.MasterScriptID 
		and 
		(
			--EnterpriseName in ('CECNI_iPlan','UNI_MM_COSMOS_LOADBALANCE','CECNI_Medical','CECNI_KeyAcct','CECNI_MAHP_Routing','CECNI_Prime','CECNI_OnePay') 
			--or 
			EnterpriseName like 'UVP_DR_DBLookUp'
		)
	)*/
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
/*
left outer join (select * from Route_Call_Variable where (1=1)
and DateTime >= @start
and DateTime <= @end1
and ExpandedCallVariableID in (5001)
) as RCV on RCV.RCDRecoveryKey = R1.RecoveryKey
left outer join Expanded_Call_Variable as ECV on ECV.ExpandedCallVariableID = RCV.ExpandedCallVariableID
*/
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
--and T1.TimeToAband > 0 -- Uncomment this line to retrieve only abandoned calls
--and T1.InstrumentPortNumber in (60697) -- Query by agent extn
--and T1.PeripheralID in (5053) -- Query by VCC Node
--and T1.AgentPeripheralNumber in ('41688') 
--and T1.CallDisposition in (1)
--and R.EnterpriseName LIKE ('%EGN_PG30.UNI_MAM_SK_1884%') --to query on DestinationService
order by R1.DateTime desc, R1.RouterCallKeyDay,R1.RouterCallKey
