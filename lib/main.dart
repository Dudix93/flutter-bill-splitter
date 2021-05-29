import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: BillSplitter()));
}

class HelloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello World",
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.red, fontSize: 24)),
    );
  }
}

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  final _mainColor = Colors.grey.shade500;
  final _textStyle = TextStyle(
      color: Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 20);
  final _buttonStyle = TextStyle(
      color: Colors.grey.shade100, fontWeight: FontWeight.bold, fontSize: 20);

  var _billValue = 0.0;
  var _numberOfPeople = 1;
  var _tipPercentage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculate bill")),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _mainColor.withOpacity(0.4))),
              child: Column(
                children: [
                  TextField(
                    controller:
                        TextEditingController(text: _billValue.toString()),
                    style: _textStyle,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: "Bill"),
                    onChanged: _onBillValueChanged,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Number of people", style: _textStyle),
                      Row(
                        children: [
                          InkWell(
                            onTap: _onRemovePerson,
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: _mainColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child:
                                  Center(child: Text("-", style: _buttonStyle)),
                            ),
                          ),
                          Text("$_numberOfPeople", style: _textStyle),
                          InkWell(
                            onTap: _onAddPerson,
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: _mainColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child:
                                  Center(child: Text("+", style: _buttonStyle)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip:", style: _textStyle),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("${_totalTip().toStringAsFixed(2)} GBP",
                            style: _textStyle),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Slider(
                        value: _tipPercentage.toDouble(),
                        onChanged: _onTipPercentageChange,
                        min: 0,
                        max: 100,
                        divisions: 20,
                        activeColor: Colors.blue.shade300,
                        inactiveColor: _mainColor,
                      ),
                      Text("$_tipPercentage %", style: _textStyle)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Bill per person: ${((_totalTip() + _billValue) / _numberOfPeople).toStringAsFixed(2)} GBP",
                style: _textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  _onBillValueChanged(String value) {
    print(value);
    try {
      _billValue = double.parse(value);
    } catch (exception) {
      _billValue = 0;
    }
  }

  _onAddPerson() {
    setState(() => {_numberOfPeople++});
  }

  _onRemovePerson() {
    if (_numberOfPeople > 1) {
      setState(() => {_numberOfPeople--});
    }
  }

  _totalTip() {
    return (_billValue * _tipPercentage) / 100;
  }

  _onTipPercentageChange(double value) {
    setState(() => _tipPercentage = value.round());
  }
}
