import 'package:flutter/material.dart';
Image logoWidget(String imageName){
  return Image.asset(imageName,

    height: 50,
    width: 30
    ,
  );

}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(

    controller: controller,
    obscureText: isPasswordType,

    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,

    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black,

      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, style: BorderStyle.none, )),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: 50,
    height: 30,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black;
            }
            return Colors.black;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),

  );
}
Container signInSignupButton(BuildContext context , bool islogin, Function onTap){
  return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: 30,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ElevatedButton(
        onPressed: (){
          onTap();
        }, child: Text(
        islogin ? 'LOGIN' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16
        ),
      ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states){
              if(states.contains(MaterialState.pressed)){
                return Colors.black26;
              }
              return Color(0xffEF9C07);
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),

      )
  );
}

