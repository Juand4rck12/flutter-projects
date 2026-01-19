# Flutter Development Guide

Guía de referencia rápida para el desarrollo moderno con Flutter 3.x. Este documento contiene conceptos esenciales, widgets fundamentales y mejores prácticas.

## Tabla de Contenido

- [Estructura Básica de una App](#estructura-básica-de-una-app)
  - [MaterialApp](#materialapp)
  - [Scaffold](#scaffold)
- [Widgets de Layout Esenciales](#widgets-de-layout-esenciales)
  - [Container](#container)
  - [Column y Row](#column-y-row)
  - [Stack](#stack)
  - [ListView y GridView](#listview-y-gridview)
- [Widgets de Input](#widgets-de-input)
  - [TextField](#textfield)
  - [TextFormField](#textformfield)
  - [Otros Inputs](#otros-inputs)
- [Botones](#botones)
- [Navegación](#navegación)
  - [Navigator Básico](#navigator-básico)
  - [Rutas Nombradas](#rutas-nombradas)
  - [Navegación Avanzada](#navegación-avanzada)
- [State Management](#state-management)
  - [setState](#setstate)
  - [ValueNotifier y ValueListenableBuilder](#valuenotifier-y-valuelistenablebuilder)
  - [InheritedWidget y Provider](#inheritedwidget-y-provider)
- [Async y FutureBuilder](#async-y-futurebuilder)
  - [FutureBuilder](#futurebuilder)
  - [StreamBuilder](#streambuilder)
- [Imágenes](#imágenes)
- [Temas y Estilos](#temas-y-estilos)
- [Mejores Prácticas](#mejores-prácticas)
- [Widgets Útiles Adicionales](#widgets-útiles-adicionales)
- [Debugging](#debugging)
- [Shortcuts de Productividad](#shortcuts-de-productividad)

## Estructura Básica de una App

### MaterialApp

El punto de entrada de tu aplicación Material Design. Define configuraciones globales como tema, rutas y la página inicial.

```dart
MaterialApp(
  title: 'Mi App',
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true, // Habilita Material 3
  ),
  home: const HomePage(),
  debugShowCheckedModeBanner: false,
)
```

**Cuándo usar:** Siempre como widget raíz de tu aplicación Material.

### Scaffold

Proporciona la estructura visual básica de Material Design: AppBar, Body, FloatingActionButton, Drawer, BottomNavigationBar, etc.

```dart
Scaffold(
  appBar: AppBar(title: const Text('Título')),
  body: const Center(child: Text('Contenido')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),
)
```

**Cuándo usar:** En cada pantalla que necesite la estructura estándar de Material Design.

## Widgets de Layout Esenciales

### Container

Widget versátil para decoración, dimensionamiento y posicionamiento. Combina múltiples widgets de un solo hijo (padding, margin, decoration).

```dart
Container(
  width: 200,
  height: 100,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(vertical: 8),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: const Text('Contenido'),
)
```

**Cuándo usar:** Cuando necesites decoración, padding/margin o dimensiones específicas. Para casos simples, considera usar `Padding`, `SizedBox` o `DecoratedBox` directamente.

### Column y Row

Organizan widgets hijos vertical u horizontalmente.

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center, // Eje principal (vertical)
  crossAxisAlignment: CrossAxisAlignment.start, // Eje cruzado (horizontal)
  mainAxisSize: MainAxisSize.min, // Ocupa solo el espacio necesario
  children: [
    Text('Item 1'),
    Text('Item 2'),
  ],
)
```

**Propiedades clave:**
- `mainAxisAlignment`: Alineación en el eje principal
- `crossAxisAlignment`: Alineación en el eje cruzado
- `mainAxisSize`: `max` (ocupa todo el espacio) o `min` (solo necesario)

### Stack

Apila widgets uno encima de otro. Útil para overlays y posicionamiento absoluto.

```dart
Stack(
  children: [
    Image.network('url'),
    Positioned(
      bottom: 10,
      right: 10,
      child: Icon(Icons.favorite),
    ),
  ],
)
```

### ListView y GridView

Para listas scrolleables. Usa el constructor `.builder` para listas dinámicas y eficientes.

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index]),
    );
  },
)

// Para listas separadas
ListView.separated(
  itemCount: items.length,
  separatorBuilder: (context, index) => const Divider(),
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
)
```

**Truco:** Para listas cortas y estáticas usa `ListView`, para listas largas y dinámicas usa `ListView.builder`.

## Widgets de Input

### TextField

Campo de entrada de texto básico.

```dart
TextField(
  controller: _controller, // TextEditingController para manejar el texto
  decoration: const InputDecoration(
    labelText: 'Nombre',
    hintText: 'Ingresa tu nombre',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.person),
  ),
  keyboardType: TextInputType.text,
  textInputAction: TextInputAction.done,
  onChanged: (value) {
    // Se ejecuta cada vez que cambia el texto
  },
  onSubmitted: (value) {
    // Se ejecuta al presionar enter/done
  },
)
```

**Tipos de teclado comunes:**
- `TextInputType.text`: Teclado estándar
- `TextInputType.number`: Teclado numérico
- `TextInputType.emailAddress`: Teclado de email
- `TextInputType.phone`: Teclado telefónico
- `TextInputType.multiline`: Para texto multilínea

### TextFormField

Versión de TextField integrada con Form para validación.

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido';
          }
          if (!value.contains('@')) {
            return 'Email inválido';
          }
          return null; // Validación exitosa
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Formulario válido
          }
        },
        child: const Text('Enviar'),
      ),
    ],
  ),
)
```

### Otros Inputs

```dart
// Checkbox
Checkbox(
  value: _checked,
  onChanged: (bool? value) {
    setState(() => _checked = value ?? false);
  },
)

// Switch
Switch(
  value: _enabled,
  onChanged: (bool value) {
    setState(() => _enabled = value);
  },
)

// Radio
Radio<String>(
  value: 'opcion1',
  groupValue: _selectedOption,
  onChanged: (String? value) {
    setState(() => _selectedOption = value);
  },
)

// Slider
Slider(
  value: _currentSliderValue,
  min: 0,
  max: 100,
  divisions: 10,
  label: _currentSliderValue.round().toString(),
  onChanged: (double value) {
    setState(() => _currentSliderValue = value);
  },
)
```

## Botones

Flutter 3.x usa botones actualizados de Material 3:

```dart
// Botón elevado (el más prominente)
ElevatedButton(
  onPressed: () {},
  child: const Text('Elevated'),
)

// Botón de texto (menos énfasis)
TextButton(
  onPressed: () {},
  child: const Text('Text'),
)

// Botón con borde
OutlinedButton(
  onPressed: () {},
  child: const Text('Outlined'),
)

// Botón con icono
ElevatedButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.add),
  label: const Text('Agregar'),
)

// IconButton
IconButton(
  onPressed: () {},
  icon: const Icon(Icons.settings),
)
```

**Deshabilitar botón:** Pasa `null` al `onPressed`.

## Navegación

### Navigator Básico

```dart
// Navegar a nueva pantalla
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DetalleScreen()),
)

// Regresar
Navigator.pop(context)

// Regresar con datos
Navigator.pop(context, 'resultado')

// Esperar resultado
final resultado = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DetalleScreen()),
)
```

### Rutas Nombradas

Define rutas en MaterialApp:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomeScreen(),
    '/detalles': (context) => const DetalleScreen(),
    '/configuracion': (context) => const ConfigScreen(),
  },
)

// Navegar
Navigator.pushNamed(context, '/detalles')

// Con argumentos
Navigator.pushNamed(
  context,
  '/detalles',
  arguments: {'id': 123},
)

// Recibir argumentos
final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>
```

### Navegación Avanzada

```dart
// Reemplazar pantalla actual
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const LoginScreen()),
)

// Limpiar stack y navegar
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const HomeScreen()),
  (route) => false, // Remueve todas las rutas anteriores
)

// Navegar y mantener solo la home
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const NuevaScreen()),
  ModalRoute.withName('/'),
)
```

## State Management

### setState

Método básico para actualizar el estado local de un StatefulWidget.

```dart
class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++; // Solo lo que está aquí se reconstruye
    });
  }
}
```

**Cuándo usar:** Para estado simple y local a un widget.

### ValueNotifier y ValueListenableBuilder

Alternativa ligera a setState para valores específicos.

```dart
final ValueNotifier<int> _counter = ValueNotifier<int>(0);

ValueListenableBuilder<int>(
  valueListenable: _counter,
  builder: (context, value, child) {
    return Text('$value');
  },
)

// Actualizar
_counter.value++
```

### InheritedWidget y Provider

Para compartir estado entre widgets sin pasarlo manualmente. Provider es el paquete más popular.

```dart
// pubspec.yaml
// dependencies:
//   provider: ^6.1.1

// Modelo
class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// Proveer
ChangeNotifierProvider(
  create: (_) => Counter(),
  child: MyApp(),
)

// Consumir
Consumer<Counter>(
  builder: (context, counter, child) {
    return Text('${counter.count}');
  },
)

// O usar directamente
final counter = context.watch<Counter>();
context.read<Counter>().increment(); // No reconstruye
```

## Async y FutureBuilder

### FutureBuilder

Construye widgets basados en el resultado de un Future.

```dart
FutureBuilder<String>(
  future: fetchData(), // Tu función async
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    
    if (snapshot.hasData) {
      return Text('Datos: ${snapshot.data}');
    }
    
    return const Text('Sin datos');
  },
)
```

**Importante:** No crees el Future dentro del build. Créalo en `initState` o como variable de clase.

### StreamBuilder

Similar a FutureBuilder pero para Streams (múltiples valores).

```dart
StreamBuilder<int>(
  stream: _stream,
  initialData: 0,
  builder: (context, snapshot) {
    return Text('Valor: ${snapshot.data}');
  },
)
```

## Imágenes

```dart
// Desde assets (configura en pubspec.yaml)
Image.asset('assets/images/logo.png')

// Desde red
Image.network('https://example.com/image.jpg')

// Con placeholder y error
Image.network(
  'url',
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return const CircularProgressIndicator();
  },
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.error);
  },
)
```

## Temas y Estilos

### Tema Global

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
  ),
)
```

### Acceder al Tema

```dart
final theme = Theme.of(context);
final colorScheme = theme.colorScheme;

Text(
  'Texto',
  style: theme.textTheme.headlineLarge,
)

Container(
  color: colorScheme.primary,
)
```

## Mejores Prácticas

### Const Widgets

Usa `const` siempre que sea posible para mejorar el rendimiento. Los widgets const no se reconstruyen.

```dart
const Text('Hola') // Mejor
Text('Hola') // Menos eficiente
```

### Extrae Widgets

Si un widget se vuelve complejo, extráelo a su propia clase. Mejora legibilidad y rendimiento.

```dart
// En lugar de
Column(
  children: [
    Container(
      // 50 líneas de código
    ),
  ],
)

// Haz
class _CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 50 líneas de código
    );
  }
}
```

### Keys

Usa keys cuando necesites preservar el estado de widgets en listas dinámicas.

```dart
ListView.builder(
  itemBuilder: (context, index) {
    return MyWidget(key: ValueKey(items[index].id));
  },
)
```

### Dispose

Siempre limpia recursos en `dispose` de StatefulWidget.

```dart
@override
void dispose() {
  _controller.dispose();
  _scrollController.dispose();
  _focusNode.dispose();
  super.dispose();
}
```

### MediaQuery

Obtén información sobre el dispositivo y tamaño de pantalla.

```dart
final size = MediaQuery.of(context).size;
final width = size.width;
final height = size.height;
final padding = MediaQuery.of(context).padding; // SafeArea padding

// Responsive
if (width > 600) {
  // Tablet o desktop
} else {
  // Mobile
}
```

### SafeArea

Evita áreas como notch, barra de estado y barra de navegación.

```dart
SafeArea(
  child: YourWidget(),
)
```

## Widgets Útiles Adicionales

### Expanded y Flexible

Controla cómo los hijos de Row/Column ocupan el espacio disponible.

```dart
Row(
  children: [
    Expanded(
      flex: 2, // Ocupa 2/3 del espacio
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1, // Ocupa 1/3 del espacio
      child: Container(color: Colors.blue),
    ),
  ],
)

// Flexible permite que el widget ocupe menos espacio si es posible
Flexible(
  child: Text('Texto que puede no ocupar todo el espacio'),
)
```

### SizedBox

Widget simple para dimensiones o spacing.

```dart
SizedBox(width: 100, height: 50, child: MyWidget())

// Como spacer
SizedBox(height: 20) // Espacio vertical
SizedBox(width: 20)  // Espacio horizontal
```

### Padding

Agrega padding sin usar Container.

```dart
Padding(
  padding: const EdgeInsets.all(16),
  child: Text('Con padding'),
)
```

### Card

Widget de Material Design con elevación y bordes redondeados.

```dart
Card(
  elevation: 4,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Text('Contenido'),
  ),
)
```

### Spacer

Crea espacio flexible entre widgets en Row/Column.

```dart
Row(
  children: [
    Text('Izquierda'),
    Spacer(), // Empuja el siguiente widget a la derecha
    Text('Derecha'),
  ],
)
```

### Divider

Línea horizontal para separar contenido.

```dart
Divider(
  color: Colors.grey,
  thickness: 1,
  indent: 16, // Margen izquierdo
  endIndent: 16, // Margen derecho
)
```

### CircularProgressIndicator

Indicador de carga circular.

```dart
const CircularProgressIndicator()

// Con tamaño específico
SizedBox(
  width: 24,
  height: 24,
  child: CircularProgressIndicator(strokeWidth: 2),
)
```

## Debugging

```dart
// Print en consola
print('Mensaje de debug');
debugPrint('Mensaje de debug'); // Mejor para producción

// Inspeccionar widget tree
debugDumpApp(); // Imprime árbol de widgets

// Performance
import 'package:flutter/rendering.dart';
debugPaintSizeEnabled = true; // Muestra bordes de widgets
```

## Shortcuts de Productividad

- **stless**: Genera StatelessWidget
- **stful**: Genera StatefulWidget
- **Ctrl/Cmd + .**: Quick fixes en VS Code
- **Alt + Enter**: Quick fixes en Android Studio
- **r**: Hot reload en terminal
- **R**: Hot restart en terminal

---

**Recursos adicionales:**
- Documentación oficial: https://docs.flutter.dev
- Widget catalog: https://docs.flutter.dev/ui/widgets
- Cookbook: https://docs.flutter.dev/cookbook
