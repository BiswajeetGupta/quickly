import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickly/screens/homeProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    int pageNo = 1;
    final favProvider = Provider.of<HomeProvider>(context, listen: false);
    favProvider.apiData(context, pageNo);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        pageNo++;
        favProvider.apiData(context, pageNo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          if (value.usersList.isEmpty) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: value.usersList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < value.usersList.length) {
                        return Dismissible(
                          key: Key(value.usersList[index]['id'].toString()),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              value.usersList.removeAt(index);
                              value.notifiers();
                            }
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16.0),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                value.usersList[index]['avatar'],
                              ),
                              radius: 40.0,
                            ),
                            isThreeLine: true,
                            title: Text(
                              value.usersList[index]['first_name'],
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.usersList[index]['email'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  value.usersList[index]['id'].toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  value.usersList[index]['last_name'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
