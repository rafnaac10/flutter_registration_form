import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _formKey =GlobalKey<FormState>();
  final dobController=TextEditingController();
  final timeController=TextEditingController();
  bool termsError=false;
  bool genderError=false;
  bool isDark = false;
  String? gender;
  DateTime? dob;
  String? country;
  bool? agreeTerms=false;
  double age = 18;
  TimeOfDay? time;
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 168, 127, 178),
          leading: Icon(Icons.person_2_outlined),
          title: Text(
            "Registration Form",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          centerTitle: true,

          actions: [
            Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 5),
            Switch(
              value: isDark,
              activeThumbColor: Colors.white,
              activeTrackColor: const Color.fromARGB(255, 10, 32, 49),
              inactiveThumbColor: const Color.fromARGB(255, 10, 32, 49),
              inactiveTrackColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });
              },
            ),
            const SizedBox(width: 20),
            const Icon(Icons.more_vert),
            const SizedBox(width: 20),
          ],
        ),
             

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
     children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Create Account",
                        style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        height: 2,
                            ),
                          ),

                      TextSpan(
                        text: "\nFill in your details to get started",
                        style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 15,
                        height: 2,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
        ),

           //FORM//
        Padding(
          padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextFormField(   
                     textInputAction: TextInputAction.next,
                     onFieldSubmitted: (_) { 
                        FocusScope.of(context)
                            .requestFocus(emailFocus);
                      }, //name
                    validator: (value) {
                      if(value==null||value.isEmpty){
                         return"This field is required";
                      } if(value.length <3){
                         return "Minimum 3 charecters";
                      }
                         return null;
                      },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person),
                      helperText: " Eg: Peter Pan",
                      hintText: "Enter your name",
                      border: OutlineInputBorder(gapPadding: 20),
                          ),
                        ),

                        SizedBox(height: 15),

                  TextFormField(//email
                  focusNode: emailFocus,
                  textInputAction: TextInputAction.next,
                     onFieldSubmitted: (_) { 
                        FocusScope.of(context)
                            .requestFocus(phoneFocus);
                      },
                    validator: (value) {
                      if(value==null||value.isEmpty){
                         return"This field is required";
                      }
                      RegExp emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if(!emailRegex.hasMatch(value)){
                         return "Invalid email";
                      }
                       return null;
                      },
                      keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      helperText: " Eg: 123@gmail.com",
                      hintText: "Enter your Email ID",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(gapPadding: 20),
                          ),
                        ),

                        SizedBox(height: 15),

                  TextFormField(//Phone
                  focusNode: phoneFocus,
                  textInputAction: TextInputAction.next,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return"This field is required";
                      }if(value.length!=10){
                        return "Must be ten digits";
                      }
                        return null;
                      },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                      keyboardType:TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      helperText: "Eg: 12345 54321",
                      hintText: "Enter your Phone number",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(gapPadding: 20),
                           ),
                        ),

                        SizedBox(height: 15),

                  TextFormField(//dob
                    showCursor: false,
                    validator: (value) {
                      if(dob==null){
                      return "This field is required";
                      }
                      return null;
                      },
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText:dob==null? "Select your date of birth":"${dob!.day}/${dob!.month}/${dob!.year}",
                        suffixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(gapPadding: 20),
                    ),
                    onTap: ()async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context, 
                        initialDate:DateTime.now(),
                        firstDate: DateTime(1950), 
                        lastDate: DateTime.now(),
                      );
                    if(pickedDate !=null){
                      setState(() {
                        dob=pickedDate;
                        dobController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      });
                    }
                    }
                  ),

                            SizedBox(height:18),

                  TextFormField(//time
                    showCursor: false,
                    validator: (value) {
                      if(time==null){
                      return "This field is required";                            
                      }
                    },
                    controller: timeController,
                    decoration: InputDecoration(
                     suffixIcon: Icon(Icons.access_time),
                     labelText:time==null? "Choose a time": time!.format(context),
                     border: OutlineInputBorder(gapPadding: 20),
                    ),
                    onTap: () async{
                      TimeOfDay ? pickedTime =await showTimePicker(
                        context: context, 
                        initialTime: TimeOfDay.now(),
                        );
                      if(pickedTime !=null){
                       setState(() {
                         time=pickedTime;
                         timeController.text = pickedTime.format(context);
                        });
                      }
                    },
                 ), //timeover
                          
                          SizedBox(height:20),

                  Text( " Gender",//gender
                    textAlign:TextAlign.right,
                    style: TextStyle( fontSize:16,fontWeight: FontWeight.bold,),
                  ),
                        SizedBox(height:18),
                  RadioGroup(
                    groupValue: gender,
                    onChanged:(value){
                      setState(() {
                        gender=value;
                        genderError=false;
                      });
                    }, 
                    child:Column(
                      children: [
                        RadioListTile(value: "Male", title: Text("Male"),),
                        RadioListTile(value: "Female", title: Text("Female"),),
                      ],
                    ),
                  ),
                    if(genderError)Text("This field is required",style: TextStyle(color: Colors.red,fontSize: 12),),//genderover
                     
                     SizedBox(height:18),

                  DropdownButtonFormField(
                     //country
                    items: [
                      DropdownMenuItem(value:"India", child: Text("India"),),
                      DropdownMenuItem(value:"UAE", child: Text("UAE"),),
                      DropdownMenuItem(value:"Canada", child: Text("Canada"),),
                    ], 
                    onChanged:(value){
                      setState(() {
                        country=value;
                      });
                    },
                    decoration: InputDecoration(
                       labelText: "Country",
                       border:OutlineInputBorder(),
                      ),
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return"This field is required";
                      } return null; },
                  ),

                      SizedBox(height:18),//C over
 
                  TextFormField(//password
                    validator: (value) {
                      if(value==null||value.isEmpty){
                          return "This field is required";
                      }if(value.length<8){
                        return"Minimum 8 Charecters";
                      }return null; },
                    obscureText: true,
                    obscuringCharacter:"*",
                    decoration: InputDecoration(
                     labelText: "Password",
                     hintText: "Enter your Password",
                     prefixIcon: Icon(Icons.lock),
                     border: OutlineInputBorder(gapPadding: 20),
                    ),
                  ),//P over

                     SizedBox(height:18),

                  Text("Age: ${age.toInt()}"),
                    Slider(
                      value: age,
                      min: 10,
                      max:80,
                      divisions: 80,
                      onChanged: (value){
                       setState(() {
                          age=value;
                        });
                       }
                    ),

                            SizedBox(height:20),

                  CheckboxListTile(
                    title:Text("I agree Terms & Conditions"),
                    value: agreeTerms,
                    onChanged: (value){
                      setState(() {
                        agreeTerms=value;
                        termsError=false;
                      });
                    }
                  ),
                  if(termsError)
                     Padding(padding: EdgeInsets.all(15),
                      child: Text("You must accept terms and conditions",
                      style: TextStyle(color: Colors.red.shade700,fontSize: 12),),
                      ),//T over
                          
                          SizedBox(height:18),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                 ElevatedButton(//submit
                   onPressed: (){
                    if(gender == null){
                      setState(() {
                        genderError=true;
                      });
                    }
                    if(agreeTerms == false){
                      setState(() {
                        termsError=true;
                      });
                    }
                    if(!_formKey.currentState!.validate() && gender!=null && agreeTerms == true){}
                    },
                    child: Text("Submit"),
                  ),
                  SizedBox(width:20),
                  ElevatedButton(
                    onPressed: (){
                      _formKey.currentState!.reset();
                       setState(() {
                         gender = null;
                         country = null;
                         agreeTerms = false;
                         dob = null;
                         time = null;
                         age = 18;
                         genderError = false;
                         termsError = false;
                         dobController.clear();
                         timeController.clear();
                       });
                    }, 
                    child:Text("Reset"),
                    ),
                ],),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
