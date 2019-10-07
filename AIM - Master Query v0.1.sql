--AIM Stage to prod dbses1149
--AIM Stage to Stage dbses1150
--AIM Prod ELR Main: dbsep0924
--AIM Prod CTC Backup: dbsep0925

--******* This is for calls from Genesys to AIM ********-- select getdate()
USE [aceyus_aim]
GO
SELECT  [AIMGUID],[CallKey], 'UCID', [DialedNumberString],[DateTimeStart],[DateTimeEnd]
FROM [dbo].[AIM_REST_Detail]
Where cast(DateTimeStart as date) = '2019-08-27'
--d DialedNumberString='8663481286'
and [CallKey] = ('00128509671566907683') --('00128637871566903441')-- UCID
--and substring(Variable7,17,9)='393546555' -- MemIDS

--******* This is for calls from ICM to AIM (Contact Store)***********--
SELECT [AIMGUID],[CallKey] 'UCID', Variable1, Variable9, [DateTimeStart],[DateTimeEnd]
FROM [dbo].[AIM_CS_Detail]
Where DateTimeStart >= '06/27/2019 00:00:00' --and DialedNumberString='8663481286'
 and Variable9 like '%E01%'
--and left(Variable1,20) = '00057178071556094208' -- UCID
--and substring(Variable7,17,9)='393546555' -- MemID

----
--Use AIMGUID key from above to then enter in (dev only, doesn't work for prod):
SELECT TOP 1000 [AIMGUID]
      ,[Variable]
      ,[Value]
      ,[dbDateTime]
  FROM [aceyus_aim].[dbo].[AIM_REST_Variable_In]
  where AIMGUID = 'C279CE60-770A-4CE8-932F-FAEE7D227337'

  
  --(use for outputs for PROD only)
  Select * from AIM_REST_Detail
  where AIMGUID = '70C02F27-57C0-42E3-960E-00B6C7990F86'