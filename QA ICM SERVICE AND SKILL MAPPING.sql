SELECT 		t_Service.EnterpriseName as'VDN NAME', 
		t_Service.PeripheralNumber AS 'VDN',
		t_Route.EnterpriseName AS 'Route Name',
		t_Peripheral_Target.DNIS AS 'PT DNS (VDN)',
		t_Network_Trunk_Group.EnterpriseName AS 'TRUNK GROUP',
		t_Label.Label AS 'LABEL - VDN',
		t_Routing_Client.EnterpriseName AS 'PG NAME',
		t_Skill_Group.EnterpriseName AS 'MAPPED SKILL NAME', 
		t_Skill_Group.PeripheralNumber AS 'MAPPED SKILL'

FROM		t_Service

LEFT JOIN	t_Service_Member

ON		t_Service_Member.ServiceSkillTargetID  = t_Service.SkillTargetID

LEFT JOIN	t_Route

ON		t_Route.ServiceSkillTargetID  = t_Service.SkillTargetID

LEFT JOIN	t_Peripheral_Target

ON		t_Peripheral_Target.RouteID  = t_Route.RouteID

LEFT JOIN	t_Network_Trunk_Group

ON		t_Network_Trunk_Group.NetworkTrunkGroupID  = t_Peripheral_Target.NetworkTrunkGroupID

LEFT JOIN	t_Label

ON		t_Label.NetworkTargetID = t_Peripheral_Target.NetworkTargetID

LEFT JOIN	t_Routing_Client

ON		t_Routing_Client.RoutingClientID = t_Label.RoutingClientID


LEFT JOIN	t_Skill_Group

ON		t_Skill_Group.SkillTargetID = t_Service_Member.SkillGroupSkillTargetID

WHERE		t_Service.PeripheralID = '5053'   --Node 1--
--WHERE		t_Service.PeripheralID = '5127'   --Node 2--
--WHERE		t_Service.PeripheralID = '5062'   --Node 3--
--WHERE		t_Service.PeripheralID = '5128'   --Node 4--
--WHERE		t_Service.PeripheralID = '5080'   --Node 5--
--WHERE		t_Service.PeripheralID = '5079'   --Node 6--
--WHERE		t_Service.PeripheralID = '5083'   --Node 7--
--WHERE		t_Service.PeripheralID = '5126'   --Node 8--
--WHERE		t_Service.PeripheralID = '5089'   --Node 9--
--WHERE		t_Service.PeripheralID = '5092'   --Node 10--
--WHERE		t_Service.PeripheralID = '5129'   --Node 11--

AND		t_Service.PeripheralNumber IN ('30660',
'30661',
'30662',
'30663',
'30664',
'30665',
'30666',
'30667',
'30668',
'30669',
'30670',
'30671',
'30672',
'30673',
'30674',
'30675',
'30676',
'30677',
'30678',
'30679',
'30680')

ORDER BY	t_Service.PeripheralNumber