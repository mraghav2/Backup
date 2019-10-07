use uhga2_hds
select * From Route_Call_Detail (NOLOCK) Where DateTime between '7/20/16 00:01' and '7/25/16 23:59'
and DialedNumberString  like ('36633')
and ScriptID not like '222502'
