🧩 Flutter Tasks App

Una aplicación desarrollada en Flutter utilizando Clean Architecture.
La app permite gestionar tareas conectadas con Firebase, implementando BLoC para el manejo del
estado y GetIt para la inyección de dependencias.

**Capa Data**

Contiene los modelos que representan los datos tal como se reciben de Firebase.

Los modelos son parseados desde JSON y luego convertidos a entidades de dominio.

Implementa los repositorios concretos que comunican esta capa con la de dominio.

**Capa Domain**

Define las entidades que representan los objetos de negocio.

Contiene los contratos de repositorio (interfaces) que abstraen la fuente de datos.

**Capa Presentation**

Utiliza BLoC (Business Logic Component) para la gestión del estado.

Cada bloque maneja eventos y estados específicos de su funcionalidad.

La UI escucha los cambios de estado y se actualiza de forma reactiva.

El proyecto utiliza GetIt como service locator, permitiendo una inyección de dependencias
centralizada y desacoplada.


| Componente             | Descripción                                            |
| ---------------------- | ------------------------------------------------------ |
| **Flutter**            | Framework principal de desarrollo                      |
| **Firebase**           | Backend para almacenamiento y sincronización de tareas |
| **BLoC**               | Gestión del estado basada en eventos y estados         |
| **GetIt**              | Inyección de dependencias (Service Locator)            |
| **Clean Architecture** | Separación por capas de responsabilidad                |
| **Equatable**          | Simplificación de comparaciones de objetos en BLoC     |

## Correr Tests

Para correr los test, ejecuta el siguiente comando:

```bash
  flutter test test/firebase_collection_test.dart
```

