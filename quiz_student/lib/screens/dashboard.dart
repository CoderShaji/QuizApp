
import 'package:flutter/material.dart';
import 'package:quiz_student/screens/auth/change_password_screen.dart';
import 'package:quiz_student/screens/results.dart';
import 'package:quiz_student/services/auth_service.dart';
// import 'package:quiz_student/screens/take_quiz.dart';
import 'package:quiz_student/widgets/quizcodesheet.dart';

class Dashboard extends StatefulWidget {
const  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  colors = Theme.of(context).colorScheme;
  }

  @override
  Widget build(BuildContext context) {
    Widget createGridTile({required BuildContext context,required String text,required IconData icon , required  VoidCallback ontapaction}){
      return Padding(
              padding: const EdgeInsets.all( 8.0),
              child: InkWell(
                onTap: ontapaction,
                child: Container(
                  decoration: BoxDecoration(
                    // border: BoxBorder.all(color: Colors.black,strokeAlign: BorderSide.strokeAlignOutside,width: 2),
                    borderRadius: BorderRadius.circular(12),
                    // color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 7, blurStyle: BlurStyle.outer)
                    ]
                  // color: Colors.red,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(icon,size: 40,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(text,style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                ),),
            );
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Student Panel ',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900
          ),),
        ),
        actions: [
          IconButton(
            tooltip: 'Change password',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ChangePasswordScreen(),
                ),
              );
            },
            icon: const Icon(Icons.lock_reset_rounded),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () async {
              await AuthService.instance.signOut();
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(crossAxisCount: 2,
          children: [
            createGridTile(context: context, text: 'Take A Quiz', icon: Icons.assignment_add, ontapaction: (){ showquizcodesheet(context);} ),
            createGridTile(context: context, text: 'Results', icon: Icons.analytics_outlined, ontapaction:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Results()));
            } ),
          ],
          ),
        )
    ),);
  }
}
