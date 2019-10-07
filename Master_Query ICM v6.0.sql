-- Servers:
--	1) ICM Instance 1: apsep01797 (A side), apsep01800 (B side) - 365 days history, dbase: uhg_awdb
--	2) ICM Instance 2: apsep01798 (A side), apsep01801 (B side) - 365 days history, dbase: uhga1_awdb
--	3) ICM Instance 3: apsep01799 (A side), apsep01802 (B side) - 365 days history, dbase: uhga2_awdb
-- Global group to access: ICM_HDS_Reporting

Declare @start as smalldatetime, @end as smalldatetime, @end1 as smalldatetime

Set @start = '08/27/2019 00:00:00'
Set @end   = '08/27/2019 22:00:00'
Set @end1  = '07/9/2019 23:40:00' -- always set this atleast 20 mins greater than the time in the line above this

Select
	CONVERT(VARCHAR(10), DATEADD(hh, 1, R1.DateTime), 101) AS 'Date',
	CONVERT(VARCHAR(8), DATEADD(hh, 1, R1.DateTime), 114) AS 'CentralTime',
	'="' + left(R1.Variable1,20) + '"' 'UCID',
	left(R1.ANI,10) 'ANI',
	R1.DialedNumberString 'CustomerDialedTFN',
	left(R1.Variable7,10) 'OriginalDialedTFN',
	Case When T1.[DigitsDialed]=R1.DialedNumberString Then 'N/A' Else T1.DigitsDialed End 'RepEnteredDigits',
	case R1.RoutingClientID when 5079 then '5079:Prod-UVP' when 5080 then '5080:Prod-UVP' when 5081 then '5081:PreProd-UVP'
		when 5082 then '5082:PreProd-UVP' when 5091 then '5091:SysTest-UVP' when 5092 then '5092:Dev-UVP' when 5101 then '5101:EGN-CVP-Prod1' when 5109 then '5109:EGN-CVP-Prod1'
		when 5110 then '5110:EGN-CVP-Prod1' when 5102 then '5102:EGN-CVP-DevQA' when 5118 then '5118:EGN-CVP-DevQA' when 5103 then '5103:EGN-CVP-Prod2' when 5104 then '5104:EGN-CVP-Prod2'
		when 5107 then '5107:EGN-CVP-Prod3' when 5108 then '5108:EGN-CVP-Prod3' when 5105 then '5105:TRU-CVP-Prod3' when 5106 then '5106:TRU-CVP-Prod3'
		else Cast(R1.RoutingClientID as nvarchar(4)) + ':' + RC.EnterpriseName end 'Env-RoutingClientID', 
	left(R1.Label,20) 'BackDoorTFN',
	left(R1.TargetLabel,20) 'VDNOrTFN',
	Case R1.TargetType When 0 Then '0:None (Bad)' When 1 Then '1:Default Route' When 2 Then '2:Route Agent' When 3 Then '3:Route Service (VDN)' When 4 Then '4:Route SkillGroup (VDN)' When 5 Then '5:End Announcement' When 6 Then '6:End Busy' When 7 Then '7:End Ring' When 8 Then '8:End Label' When 9 Then '9:NetworkDefault' When 10 Then '10:Route Service Array' When 11 Then '11:End Mult Label (Bad)' When 12 Then '12:Scheduled Target Node' When 13 Then '13:Done' When 14 Then '14:Aborted Call' When 15 Then '15:Release Call' When 16 Then '16:Queue Exceed' When 17 Then '17:Agent to Agent' When 18 Then '18:Dynamic Label' When 19 Then '19:Dynamic Divert' When 20 Then '20:Queued Dialog Failure' When 21 Then '21:Agent-Group' Else Cast(R1.TargetType as varchar(2)) End 'Target Type',
	substring(R1.Variable7,11,2) 'CT',
	substring(R1.Variable7,13,2) 'PT',
	substring(R1.Variable7,15,2) 'QT',
	left(R1.Variable4,10) 'RoutingID',
	substring(R1.Variable9,38,3) 'BIE',
	substring(R1.Variable4,11,3) 'ProgramCode',
	left(R1.Variable2,9) 'TIN',
	substring(R1.Variable6,11,3) 'TPSM',
	substring(R1.Variable7,17,16) 'MemID',
	substring(R1.Variable3,18,8) 'DOB',
	substring(R1.Variable3,3,7) 'Policy',
	substring(R1.Variable3,2,1) 'Platform',
	case T1.PeripheralID 
		when 5026 then 'UnifedApp' when 5038 then 'VETSS' when 5039 then 'VETSS' when 5040 then 'VETSS' when 5050 then 'LegacyGreenPBX'
		when 5041 then 'VETSS' when 5047 then 'UnifiedApp' when 5049 then 'VETSS' when 5051 then 'PhoenixPBX' when 5053 then 'Node01'
		when 5059 then 'Node02' when 5060 then 'UnifiedApp' when 5061 then 'UnifiedApp' when 5062 then 'Node03' when 5063 then 'UnifiedApp'
		when 5064 then 'UnifiedApp' when 5067 then 'CVP' when 5068 then 'CVP' when 5069 then 'Node04' when 5128 then 'Node04' when 5070 then 'UnifiedApp'
		when 5071 then 'UnifiedApp' when 5072 then 'UnifiedApp' when 5073 then 'GBayPBX' when 5074 then 'UVP' when 5075 then 'UVP'
		when 5076 then 'UVP' when 5127 then 'Node02' when 5077 then 'UVP' when 5079 then 'Node06' when 5080 then 'Node05' when 5083 then 'Node07'
		when 5084 then 'WestPBX32' when 5085 then 'WestPBX31' when 5086 then 'UVP' when 5087 then 'UVP' when 5089 then 'Node09'
		when 5091 then 'WestPBX33' when 5092 then 'Node10' when 5093 then 'CVP' when 5094 then 'CVP' when 5095 then 'CVP'
		when 5096 then 'CVP' when 5097 then 'CVP' when 5098 then 'CVP' when 5099 then 'CVP' when 5100 then 'CVP' when 5101 then 'CVP'
		when 5102 then 'CVP' when 5105 then 'Node11' when 5106 then 'AspectIVR' when 5107 then 'AspectIVR' when 5108 then 'AspectIVR'
		when 5109 then 'AspectIVR' when 5110 then 'CVP' when 5126 then 'Node8' when 5129 then 'Node11' when 5142 then 'Node14' when 5311 then 'Node15'
		when 5212 then 'Node16' when 5140 then 'Node17' when 5141 then 'Node18' when 5213 then 'Node19' when 5312 then 'Node20'
		else P.EnterpriseName end DestinationNode,
	T1.AgentPeripheralNumber AgentID,
	T1.InstrumentPortNumber AgentExtn,
	SG1.PeripheralNumber as 'SkillNumber From Skill_Group',
	Case T1.CallDisposition When 1 Then '1:ACD In' When 2 Then '2:Pre-Route ACD In' When 3 Then '3:Pre-Route Direct Agent' When 4 Then '4:Transfer In' When 5 Then '5:Overflow In' When 6 Then '6:Other In' When 7 Then '7:Auto out In Outbound' When 8 Then '8:Agent Out' When 9 Then '9:Out' When 10 Then '10:Agent Inside' When 11 Then '11:Offered' When 12 Then '12:Consult' When 13 Then '13:Consult Offered' When 14 Then '14:Consult Conference' When 15 Then '15:Conference' When 16 Then '16:Unmonitored' When 17 Then '17:Preview In' When 18 Then '18:Reserved In' When 19 Then '19:Supervisor Assist' When 20 Then '20:Emergency Call' When 21 Then '21:Supervisor Monitor' When 22 Then '22:Supervisor Whisper' When 23 Then '23:Supervisor Barge In' When 24 Then '24:Supervisor Intercept' When 38 Then '38:Non:ACD Call' When 39 Then '39:Play Agent Greeting' When 40 Then '40:Record Agent Greeting' Else Cast(T1.CallDisposition as varchar(2)) End 'CallDisp',
	T1.RingTime,
	T1.DelayTime,
	T1.TalkTime,
	T1.HoldTime,
	T1.WorkTime,
	T1.TimeToAband,
	T1.LocalQTime QueueTime,
	datediff(s,R1.BeganRoutingDateTime, R1.DateTime) TimeInIVR,
	left(R1.Variable4,10) 'RoutingID',
	substring(R1.Variable9,38,3) 'BIE',
	substring(R1.Variable4,11,3) 'ProgramCode',
	left(R1.Variable2,9) 'TIN',
	substring(R1.Variable6,11,3) 'TPSM',
	substring(R1.Variable7,17,16) 'MemID',
	substring(R1.Variable3,18,8) 'DOB',
	substring(R1.Variable3,3,7) 'Policy',
	substring(R1.Variable3,2,1) 'Platform',
	case substring(R1.Variable4,39,2)
		when '01' then '01: CES' when '02' then '02: COSMOS' when '03' then '03: PRIME' when '04' then '04: ELI'
		when '05' then '05: FACETS' when '06' then '06: MEMPHIS' when '07' then '07: DOCSNET'
		when '08' then '08: MAMSI LIVE'  when '09' then '09: DIAMOND' when '10' then '10: PERADIGM'
		when '11' then '11: ACN ELIGIBILITY DATABASE' when '12' then '12: SPECTRD.SPECTERA.COM' when '13' then '13: CFO'
		when '14' then '14: PULSE/Oxford' when '15' then '15: DEFINITY OLTP'  when '30' then '30: LEGACY METLIFE'
		when '31' then '31: LEGACY TRAVELERS' when '32' then '32: NICE' when '33' then '33: ILIAD'  when '34' then '34: RIMS'
		when '35' then '35: AMS/OTIS' when '41' then '41: PACIFICARE BEHAVIORAL HEALTH - FACETS'
		when '44' then '44: PROPRIETARY SYSTEMS' when '45' then '45: PDV' when '54' then '54: OPTUM GPS' when '55' then '55: CAMS'
		when '56' then '56: OPTUM HEALTH BANK' when '57' then '57: PRIME / PHS NICE' when '58' then '58: CLAIMS FACETS - UMR (SOURCE)'
		when '59' then '59: CPS/WAUSAU UMR DIV UM2' when '60' then '60: QICLINK/ONALASKA UMR DIV UM3'
		when '61' then '61: QICLINK/LEXINGTON UMR DIV UM4' when '62' then '62: KANSAS/KANSAS UMR DIV UM5'
		when '63' then '63: FACTS/SAN ANTONIO UMR DIV UM6' when '64' then '64: CLAIMFACTS/WESTERVILLE UMR DIV UM7'
		when '65' then '65: CPS FOR UHIS UMR DIV UM8' when '66' then '66: FACETS' when 'A8' then 'A8: FACETS' when 'A9' then 'A9: FACETS'
		else substring(R1.Variable4,39,2) END as 'EligSysValue',
	substring(R1.Variable6,29,2) 'CDBSrcCd',
	substring(R1.Variable9,26,5) 'FinalApp',
	substring(R1.Variable5,24,5) 'Contract',
	substring(R1.Variable3,35,2) 'PBP',
	substring(R1.Variable3,13,3) 'PlanType',
	substring(R1.Variable3,10,3) 'DivCode',
	substring(R1.Variable9,25,1) 'GovtInd',
	substring(R1.Variable3,27,4) 'SAOI', 
	substring(R1.Variable3,31,1) 'iPlan',
	substring(R1.Variable5,19,4) 'Subgroup (C&S)',
	substring(R1.Variable3,33,4) 'ClassID (C&S)',
	substring(R1.Variable5,1,8) 'PlanID (C&S)',
	substring(R1.Variable5,9,8) 'ProductID (C&S)',
	substring(R1.Variable8,30,3) 'TOPSProdCd',
	substring(R1.Variable5,19,5) 'PCID',
	Case Substring(R1.Variable5,30,2)
		When 'H4' Then 'H4 - Health4Me Mobile App' When 'MY' Then 'MY - MyUHC Web Portal' When 'MB' Then 'MB - MyUHC Mobile'
		When 'HD' Then 'HD - USC Help Desk' When 'AH' Then 'AH - Aon Hewitt ClicktoCall' When 'OD' Then 'OD - ODIN ClicktoCall'
		When 'OW' Then 'OW - Optum-Walgreens ClicktoCall' When 'TC' Then 'TC - Test ClicktoCall'
		Else substring(R1.Variable5,30,2) + ' - Unknown Code' End 'EasyConnect',
	substring(R1.Variable7,37,1) 'VIP',
	substring(R1.Variable7,38,2) 'ActiveCovCode',
	substring(R1.Variable3,33,8) 'PVRC',
	substring(R1.Variable9,23,2) 'SpecScenFlg',
	substring(R1.Variable5,34,2) 'RxIndicator',
	substring(R1.Variable7,35,1) 'Language',
	substring(R1.Variable7,40,1) 'SeniorInd',
	substring(R1.Variable3,26,1) 'XfrReason',
	substring(R1.Variable6,40,1) 'VCCDXfer',
	substring(R1.Variable2,22,8) 'DOS',
	substring (R1.Variable6,1,10) 'AcctMgrPhone',
	substring (R1.Variable5,19,10) 'AgencyID', 
	substring (R1.Variable5, 29,1) 'MktSeg',
	substring (R1.Variable5,30,2) 'DeptCode',
	substring(R1.Variable5,32,2) 'StateCode',
	substring (R1.Variable2,30,8) 'SubjectDOB',
	substring(R1.Variable2,38,1) 'Survey',
	R1.FinalObjectID 'ICMNode',
	MS.EnterpriseName as ScriptName, 
	SV.EnterpriseName as DestinationService,
	SG.EnterpriseName as DestinationSkill,
	left((select top 1 Skill_Group.EnterpriseName from Skill_Group,Route,Service,Service_Member 
		where Route.ServiceSkillTargetID = Service.SkillTargetID and Service.SkillTargetID = Service_Member.ServiceSkillTargetID 
		and Service_Member.SkillGroupSkillTargetID = Skill_Group.SkillTargetID and RouteID = R1.RouteID),32) as DestinationSkillBasedOnRoute,
	R.EnterpriseName as VDNName,
	L.Description as BackDoorTFNDescription,
	Case substring(R1.Variable10,5,1)
		When '1' Then '1 - E&I' When '2' Then '2 - Optum' When '3' Then '3 - C&S' When '4' Then '4 - Oxford'
		When '5' Then '5 - Kingston' When '6' Then '6 - M&R' when '7' Then '7 - CSO' Else substring(R1.Variable10,5,1) End 'BA',
	R1.CED 'CED',
	R1.CDPD 'CDPD',
	Left(R1.Variable1,20) 'UCID',
	R1.Variable1 'Variable1',
	R1.Variable2 'Variable2',
	R1.Variable3 'Variable3', 
	R1.Variable4 'Variable4', 
	R1.Variable5 'Variable5', 
	R1.Variable6 'Variable6', 
	R1.Variable7 'Variable7', 
	R1.Variable8 'Variable8', 
	R1.Variable9 'Variable9', 
	R1.Variable10 'Variable10',
	R1.RouterCallKey 'RCK',
	R1.RouterCallKeyDay 'RCKD',
