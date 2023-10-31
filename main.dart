import 'package:flutter/material.dart';

void main() => runApp(const BMICalculatorApp());

final ThemeData customTheme = ThemeData(
  primaryColor: Colors.red, // Change this color to your desired primary color
  // Add more properties like textTheme, fontFamily, etc. if needed
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor:
        Colors.green, // Change this color to your desired FAB color
  ),
);

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme, // Use the custom theme here
      initialRoute: '/',

      routes: {
        '/': (context) => const BMICalculator(),
        '/bmr': (context) => const BMRCalculator(),
        '/bmi': (context) => const BMICalculator(),
      },
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double weight = 70.0; // Initial weight in kilograms
  double height = 170.0; // Initial height in centimeters
  double bmi = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkualtor BMI'),
        backgroundColor: Colors.purple, // Set the background color to purple
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Wpisz swoje dane:',
              style: TextStyle(fontSize: 18),
            ),
            // Weight input
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Slider(
                  value: weight,
                  min: 0.0,
                  max: 150.0,
                  onChanged: (newValue) {
                    setState(() {
                      weight = newValue;
                      calculateBMI();
                    });
                  },
                ),
                const Text('waga: '),
                Text(weight.toStringAsFixed(1)),
                const Text(' kg'),
              ],
            ),
            // Height input
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Slider(
                  value: height,
                  min: 0.0,
                  max: 220.0,
                  onChanged: (newValue) {
                    setState(() {
                      height = newValue;
                      calculateBMI();
                    });
                  },
                ),
                const Text('wysokość: '),
                Text(height.toStringAsFixed(1)),
                const Text(' cm'),
              ],
            ),
            Text('Twoje BMI: ${bmi.toStringAsFixed(1)}',
                style: TextStyle(height: 5, fontSize: 40)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/bmr');
        },
        child: const Icon(Icons.accessibility_new),
      ),
    );
  }

  void calculateBMI() {
    final heightInMeters = height / 100;
    bmi = weight / (heightInMeters * heightInMeters);
  }
}

class BMRCalculator extends StatefulWidget {
  const BMRCalculator({Key? key});

  @override
  _BMRCalculatorState createState() => _BMRCalculatorState();
}

class _BMRCalculatorState extends State<BMRCalculator> {
  int age = 25;
  double weight = 70.0; // Initial weight in kilograms
  double height = 170.0; // Initial height in centimeters
  String gender = 'Male';
  double bmr = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkualtor BMR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Wpisz swoje dane:',
              style: TextStyle(fontSize: 18),
            ),
            // Age input
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Wiek:'),
                Slider(
                  value: age.toDouble(),
                  min: 0,
                  max: 100,
                  onChanged: (newValue) {
                    setState(() {
                      age = newValue.toInt();
                      calculateBMR();
                    });
                  },
                ),
                Text(age.toString()),
              ],
            ),
            // Gender selection
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Płeć:'),
                Radio<String>(
                  value: 'Mężczyzna',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      calculateBMR();
                    });
                  },
                ),
                const Text('Mężczyzna'),
                Radio<String>(
                  value: 'Kobieta',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      calculateBMR();
                    });
                  },
                ),
                const Text('Kobieta'),
              ],
            ),
            // Weight input
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Waga:'),
                Slider(
                  value: weight,
                  min: 0.0,
                  max: 150.0,
                  onChanged: (newValue) {
                    setState(() {
                      weight = newValue;
                      calculateBMR();
                    });
                  },
                ),
                Text(weight.toStringAsFixed(1)),
              ],
            ),
            // Height input
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Wysokość:'),
                Slider(
                  value: height,
                  min: 0.0,
                  max: 220.0,
                  onChanged: (newValue) {
                    setState(() {
                      height = newValue;
                      calculateBMR();
                    });
                  },
                ),
                Text(height.toStringAsFixed(1)),
              ],
            ),
            Text('Twoje BMR: ${bmr.toStringAsFixed(1)} kcal/dziennie'),
          ],
        ),
      ),
    );
  }

  void calculateBMR() {
    if (gender == 'Mężczyzna') {
      bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
    } else {
      bmr = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age);
    }
  }
}
