/*
  health advisor app
  author: Krzysztof Matuszewski <krzysiekmatuszewski@outlook.com>
  github: @matuszewski
  description: This is a flutter mobile application for calculating health
               and diet indicators such as BMI, BMR or daily water consumption
  license: MIT
  AHE Lodz 2023
*/
import 'package:flutter/material.dart';

void main() => runApp(const HealthAdvisorApp());

final ThemeData customTheme = ThemeData(
  primaryColor: Colors.red,
  scaffoldBackgroundColor: Color(0xfff6f6f6), // Ivory-like background color
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.green[500], // Medium green color for FAB
  ),
);

class HealthAdvisorApp extends StatelessWidget {
  const HealthAdvisorApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/bmi': (context) => const BMICalculator(),
        '/bmr': (context) => const BMRCalculator(),
        '/water': (context) => const WaterCalculator(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Advisor'),
        backgroundColor: Colors.black,
        toolbarHeight: 100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Aplikacja do obliczania wskaźników\nzdrowotnych',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
                'Krzysztof Matuszewski\nAHE Łódź 2023/2024\nkrzysiekmatuszewski@outlook.com',
                style: TextStyle(fontSize: 14)),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/bmi');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple, // Background color
                onPrimary: Colors.white, // Text color
                minimumSize: Size(200, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child:
                  const Text('BMI Calculator', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/bmr');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Background color
                onPrimary: Colors.white, // Text color
                minimumSize: Size(200, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child:
                  const Text('BMR Calculator', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/water');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Background color
                onPrimary: Colors.white, // Text color
                minimumSize: Size(200, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child:
                  const Text('Kalkulator wody', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double weight = 70.0;
  double height = 170.0;
  double bmi = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enter your details:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
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
                const Text('Weight: ', style: TextStyle(fontSize: 18)),
                Text(weight.toStringAsFixed(1), style: TextStyle(fontSize: 18)),
                const Text(' kg', style: TextStyle(fontSize: 18)),
              ],
            ),
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
                const Text('Height: ', style: TextStyle(fontSize: 18)),
                Text(height.toStringAsFixed(1), style: TextStyle(fontSize: 18)),
                const Text(' cm', style: TextStyle(fontSize: 18)),
              ],
            ),
            Text('Your BMI: ${bmi.toStringAsFixed(1)}',
                style: TextStyle(height: 5, fontSize: 40)),
          ],
        ),
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
  double weight = 70.0;
  double height = 170.0;
  String gender = 'Male';
  double bmr = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator BMR'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enter your details:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Age:', style: TextStyle(fontSize: 18)),
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
                Text(age.toString(), style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Gender:', style: TextStyle(fontSize: 18)),
                Radio<String>(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      calculateBMR();
                    });
                  },
                ),
                const Text('Male', style: TextStyle(fontSize: 18)),
                Radio<String>(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      calculateBMR();
                    });
                  },
                ),
                const Text('Female', style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Weight:', style: TextStyle(fontSize: 18)),
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
                Text(weight.toStringAsFixed(1), style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Height:', style: TextStyle(fontSize: 18)),
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
                Text(height.toStringAsFixed(1), style: TextStyle(fontSize: 18)),
              ],
            ),
            Text('Your BMR: ${bmr.toStringAsFixed(1)} kcal/day',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void calculateBMR() {
    if (gender == 'Male') {
      bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
    } else {
      bmr = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age);
    }
  }
}

class WaterCalculator extends StatefulWidget {
  const WaterCalculator({Key? key});

  @override
  _WaterCalculatorState createState() => _WaterCalculatorState();
}

class _WaterCalculatorState extends State<WaterCalculator> {
  int age = 25;
  double weight = 70.0;
  double height = 170.0;
  String gender = 'Male';
  double bmr = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator wody'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enter your details:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Age:', style: TextStyle(fontSize: 18)),
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
                Text(age.toString(), style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Gender:', style: TextStyle(fontSize: 18)),
                Radio<String>(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      calculateBMR();
                    });
                  },
                ),
                const Text('Male', style: TextStyle(fontSize: 18)),
                Radio<String>(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      calculateBMR();
                    });
                  },
                ),
                const Text('Female', style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Weight:', style: TextStyle(fontSize: 18)),
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
                Text(weight.toStringAsFixed(1), style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Height:', style: TextStyle(fontSize: 18)),
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
                Text(height.toStringAsFixed(1), style: TextStyle(fontSize: 18)),
              ],
            ),
            Text('Your BMR: ${bmr.toStringAsFixed(1)} kcal/day',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void calculateBMR() {
    if (gender == 'Male') {
      bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
    } else {
      bmr = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age);
    }
  }
}
