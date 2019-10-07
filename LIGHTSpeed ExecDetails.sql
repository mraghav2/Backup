/**

DB Servers
----------
	Dev:    DBSWD0019
	Test:   DBSWT0040
	Stage:  DBSW8323CLS		(NON-PROD for TEST/QA)
	Prod :  DBSWP0074CLS	

**/

Use vcc_lightspeed;

SELECT
	*
	,DATEDIFF(MILLISECOND,StartTime,StopTime) [ExecutionTime (ms)]
	,SUBSTRING(Trace,1,43650) Trace1
	,SUBSTRING(Trace,43650,87300) Trace2
	,SUBSTRING(Trace,87301,130951) Trace3
	,SUBSTRING(Trace,130952,174602) Trace4
	,SUBSTRING(Trace,174603,218253) Trace5
FROM
	(
		SELECT
			DateTime,
			CASE WHEN CHARINDEX('ScriptStartTime',ScriptVariables)>0 THEN CONVERT(DateTime,SUBSTRING(ScriptVariables,CHARINDEX('ScriptStartTime=',ScriptVariables)+16,CHARINDEX(';',ScriptVariables,CHARINDEX('ScriptStartTime=',ScriptVariables))-CHARINDEX('ScriptStartTime=',ScriptVariables)-16)) ELSE NULL END StartTime,
			CASE WHEN CHARINDEX('ScriptStopTime',ScriptVariables)>0 THEN CONVERT(DateTime,SUBSTRING(ScriptVariables,CHARINDEX('ScriptStopTime=',ScriptVariables)+15,CHARINDEX(';',ScriptVariables,CHARINDEX('ScriptStopTime=',ScriptVariables))-CHARINDEX('ScriptStopTime=',ScriptVariables)-15)) ELSE NULL END StopTime,
			CASE WHEN B.Name LIKE '%IVR%' THEN 'IVR' ELSE CASE WHEN B.Name LIKE '%ICM%' OR B.Name IN ('CM_Master_MID','CM_Navigator_MID','ORS_CM_ANI') THEN 'ICM' ELSE CASE WHEN B.Name LIKE '%VCCD%' THEN 'VCCD' ELSE 'Unknown' END END END ScriptType,
			CASE WHEN Val1 LIKE '%PLMS%' THEN 'PLMS' ELSE CASE WHEN (B.Name LIKE '%CAS%' OR Val1 LIKE '%CAS%') THEN 'CAS' ELSE CASE WHEN B.Name LIKE '%EandI%' OR  B.Name LIKE '%MEMS%' OR B.Name IN ('CM_Master_MID','CM_Navigator_MID') OR Val1 IN ('CM_GET_ANI','CM_Navigator_MID') OR B.Name='CM_IVR_MID' THEN 'MEMS' ELSE CASE WHEN B.Name LIKE '%MAP%' AND A.InputData NOT LIKE '%AppName=OVA%' THEN 'MAPS' ELSE CASE WHEN B.Name LIKE '%OVA%' OR A.InputData LIKE '%AppName=OVA%' THEN 'OVAS' ELSE CASE WHEN Val1 LIKE '%FEA%' THEN 'OHCA FEA' ELSE CASE WHEN B.Name LIKE '%OHCA%' THEN 'OHCA' ELSE CASE WHEN B.Name LIKE '%OPTUM%' THEN RIGHT(Val1,8) ELSE CASE WHEN B.Name LIKE '%PRVS%' THEN 'PRVS' ELSE 'Unknown' END END END END END END END END END LOB,
			B.Name MasterScript,
			Val1 As [ScriptName (Val1)],
			Val2 AS [ANI (Val2)],
			Val3 AS [CED (Val3)],
			Val4 AS [SessionID (Val4)],
			CASE WHEN CHARINDEX('var1=',InputData)>0 THEN SUBSTRING(InputData,CHARINDEX('var1=',InputData)+5,20) ELSE Val4 END [UCID],
			RIGHT(CASE WHEN CHARINDEX('MID=',ScriptVariables)>0 THEN SUBSTRING(ScriptVariables,CHARINDEX('MID=',ScriptVariables)+4,CHARINDEX(';',ScriptVariables,CHARINDEX('MID=',ScriptVariables))-CHARINDEX('MID=',ScriptVariables)-4) ELSE CASE WHEN CHARINDEX('var7=',InputData)>0 THEN RTRIM(SUBSTRING(InputData,CHARINDEX('var7=',InputData)+21,16)) ELSE '' END END,9) AS MID,
			CASE WHEN CHARINDEX('DOB=',ScriptVariables)>0 THEN SUBSTRING(ScriptVariables,CHARINDEX('DOB=',ScriptVariables)+4,8) ELSE CASE WHEN CHARINDEX('var3=',InputData)>0 THEN RTRIM(SUBSTRING(InputData,CHARINDEX('var3=',InputData)+22,8)) ELSE '' END END AS DOB,
			RTRIM(CASE WHEN CHARINDEX('FName=',ScriptVariables)>0 THEN SUBSTRING(ScriptVariables,CHARINDEX('FName=',ScriptVariables)+6,CHARINDEX(';',ScriptVariables,CHARINDEX('FName=',ScriptVariables))-CHARINDEX('FName=',ScriptVariables)-6) ELSE CASE WHEN CHARINDEX('var10=',InputData)>0 THEN RTRIM(SUBSTRING(InputData,CHARINDEX('var10=',InputData)+11,16)) ELSE '' END END) AS FName,
			CASE WHEN CHARINDEX('Policy=',ScriptVariables)>0 THEN SUBSTRING(ScriptVariables,CHARINDEX('Policy=',ScriptVariables)+7,CHARINDEX(';',ScriptVariables,CHARINDEX('Policy=',ScriptVariables))-CHARINDEX('Policy=',ScriptVariables)-7) ELSE CASE WHEN CHARINDEX('var3=',InputData)>0 THEN RTRIM(SUBSTRING(InputData,CHARINDEX('var3=',InputData)+7,7)) ELSE '' END END AS Policy,
			CASE WHEN CHARINDEX('var5=',InputData)>0 THEN SUBSTRING(InputData,CHARINDEX('var5=',InputData)+36,2) ELSE '' END StateCode,
			CASE WHEN CHARINDEX('var7=',InputData)>0 THEN SUBSTRING(InputData,CHARINDEX('var7=',InputData)+39,1) ELSE '' END LanguageIndicator,
			CASE WHEN CHARINDEX('var4=',InputData)>0 THEN SUBSTRING(InputData,CHARINDEX('var4=',InputData)+20,1) ELSE '' END A4MeIndicator,
			CASE WHEN CHARINDEX('BIE=',InputData)>0 AND CHARINDEX('BIE=;',InputData)=0 THEN SUBSTRING(InputData,CHARINDEX('BIE=',InputData)+4,3) ELSE CASE WHEN CHARINDEX('var9=',InputData)>0 THEN SUBSTRING(InputData,CHARINDEX('var9=',InputData)+42,3) ELSE '' END END AS In_BIECode,
			CASE WHEN CHARINDEX('var4=',InputData)>0 THEN SUBSTRING(InputData,CHARINDEX('var4=',InputData)+15,3) ELSE '' END In_ProgramCode,
			CASE WHEN CHARINDEX('BIECode=',ScriptVariables)>0 THEN SUBSTRING(ScriptVariables,CHARINDEX('BIECode=',ScriptVariables)+8,CHARINDEX(';',ScriptVariables,CHARINDEX('BIECode=',ScriptVariables))-CHARINDEX('BIECode=',ScriptVariables)-8) ELSE '' END AS Out_BIECode,
			CASE WHEN CHARINDEX('ProgramName=',ScriptVariables)>0 THEN SUBSTRING(ScriptVariables,CHARINDEX('ProgramName=',ScriptVariables)+12,CHARINDEX(';',ScriptVariables,CHARINDEX('ProgramName=',ScriptVariables))-CHARINDEX('ProgramName=',ScriptVariables)-12) ELSE '' END AS Out_ProgramCode,
			CASE WHEN CHARINDEX('SendMockRsp=true',ScriptVariables)>0 THEN 'Mock Data' ELSE 'Script Data' END DataResponse,
			CASE WHEN Val1<>'CM_Master_ANI' AND CHARINDEX('/scxml/session/start',Trace)>0 THEN SUBSTRING(SUBSTRING(Trace,CHARINDEX('/scxml/session/start',Trace)-40,40),CHARINDEX('://',SUBSTRING(Trace,CHARINDEX('/scxml/session/start',Trace)-40,40))+3,40) ELSE '' END ORS_Server,
			CASE WHEN CHARINDEX('src=http://',Trace)>0 THEN SUBSTRING(Trace,CHARINDEX('src=http://',Trace)+11,9) ELSE '' END Tomcat_Server,
			REPLACE(CASE WHEN CHARINDEX('.scxml',Trace,CHARINDEX('src=http://',Trace))>0  THEN SUBSTRING(Trace,CHARINDEX('/',Trace,CHARINDEX('src=http://',Trace)+11),CHARINDEX('.scxml',Trace,CHARINDEX('src=http://',Trace))-CHARINDEX('/',Trace,CHARINDEX('src=http://',Trace)+11)+6) ELSE '' END,'srcgen','src-gen') ORS_Script,
			CASE WHEN Val1<>'CM_Master_ANI' AND CHARINDEX('_ORSession=',ScriptVariables)>0 THEN SUBSTRING(ScriptVariables,CHARINDEX('_ORSession=',ScriptVariables)+11,CHARINDEX(';',ScriptVariables,CHARINDEX('_ORSession=',ScriptVariables))-CHARINDEX('_ORSession=',ScriptVariables)-11) ELSE '' END ORS_SessionID,
			CASE WHEN Val1<>'CM_Master_ANI' AND CHARINDEX('URL { http://',Trace)>0 THEN RTRIM(SUBSTRING(Trace,CHARINDEX('Next Node = ',Trace,CHARINDEX('URL { http://',Trace)),30)) ELSE '' END ORS_SessionTime,
			CASE WHEN CHARINDEX('Executing {WAITFOR DELAY',Trace)>0 THEN RTRIM(SUBSTRING(Trace,CHARINDEX('Next Node = ',Trace,CHARINDEX('Executing {WAITFOR DELAY',Trace)),30)) ELSE '' END PauseTime,
			CASE WHEN CHARINDEX('request/request.process',Trace)>0 THEN RTRIM(SUBSTRING(Trace,CHARINDEX('Next Node = ',Trace,CHARINDEX('request/request.process',Trace)),30)) ELSE '' END ORS_ScriptTime,
			ProcessingTime [RunTime (ms)],
			CASE WHEN CHARINDEX('<MenuType>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<MenuType>',Label),CHARINDEX('</MenuType>',Label)-CHARINDEX('<MenuType>',Label)+11) ELSE '' END IVR_MenuType,
			CASE WHEN CHARINDEX('<WavName>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<WavName>',Label),CHARINDEX('</WavName>',Label)-CHARINDEX('<WavName>',Label)+10) ELSE '' END IVR_WavName,
			CASE WHEN CHARINDEX('<MenuType>',Label)>0 AND CHARINDEX('<QuestionType>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<QuestionType>',Label),CHARINDEX('</QuestionType>',Label)-CHARINDEX('<QuestionType>',Label)+15) ELSE '' END IVR_QT,
			CASE WHEN CHARINDEX('<MenuType>',Label)>0 AND CHARINDEX('<ProductType>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<ProductType>',Label),CHARINDEX('</ProductType>',Label)-CHARINDEX('<ProductType>',Label)+14) ELSE '' END IVR_PT,
			CASE WHEN CHARINDEX('<MenuType>',Label)>0 AND CHARINDEX('<XferWav>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<XferWav>',Label),CHARINDEX('</XferWav>',Label)-CHARINDEX('<XferWav>',Label)+10) ELSE '' END IVR_XferWav,
			CASE WHEN CHARINDEX('<DisplayScreenPop>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<DisplayScreenPop>',Label),CHARINDEX('</DisplayScreenPop>',Label)-CHARINDEX('<DisplayScreenPop>',Label)+19) ELSE '' END VCCD_DisplayScreenPop,
			CASE WHEN CHARINDEX('<PriorityCampaign>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<PriorityCampaign>',Label),CHARINDEX('</PriorityCampaign>',Label)-CHARINDEX('<PriorityCampaign>',Label)+19) ELSE '' END VCCD_PriorityCampaign,
			CASE WHEN CHARINDEX('<Campaign>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<Campaign>',Label),CHARINDEX('</Campaign>',Label)-CHARINDEX('<Campaign>',Label)+11) ELSE '' END VCCD_Campaigns,
			CASE WHEN CHARINDEX('<Alert>',Label)>0 THEN SUBSTRING(Label,CHARINDEX('<Alert>',Label),CHARINDEX('</Alert>',Label)-CHARINDEX('<Alert>',Label)+8) ELSE '' END VCCD_Alerts,
			CONVERT(XML,Label) XML_Label,
			CASE WHEN CHARINDEX('var7=',InputData)>0 THEN SUBSTRING(InputData,CHARINDEX('var7=',InputData)+5,10) ELSE '' END TFN,
			Trace,
			InputData,
			ScriptVariables,
			Label,
			JSON,
			FunctionType,
			KeyTypeID,
			[HostServer],
			[RequestSource],
			C.[Version] [ScriptVersion],
			C.LastModified,
			C.LastModifiedBy,
			D.Name [LS_ScriptType],
			D.[Description] [ScriptType Desc]
		FROM	
			[dbo].[Execution_Detail] A(NOLOCK)
			INNER JOIN [dbo].[Master_Script] B(NOLOCK) ON A.MasterScriptID=B.ID
			INNER JOIN [dbo].[Script] C(NOLOCK) ON A.ScriptID=C.ID
			INNER JOIN [dbo].[Script_Type] D(NOLOCK) ON C.ScriptTypeID=D.ID
		WHERE
			DateTime > DATEADD(HOUR,-5,GETDATE())
	) results
