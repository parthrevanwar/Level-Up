import 'package:flutter/material.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/links.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/material.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/pyq.dart';
// import 'package:mark_it/src/repository/subject_repository/subject_repo.dart';

class SubjectScreen extends StatefulWidget {
  SubjectScreen({super.key, required this.subjectname});

  final String subjectname;

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> with SingleTickerProviderStateMixin{


  late TabController _tabController ;
  @override
  void initState(){
    _tabController = new TabController(length: 3, vsync: this,initialIndex: 0)..addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectname, style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600),),
        leading: BackButton(),
        backgroundColor: Colors.white,
        bottom: TabBar(
          tabs: [
            Tab(child: Text("Material",style: TextStyle(fontSize: 18),),),
            Tab(child: Text("Links",style: TextStyle(fontSize: 18),),),
            Tab(child: Text("PYQ",style: TextStyle(fontSize: 18),),),
          ], indicatorColor: Color.fromARGB(255, 32, 159, 166),
          controller: _tabController,
          labelColor: Color.fromARGB(255, 32, 159, 166),
          indicatorSize: TabBarIndicatorSize.tab ,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MaterialScreen(),
          LinksScreen(),
          PYQScreen(),
        ],
      ),
    );
  }
}
