# router-mikrotik

Configuración del nuevo router

Objetivo:  Sustituir el router de movistar que está quedandose corto de conexiones por uno más potente.

Requisitos:

El router de movistar lleva integrada la ONT (el conversor de fibra a cobre) de manera que no es posible prescindir
completamente de el. Lo que si se puede hacer es dejarlo sin funcion, sin trabajo. Eso se consigue configurandolo en
modo bridge.

Motivación

Como cada vez tenemos más servidores, más nodos, más máquinas virtuales y más personas en la Colmena, habíamos empezado a notar que las conexiones a veces se cortaban o el router se bloqueaba completamente. De este problema sólo podíamos salir reseteando el router de movistar.

Configuración del viejo router movistar

Bridge Fibra-Cobre en router movistar.

Al configurar el router de este modo el router deja de consumir sus recursos. Ya no necesita hacer NAT (Network Address Translations) que es lo que más recursos consume. El NAT no sólo se ve limitado por la capacidad de cómputo (CPU) si
no también por memoria. Los routers comerciales suelen tener de fábrica muy poca memoria. Con este recurso tan limitad
o el router no es capaz de mantener grandes tablas de conversion de IPs privadas a IP públicas.