WHERE
	1=1
	--AND DateTime BETWEEN '02/13/2017 07:00 AM' AND '02/13/2017 07:00 PM'
	AND LS_ScriptType	IN ('Event Script')	    			-- Event Script, Timed Script, Sub-Script;  [dbo].[Script_Type].[Name]
	--AND DATEDIFF(MILLISECOND,StartTime,StopTime)>[RunTime (ms)]
	--AND [ScriptName (Val1)] = 'IVR_OPTUM_PH'
	--AND ScriptType  	IN ('IVR')              			-- IVR, ICM, VCCD, Unknown
	--AND DataResponse    = 'Mock Data'
	--AND LOB     	  	IN ('PRVS')     -- CAS, MEMS, MAPS, OVAS, OHCA, 'OHCA FEA', OPTUM_BH, OPTUM_FS, OPTUM_PH, Unknown
	--AND HostServer      = 'APSES1396'
	--AND MasterScript    = 'ORS_OHCA_IVR'
	--AND ORS_Script   	= '/IVR_OPTUM/src-gen/IPD_IVR__OPTUM.scxml'
	--AND ORS_Script LIKE '%IVR_EandI_Polaris_F3663%'
	--AND ORS_SessionID	<>'Start Failed'
	--AND StateCode   	= 'AZ'
	--AND Out_BIECode  	= 'RPT'
	--AND VCCD_Alerts  	LIKE '%HRA Incomplete%'
	--AND MID     	  	= '948939157'
	--AND DOB     	  	= '19571227'
	--AND FName    	  	= 'ROSA'
	--AND Policy   	  	= '0184777'
	--AND [ANI (Val2)]	= '2815360641'
	--AND [UCID]      	IN ('00056457861494947687')
	--AND ORS_SessionID NOT LIKE '%Failed%'
	--AND ORS_SessionID LIKE '%0E7MCVT13H6H17LL7RS0ITF70C0000OJ%'
	--AND ORS_Server<>''
	--AND InputData LIKE '%752408872%'
	--AND Label LIKE '%Repeat%'
	
	