# Práctica particiones con GParted

<aside>
  
👉🏽 Esta práctica consiste en realizar particiones a un disco duro en un sistema operativo ya instalado.

</aside>

<aside>
  
📚 Para ello deberás de:

- [ ]  Configurar el Escritorio Virtual
- [ ]  Establecer un medio y orden de arranque correcto en la máquina
- [ ]  Crear/Modificar particiones del sistema
</aside>

Supongamos que queremos realizar prácticas con discos y particiones. Para ello podemos partir de cualquier plantilla ya existente y crearnos un escritorio. Procederemos a arrancarlo con una ISO ‘live’, nosotros vamos a utilizar GPARTED. [https://gparted.org/](https://gparted.org/)

<aside>
  
ℹ️ **Recuerda**: siempre utiliza **páginas oficiale**s y **software original**

</aside>

Con esta práctica podremos trabajar: 

• **Particiones**: Podremos gestionar particiones en el disco.

• **Volúmenes** lógicos: Creamos un pv en el disco y vg/lv encima.

• **RAID**: Podemos crear particiones en el disco y crear RAID encima.

<aside>
  
🧑🏽‍🏫 PROFE!! Recuerda que puedes **convertirlo en plantilla** para compartirlo con el alumnado.

O si quieres, puedes **convertirlo en despliegue** para tener control sobre los Escritorios.

</aside>

# Incluir el disco GPARTED a nuestros Escritorios

En este caso, el medio ya esta compartido con nosotros, sino bastaría con añadirlo nuevo.

![image.png](image.png)

# Arrancamos desde el entorno gráfico.

Elegimos un Escritorio y primero vamos a arrancar con normalidad e intentar crear particiones desde el entorno gráfico. 

Para ello establecemos el orden de arranque desde el disco duro. **`Boot > Hard Disk`**

![image.png](image%201.png)

Abrimos la aplicación DISCOS

![image.png](image%202.png)

Veremos que hay ciertas opciones que no nos permiten hacer

![image.png](image%203.png)

![image.png](image%204.png)

![image.png](image%205.png)

Tendremos que hacerlo con el Sistema Operativo “apagado”…. 

# Modificar Arranque del Escritorio

Establecemos que el Escritorio arranque desde el medio (la iso) que hemos añadido > GParted

**`Boot > CD/DVD`**

![image.png](image%206.png)

# Seguimos los pasos del UI de GParted

Si se ha arrancado desde el medio(iso) de GParted, nos aparecerá una ventana similar a esta…

![image.png](image%207.png)

Elegimos el idioma. Español —> 25

![image.png](image%208.png)

Continuamos en modo gráfico con la opción (0)

![image.png](image%209.png)

Ya podremos trabajar con el disco duro del Escritorio!! 

![image.png](image%2010.png)

A partir de aquí ya puedes realizar las particiones, volúmenes…

![image.png](image%2011.png)

En este ejemplo vamos a redimensionar para crear otra partición en el Escritorio.

![image.png](image%2012.png)

![image.png](image%2013.png)

Genial! Parece que todo ha funcionado sin problema…

# Volver a arrancar el Escritorio

Vamos a intentar crear particiones desde el entorno gráfico. Para ello establecemos el orden de arranque desde el disco duro. **`Boot > Hard Disk`**

![image.png](image%201.png)

Y abriendo la aplicación DISCOS ya vemos que tenemos el espacio disponible.

![image.png](image%2014.png)
