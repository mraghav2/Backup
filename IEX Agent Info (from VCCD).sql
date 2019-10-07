--Server: vccdreportingdb.ms.ds.uhc.com

USE [VCC_Desktop_Reporting]
GO

SELECT [ID]
      ,[date]
      ,[tv_id]
      ,[agent_name]
      ,[acd_id1]
      ,[logon_id1]
      ,[acd_id2]
      ,[logon_id2]
      ,[mu_id]
      ,[supervisor]
      ,[business_manager]
      ,[location]
      ,[site]
      ,[job_title]
      ,[telecommuter]
      ,[date_of_hire]
      ,[employee_id]
      ,[adjuster_id]
      ,[ORS_OPID]
      ,[ORS1]
      ,[ORS2]
      ,[macro_group]
      ,[primary_CT]
      ,[sen_date]
  FROM [dbo].[I_AGENTINFO]
  where agent_name like '%jacinda%' 
  --where business_manager like '%cobian%'
 --where logon_id1 = ('1993941013')
GO


