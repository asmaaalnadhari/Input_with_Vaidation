import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//---------------------------------------------------------
void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body:MainPage(),
          )
      )
  );
}

TextField BorderField()
{
  return  TextField(
    style: TextStyle(
        color: Colors.redAccent

    ),
    cursorColor: Colors.green,
    cursorWidth: 10,
    decoration: InputDecoration(
        prefixText: 'Email :',
        hintText: 'Hint Email :',
        labelText:'label Email :' ,
        helperText: 'helper Text',
        suffixText:'IS' ,
        // suffixIcon:Text('Cs'),
        suffixIcon: Icon(Icons.visibility_off),
        labelStyle: TextStyle(
            color: Colors.purpleAccent,
            fontSize: 40
        ),
        contentPadding:
        EdgeInsets.symmetric(
            vertical: 40,horizontal: 40),
        enabledBorder:OutlineInputBorder(
          borderSide: BorderSide(
            width: 5,
            color: Colors.blueAccent,
          ),
          borderRadius: BorderRadius.circular(
              40
          ),
        ) ,
        focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: BorderSide(
                width: 2,
                color: Colors.green
            )
        )
    ),
  );
}
//----------------------------
TextField noBorderField()
{
  return const TextField(
    style: TextStyle(
        color: Colors.deepPurple

    ),
    cursorColor: Colors.grey,
    decoration: InputDecoration(
        prefixText: 'Email :',
        hintText: 'Hint Email :',
        labelText:'label Email :' ,
        helperText: 'helper Text',
        suffixText: 'Suffix Email',
        labelStyle: TextStyle(
            color: Colors.black
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        border: InputBorder.none
    ),
  );
}
//----------------------------
TextFormField textFormField()
{
  return TextFormField(
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
                color: Colors.deepPurpleAccent
            )
        )
    ),
    validator: (value)
    {
      if(value!.contains('#'))
      {
        return'Error input';
      }

    },
  );
}
//--------------------------



//--------------------------
class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //-------------Begin Variables---------------
  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  //-------------End Variables---------------

  @override
  Widget build(BuildContext context) =>
      Form(
        key: formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        //---------------View Screen-------------------
        // child:   VerticalDivider(
        //   color: Colors.red,
        //   thickness: 5,
        //   indent: 13,
        // ),
        child: ListView(
          // scrollDirection:Axis.horizontal,
          padding: EdgeInsets.all(40),
          children: [
            BorderField(),
            const SizedBox(height: 16),
            underLineBorderField(),
            const SizedBox(height: 16),
            noBorderField(),
            const SizedBox(height: 16),
            buildUsername(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 32),
            buildPassword(),
            const SizedBox(height: 32),
            buildSubmit(),
          ],
        ),
      );

  //UserNameField:
  Widget buildUsername() => TextFormField(
    decoration: const InputDecoration(
      labelText: 'Username',
      border: OutlineInputBorder(),
      // errorBorder:
      //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
      // // focusedErrorBorder:
      // //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
      // errorStyle: TextStyle(color: Colors.purple),
    ),
    validator: (value) {
      if (value!.length < 4) {
        return 'Enter at least 4 characters';
      } else {
        return null;
      }
    },
    maxLength: 30,

    onSaved: (value) => setState(() => username = value!),
  );
  //UserEmailField:
  Widget buildEmail() => TextFormField(
    decoration: const InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
      final regExp = RegExp(pattern);
      if (value!.isEmpty) {
        return 'Enter an email';
      }
      else if (!regExp.hasMatch(value))
      {
        return 'Enter a valid email';
      }
      else {
        return null;
      }
    },
    keyboardType: TextInputType.emailAddress,
    onSaved: (value) => setState(() => email = value!),
  );
  //UserPasswordField:
  Widget buildPassword() => TextFormField(
    decoration: const InputDecoration(
      labelText: 'Password',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value!.length < 7) {
        return 'Password must be at least 7 characters long';
      } else {
        return null;
      }
    },
    onSaved: (value) => setState(() => password = value!),
    keyboardType: TextInputType.phone,
    obscureText: true,
    obscuringCharacter: '*',
  );

  //ButtonSubmit
  Widget buildSubmit() =>
      ElevatedButton(
        child: Text('Submit'),
        onPressed: () {
          final isValid = formKey.currentState!.validate();
          // FocusScope.of(context).unfocus();
          if (isValid) {
            formKey.currentState!.save();
            final message =
                'Username: $username\nPassword: $password\nEmail: $email';
            final snackBar =
            SnackBar(
              content: Text(
                message,
                style: TextStyle(fontSize: 20),
              ),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      );
}
//-------------------------------
class underLineBorderField extends StatefulWidget {
  underLineBorderField({Key? key}) : super(key: key);

  @override
  State<underLineBorderField> createState() => _underLineBorderField();
}

class _underLineBorderField extends State<underLineBorderField> {
  TextEditingController amountTextEditingController =TextEditingController();
  bool amountErrorStatus=false ;
  @override
  Widget build(BuildContext context) {
    return  TextField(
        style: const TextStyle(
            color: Colors.deepPurple
        ),
        cursorColor: Colors.yellow,
        cursorRadius: Radius.circular(10.2),
        cursorWidth: 4,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.streetAddress,
        onChanged: (value){
          print(value);
          amountErrorStatus = validateAmount(value);
          //amountErrorStatus=flase;
          if (!amountErrorStatus) {
            amountTextEditingController.text = value;
          }
        },

        controller: amountTextEditingController,
        decoration: InputDecoration(
          // enabledBorder:  UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         color: Colors.purple
          //     )
          // ),
          // focusedBorder:  UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         color: Colors.purple
          //     )
          // ),
          errorText:amountErrorStatus? 'Do not be empty':null,
          errorBorder:
          amountErrorStatus?
          const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.yellow
              )
          )
              :
          UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.yellow
              )
          ),


          prefixText: 'Email :',
          hintText: 'Hint Email :',
          labelText:'label Email :' ,
          helperText: 'helper Text',
          suffixText: 'Suffix Email',
          labelStyle: TextStyle(
              color: Colors.black
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        )

    );
  }

  bool validateAmount(String value) {
    bool amountErrorStatus = false;

    if (value.length <= 3) {
      setState(() {
        amountErrorStatus = true;
      });
      print(amountErrorStatus);

    }
    else if ((int.tryParse(value) ?? 0) < 500) {
      setState(() {
        amountErrorStatus = true;
      });
    }
    else {
      setState(() {
        amountErrorStatus = false;
      });
    }
    return amountErrorStatus;
  }
}

//--------------------------------


