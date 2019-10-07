select            Routing_Client.EnterpriseName As RoutingClient,
            Route_Call_Detail.DialedNumberString,
            Route_Call_Detail.RouterErrorCode,
            Count(Route_Call_Detail.DateTime) As Calls

from        Route_Call_Detail
                  INNER JOIN Routing_Client
                        ON Route_Call_Detail.RoutingClientID = Routing_Client.RoutingClientID

where       Route_Call_Detail.DateTime >= '04/12/16 06:00'
                  AND Route_Call_Detail.RouterErrorCode = 62 --unknown dn
--66 - no default route
--232 - label returned, but no such label configured
--274 - no free trans routes available for use (trans)
--63 - no call type for that specified dialed number
--448 - could be disconnect, abandon
--258, 69 - no peripheral targets for translation route , have a valid label for dialed number, from routing client

                  --AND Route_Call_Detail.RoutingClientID = 5021

group by    Routing_Client.EnterpriseName,
            Route_Call_Detail.DialedNumberString,
            Route_Call_Detail.RouterErrorCode

order by    Routing_Client.EnterpriseName,
            Route_Call_Detail.DialedNumberString,
            Route_Call_Detail.RouterErrorCode