T1.[RouterCallKeySequenceNumber],
T1.[ICRCallKey],
T1.[ICRCallKeyParent],
T1.[ICRCallKeyChild]

From 
	(select * from Route_Call_Detail where (1=1)


	--******* DATE / TIME SECTION *******--
	and DateTime >= @start
	and DateTime <= @end
	 --and convert(varchar,DateTime,108) < '12:00:00' --Exclude by specific time
	 --and substring(Variable10,2,3)='A1E'
	 --and ((DatePart(dw,DateTie) + @@DATEFIRST	) % 7) not in (0,1) -- Exclude Weekends
	 --and DatePart(hh,Route_Call_Detail.DateTime) >= 18 -- Calls after 6 pm MT, 7 pm CT
	 --and FinalObjectID = 7596


	 --******* ANI SECTION *******--
 	 --and (ANI like ('%7193396274%'))-- or ANI like ('%540777%'))-- Query by ANI, account for 1+, etc.
 	 --and (left(ANI,3) in ('540') or left(ANI,4) in ('1540')) -- Area Code and account for 1+
	 --and Right(ANI,10) in ('3612418879') -- Long List of ANIs
	 --and right(ANI,10) in ('3609409355','3603508408','8602500444')-- Fill In Your Test ANIs
	 
	 --******* Advocate4Me for E&I ********************--
	 --and ( (substring (Variable4,10,1) in ('N','L','F','Z','S','8','A') AND substring (Variable4,11,3) in ('NAV','PEP','SEI','XCH'))
	 --	  or
	 --	  substring (Variable4,1,2) in ('NV')
	 --	)-- A4Me

	 --******* Authenticated Policy / Plan Info *******--
	 --and ((DialedNumberString in ('8558287717'))) --and substring(Variable3,4,6)='000000') or (substring (Variable3,4,6) in ('304000'))) -- Pol or TFN
	 --and substring(Variable3,3,7) in ('13517  ') -- Policy, 7 chars, Unet will have leading 0.
	 --and SUBSTRING(Variable3,3,7) like 'IA%'
	 --and substring(Variable3,3,5) in ('10100')
	 --and substring(Variable3,3,1) in ('5','6')
	 --and substring (Variable3,18,8) = '1973368960' -- Query by DOB
	 --and substring(Variable5,24,5) in ('R7444','H5253','R3444','R5342','R6801','H0294','H2228','H0710','H6528','H1537','H0543')
	 --and substring(Variable3,2,1) in ('C') --Query by Platform, P=Prime, U=UNET, C=Cosmos, O=Oxford, N=NICE, I=Iliad, G=Golden Rule, F=Facets
	 --and substring(Variable3,31,1) in ('2','3','4','6','8','9') -- iPlan (CDH) Indicator
	 --and substring(Variable9,38,3) in ('OAL') -- Query by BIE
	 --and substring(Variable4,39,2) in ('AP') -- Elig Sys Value
	 --and substring(Variable6,29,2) in ('GL') -- CDB Source Code
	 --and substring(Variable3,10,3) in ('MSP','MTK') -- DIV code
	 --and substring (Variable3,27,4) in ('0302') -- SAOI
	 --and substring(Variable3,33,8) in ('00030003') -- PVRC (Plan Variation, Reporting Code)
	 --and substring(Variable5,19,5) in ('00000') -- PCID (Product Classifier ID)
	 --and substring(Variable8,30,3) in ('GIS','GIL','HML','HMS','HMP') --TOPS Product Code
	 --and (substring (Variable7,37,1) in ('V'))-- or substring (Variable7,38,2) in ('MS')) -- VIP indicator (either V in part 1 or MS in part 2)
	 --and substring(Variable5,32,2) = 'NY' -- State Code
	 --and substring(Variable6,11,1) in ('1','2','3','4') -- TPSM 1st Character (1-4 = PPSM)

	 --******* Broker/Employer Values *******--
	 --and substring (Variable5,30,2) = '04' -- Dept Code
	 --and substring (Variable5,39,1) in ('2','3') -- Query by GroupLed: 1=UHG only, 2=PHS only, 3=Dual, used for HLP1 routing.
	 --and substring (Variable5, 29,1) = 'S' -- Market Segment
	 --and substring (Variable6,1,10) in ('8776340267') -- AcctMgrPhone

	 --******* Calls routing to specific TFN or VDN *******--
	 --and left(TargetLabel,20) like '%8005444912%'
	 --and TargetLabel in ('31212')
	-- and right(TargetLabel,8) in ('3130606','3134614')

	 --******* Dialed Number/TFN SECTION *******--
	 --and DialedNumberString in ('8666332446') -- Query by TFN 8557326349 SPTFN-SIPEVP, 8003188134 SPTFN-TDMEVP, 8662804925 SPTFN-UVP, 8887022057 & 8776083515 ITI --and substring(Variable10,2,3) = 'A1E'
	 --and len(DialedNumberString)>=10 -- Dialed Number 10 digits or more, not a vdn.
	 --and Left(DialedNumberString,4) = '1999' -- 1999 is QA/DEV Test number
	 and left(Variable7,10) in ('8777697298') -- Original Dialed Number
	 --and LEFT(DialedNumberString,4) = '1999'

	 --******* IVR/ICM Routing Values *******--
	 --and substring (Variable7,11,2) in ('PE') -- Query by Caller Type
	 --and substring (Variable7,13,2) in ('NL') -- Query by Product Type
	 --and substring (Variable7,15,2) in ('CS') -- Query by Question Type
	 --and substring (Variable7,35,1) in ('S') -- Language Indicator, S=Spanish, M=Mandarin
	 --and left(Variable4,10) in ('OVTELSK991') -- Query by RoutingID
	 --and substring (Variable4,7,1) in ('V') -- Passport Indicator from RouteID, P=Tier2, V=Tier1/3, F=Full Service
	 --and substring (Variable4,8,1) in ('P') -- Route ID PM indicator
	 --and substring(Variable9,14,3) in ('MAP') -- Dispatch App Name (PFCPR=PHS Prv, PRV00=Core Prv, OXPS2=Oxford Prv, OXMS1=Oxford Mem, UIG=Broker, CAS=C&S, MAP=M&R, OVA=M&R)
	 --and substring(Variable9,26,3) in ('MAP') -- Final App Name (PFCPR=PHS Prv, PRV00=Core Prv, OXPS2=Oxford Prv, OXMS1=Oxford Mem, UIG=Broker, CAS=C&S, MAP=M&R, OVA=M&R)
	 --and substring(Variable9,23,2) in ('F2') -- Special Scenario Flag
	 --and Substring(Variable5,30,2) in ('H4') -- EasyConnect Codes
	 --and substring(Variable3,26,1) in ('A','B','C', 'D','E','F','G','H','I','J') -- Query by Transfer Reason
	 --and substring(Variable4,10,1) in ('N','L','Z','S','F','8','A') -- Advocate4Me
	 --and substring(Variable4,11,3) in ('SNI') -- Program Code (from CM)
	 --and substring(Variable3,26,1) in ('T') -- IVR Transfer Reason
	 --and substring(Variable6,40,1) = 'T' -- VCCD Transfer
	 --and substring(Variable2,38,1) = 'S'  -- Survey Selected
	 --and substring(Variable5,30,2) in ('H4','MY','MB','HD','AH','OD','OW','TC') -- EasyConnect
	 --and CED like '%0010000106%'
	 --and substring(Variable10,5,1) in ('7') -- BA Flag (1=E&I, 2=Optum, 3=C&S, 4=Oxford, 5=Kingston, 6=M&R)

	 --******* Member ID / Tax ID / EEID *******--
	 --and (substring(Variable7,17,16) like ('%937171375%'))-- or substring(Variable7,17,16) like ('%842589927%'))-- Query by MID
	 --and substring(Variable7,17,9) in ('008906215','004290405','000736258','003987823','003059498','004557103')
	 --and left(Variable2,9) in ('611716671') -- Tax ID Number (TIN)
	 --and left(Variable6,9) in ('000688463') -- EEID (from Internal Transfer IVR/EEID Auth)
	 --and substring(Variable5,19,10) in ('421418847') -- Oxford Provider ID, must have spaces up to 10 chars at end.

	 --******* Miscellaneous Code Checks *******--
	 --and RouterCallKey in ('374604')
	 --and RouterCallKeyDay in ('151207') --(150114 = 1/1/2012, 150115 = 1/2/2012, etc)
	 --and Left(Variable1,20) in ('00128637871566903441','00128493231566903821')
	 --and CED like '%10000097%'
	 --and substring(Variable10,1,1) = 'J' -- Natural Language=J
	 --and RoutingClientID in (5079,5080,5088) -- Query by RoutingClient

	 --******* Routes to Specific Skills (by label) *******--
	 --******* Node1=PLY_PG19, Node 2=CTC_PG35 Chaska, Node3=PLY_PG25, Node 4=CTC_PG34 *******--
	 --******* Node5=EGN_PG29, Node6=PLY_PG28, Node7=EGN_PG30, Node8=ELR_PG38, Node9=PLY_PG9 *******--
	 --******* Node10=EGN_PG10, Node 11=CTC_PG41, Node 14=CTC_PG44, Node15=CTC_PG45, Node 16=ELR_PG46 *******--
	 --******* Node 17=CTC_PG47, Node 18=ELR_PG48, Node 19=CTC_X49, Node 20=xxx_PG50 *******--
	/*
	 and ( (1=2)
		or RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like 'CTC_PG49%QS600%')) 
		--or RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like 'EGN_PG10%155%')) 
		--or RouteID in (select RouteID from Route where ServiceSkillTargetID in (select SkillTargetID from Service where EnterpriseName like 'CTC_PG49%%'))
		--or RouteID in (select RouteID from Route where SkillTargetID in (select SkillTargetID from Skill_Group where EnterpriseName like 'CTC_PG35%1349%%'))
		--or RouteID in (select RouteID from Route where SkillTargetID in (select SkillTargetID from Skill_Group where EnterpriseName like 'EGN_PG30%801%'))
		 )
	*/
	) as R1

	left outer join 
		(select * from Termination_Call_Detail where (1=1)
		and DateTime >= @start
		and DateTime <= @end1
		--and PeripheralID not in (5074,5075,5076,5077,5086,5087)
		--and CallTypeID not in (-1)
		and CallDisposition <> 7
		) as T1 
		on T1.RouterCallKey = R1.RouterCallKey and T1.RouterCallKeyDay = R1.RouterCallKeyDay
		
	Left outer Join Skill_Group SG1 On T1.SkillGroupSkillTargetID = SG1.SkillTargetID
	left outer join Route as R on R.RouteID = R1.RouteID
	left outer join Service as SV on SV.SkillTargetID = R.ServiceSkillTargetID
	left outer join Skill_Group as SG on SG.SkillTargetID = R.SkillTargetID
	left outer join Script as S on S.ScriptID = R1.ScriptID
	left outer join Master_Script as MS on MS.MasterScriptID = S.MasterScriptID
	left outer join Label as L on L.RoutingClientID = R1.RoutingClientID and L.Label = R1.Label
	left outer join Routing_Client as RC on RC.RoutingClientID = R1.RoutingClientID
	left outer join Peripheral as P on P.PeripheralID = T1.PeripheralID

Where (1=1)
	--and T1.DigitsDialed = '3138000'
	--and MS.MasterScriptID not in (10731,14602,14604,14623,14624,14629,14630,14644,14653,14656,14720) -- Exclude post UES survey route ICM2
	--and T1.TalkTime > 0 -- Uncomment this line to leave out abandoned calls
	--and T1.TimeToAband > 0 -- Uncomment this line to retrieve only abandoned calls
	--and T1.InstrumentPortNumber in ('3176860') -- Query by agent extn
	--and T1.PeripheralID in (5053) -- Query by VCC Node
	--and SG.PeripheralNumber = 1633
	--and T1.PeripheralID in (5053,5059,5062,5069,5079,5080,5083,5089,5105)
	--and T1.DigitsDialed like ('%8006248822%')
	--and T1.AgentPeripheralNumber = 40923
Order by R1.DateTime asc, R1.RouterCallKeyDay,R1.RouterCallKey,T1.RouterCallKeySequenceNumber