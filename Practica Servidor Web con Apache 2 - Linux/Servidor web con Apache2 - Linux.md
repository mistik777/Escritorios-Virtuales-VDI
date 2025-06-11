# Servidor web con Apache2 - Linux

<aside>
👉🏽

Esta práctica consiste en montar una página web en tu equipo y hacerla visible al resto de equipos de la red. Visualizar el resto de páginas web de tus compis.

</aside>

<aside>
📚

Para ello deberás de:

- [ ]  Configurar el Escritorio Virtual
- [ ]  Establecer IP FIJA en un adaptador de red
- [ ]  Actualizar equipo e instalar un servidor Web con Apache2
- [ ]  Subir tu página web
</aside>

# Configuración del Escritorio Virtual PROFE

En el apartado de Hardware > Redes > Añadimos una red privada (Persona1)

Nos apuntamos su dirección MAC (basta con fijarse en el último par de caracteres)

![image.png](image.png)

# Configuración del Escritorio Virtual ALUMN

En el apartado de Hardware > Redes > Añadimos una red privada (Persona1)

Nos apuntamos su dirección MAC (basta con fijarse en el último par de caracteres)

En el caso de añadir visores como RDP, veremos que se añaden nuevas redes, Wireguard VPN (no tocar)

![image.png](image%201.png)

En este caso tendremos que modificar la red Personal1 cuya MAC termina en e3

# Iniciamos Escritorio PROFE

Iniciamos sesión con el usuario y contraseña por defecto**: isard | pirineus**

![image.png](image%202.png)

Al iniciar, vemos la información de la máquina y vemos que sólo tiene dirección IP en una de las tarjetas de red, en este caso la enp1s0.

Si mostramos información de los adaptadores de red con el comando `ip a` veremos que la segunda tarjeta de red: Personal1 cuya MAC termina en 1f no tiene dirección IP asignada.

**enp1s0**  —> equivale a Default (NO TOCAR, si no dejamos al Escritorio sin acceso a Internet)

**epn2s0** —> equivale a Private1 (podemos fijar un IP)

![image.png](image%203.png)

## Establecer IP fija al adaptador de red “Personal1” equipo PROFE

Si no se tiene entorno gráfico. Para establecer una IP fija hay que hacerlo mediante **netplan**.

Accedemos a /etc/netplan.  `cd /etc/netplan`

Creamos fichero de configuración de los adaptadores de red: `sudo nano /etc/netplan/mi-red.yaml`

```bash
network:
	version: 2
	ethernets:
		enp1s0:
			dhcp4: true
		enp2s0:
			dhcp4: false
			addresses: [192.168.200.10/24]
```

*hay más configuraciones del fichero, pero para esta práctica es suficiente con esos valores.

Aplicamos los cambios a los adaptadores de red: `sudo netplan apply`

## Establecer IP fija al adaptador de red “Personal1” equipo ALUMN

Menú superior > Cableado > Configuración de red cableada

![image.png](image%204.png)

Configuramos el adaptador de red que corresponda. 

En este caso tendremos que modificar la red Personal1 cuya MAC termina en e3

![image.png](image%205.png)

![image.png](image%206.png)

### Personalizar la IP en la pestaña IPv4:

basta con añadir una dirección IP fija y máscara

(Recuerda: dentro del mismo rango que la hemos puesto en el equipo del profesor). 

En nuestro caso: [192.168.200.XXX](http://192.168.200.XXX) | 255.255.255.0

![image.png](image%207.png)

# Comprobar que ambos equipos son accesibles.

Para comprobar que ambos equipos (PROFE y ALUMN) están configurados correctamente en la misma red (Personal1), bastará con hacer un ping de uno a otro.

IP PROFE: **192.168.200.10**

IP ALUMN: **192.168.200.20**

En el equipo del profesor ejecutaremos: `ping 192.168.200.20`

En el equipo del alumno ejecutaremos: `ping 192.168.200.10`

Si están correctamente configurados, el ping será satisfactorio y mostrará algo similar a esto:

![image.png](image%208.png)

# Instalar Servidor Web con Apache2

Para montar un servidor web con Apache simplemente tendremos que instalar apache2 y subir los ficheros de la web en un directorio en concreto.

## Actualizar repositorios

En la máquina donde queramos montar la web ejecutamos:

Actualizar repositorios: `sudo apt-get update`

Actualizar aplicaciones: `sudo apt-get upgrade -y` 

## Instalar Apache2

Instalar apache2: `sudo apt-get install apache2 -y`

## Acceder a la web

Una vez instalado, si accedemos desde un navegador web de otro equipo a la dirección IP de dicho equipo, ya veremos su web. `http://<IP_EQUIPO>/index.html`

También podemos acceder a esta misma página desde el equipo local accediendo a `http://localhost`

![image.png](image%209.png)

Si modificamos el fichero index.html alojado en `/var/www/html`veremos que cambia la web

Código ejemplo del fichero: index.html

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>PRACTICA Hola Mundo</title>
</head>
<body>
    <h1>Hola Mundo</h1>
    <p>Soy Luis Solsona</p>
    <p>PRACTICA TUS AVANCES</p>
</body>
</html>
```

![image.png](image%2010.png)

<aside>
⚠️

Todos los equipos que estén en la Red: **Privada1**, con la dirección de red establecida correctamente, se podrán visualizar entre ellos desde le navegador.

</aside>