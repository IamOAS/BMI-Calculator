import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/constants.dart';
import 'results_page.dart';
import '../components/round_icon_button.dart';
import '../components/bottom_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;

  Color maleCardColor = kInactiveCardColor;
  Color femaleCardColor = kInactiveCardColor;

  Gender male = Gender.male;
  Gender female = Gender.female;
  int height = 180;
  int weight = 60;
  int age = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: Row(children: [
            Expanded(
              child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectedGender = male;
                  });
                },
                colour: selectedGender == male
                    ? kActiveCardColor
                    : kInactiveCardColor,
                cardChild: IconContent(
                  genderLabel: 'MALE',
                  genderIcon: FontAwesomeIcons.mars,
                ),
              ),
            ),
            Expanded(
              child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectedGender = female;
                  });
                },
                colour: selectedGender == female
                    ? kActiveCardColor
                    : kInactiveCardColor,
                cardChild: IconContent(
                  genderLabel: 'FEMALE',
                  genderIcon: FontAwesomeIcons.venus,
                ),
              ),
            ),
          ]),
        ),
        Expanded(
          child: ReusableCard(
            colour: kActiveCardColor,
            cardChild:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('HEIGHT', style: kGenderLabelTextStyle),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      height.toString(),
                      style: kNumbersTextStyle,
                    ),
                    Text(
                      'cm',
                      style: kGenderLabelTextStyle,
                    ),
                  ]),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Color(0xFFFFFFFF),
                  inactiveTrackColor: Color(0xFF8D8E98),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  thumbColor: Color(0xFFEB1555),
                  overlayColor: Color(0x29EB1555),
                ),
                child: Slider(
                  min: 120.0,
                  max: 220.0,
                  value: height.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      height = newValue.round();
                    });
                  },
                ),
              ),
            ]),
          ),
        ),
        Expanded(
          child: Row(children: [
            Expanded(
              child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('WEIGHT', style: kGenderLabelTextStyle),
                      Text(weight.toString(), style: kNumbersTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              }),
                          SizedBox(width: 10),
                          RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              }),
                        ],
                      )
                    ]),
              ),
            ),
            Expanded(
              child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('AGE', style: kGenderLabelTextStyle),
                      Text(age.toString(), style: kNumbersTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              }),
                          SizedBox(width: 10),
                          RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              }),
                        ],
                      )
                    ]),
              ),
            ),
          ]),
        ),
        BottomButton(
          buttonTitle: 'CALCULATE',
          onTap: () {
            CalculatorBrain calc =
                CalculatorBrain(height: height, weight: weight);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  bmiResult: calc.calculateBMI(),
                  interpretation: calc.getInterpretation(),
                  resultText: calc.getResult(),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
