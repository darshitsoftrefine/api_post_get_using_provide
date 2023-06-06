import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api_provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String baseUrl = 'https://coupinos-app.azurewebsites.net';


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<Api_Provider>(context, listen: false).getAllDetails();
      // context.watch<Api_Provider>().getAllDetails();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Provider API"),
        ),
        body: Consumer<Api_Provider>(
          builder: (context, value, child) {
            return value.isLoading ? Center(child: CircularProgressIndicator()):
              ListView.builder(
                  itemCount: value.contDetail?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child:  CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 150,
                            child: CircleAvatar(
                              radius: 115,
                              backgroundImage: NetworkImage('$baseUrl${value.contDetail?[index].postedBy.profilePicUrl}'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text('Post Id: '+'${value.contDetail?[index].id}', style: const TextStyle(fontSize: 20),),
                        const SizedBox(height: 10,),
                        Text("Name: "+'${value.contDetail?[index].postedBy.firstName}'+" "+'${value.contDetail?[index].postedBy.lastName}', style: const TextStyle(fontSize: 20),),
                        const SizedBox(height: 10,),
                        Text('User Id: '+'${value.contDetail?[index].postedBy.userId}'),
                        const SizedBox(height: 10,),
                        Text('Address: '+'${value.contDetail?[index].address}'),
                        const SizedBox(height: 10,),
                        Text('Created At: ${value.contDetail?[index].createdAt.day}/${value.contDetail?[index].createdAt.month}/${value.contDetail?[index].createdAt.year}'),
                        const SizedBox(height: 10,),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Status: " +'${value.contDetail?[index].status}'),
                              const SizedBox(width: 5,),
                              const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 5,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text('Type: '+'${value.contDetail?[index].type}'),
                        const SizedBox(height: 10,),
                        Text('Post Author: '+'${value.contDetail?[index].postAuthor}')
                      ],
                    ),
                  ),
                );
              }
            );

          },
        )
    );
  }
}
