# Actualizar plantillas - cambio de vCPU, RAM y GPU

Al añadir nuevas tarjetas gráficas hay que actualizar / asociar las plantillas anteriores a los nuevos recursos.

Necesitas un rol de **Administrador**

Acceder a la administración > DOMAINS > TEMPLATES

Localizaremos todas las plantillas que hay que modificar.

Filtrar por:

* usuario: **Admin o Adminsitrator**
* plantillas con **GPU** (tienen icono calendario)
* y **HABILITADAS**

![image.png](image.png)

Una vez localizada, se modifica las características de HW.

Establecer:  **6 CPU |  16GM RAM | GPU NVIDIA A16 4Q - NVIDIA vGPU A16 with profile 4Q**

En la siguiente animación se ve el proceso:

![actualizar-plantillas-GPU.gif](actualizar-plantillas-GPU.gif)

## vCPUS, RAM y GPU:

**GPU NVIDIA A16 4Q - NVIDIA vGPU A16 with profile 4Q**

![image.png](image%201.png)

**6 CPU |  16GM RAM**

![image.png](image%202.png)
