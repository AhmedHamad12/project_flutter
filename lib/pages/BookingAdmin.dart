import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/pages/notificationpage.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({Key? key}) : super(key: key);

  @override
  State<BookingAdmin> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingAdmin> {
  final List<QueryDocumentSnapshot> data = [];

  Future<void> getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Booking").get();
    setState(() {
      data.addAll(querySnapshot.docs);
    });
  }

  Future<void> deleteBooking(String id) async {
    try {
      await FirebaseFirestore.instance.collection("Booking").doc(id).delete();
      setState(() {
        data.removeWhere((doc) => doc.id == id);
      });
    } catch (e) {
      print("Error deleting booking: $e");
    }
  }

  Future<void> updateBooking(String id, Map<String, dynamic> newData) async {
    try {
      await FirebaseFirestore.instance.collection("Booking").doc(id).update(newData);
      DocumentSnapshot updatedDoc = await FirebaseFirestore.instance.collection("Booking").doc(id).get();
      setState(() {
        int index = data.indexWhere((doc) => doc.id == id);
        if (index != -1) {
          data[index] = updatedDoc as QueryDocumentSnapshot;
          
        }
      });
      // Navigate to NotificationPage after update
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NotificationPage();
      }));
    } catch (e) {
      print("Error updating booking: $e");
    }
  }

  Future<void> showUpdateDialog(String id) async {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController serviceNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: serviceNameController,
                decoration: InputDecoration(labelText: 'Service Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateBooking(id, {
                  'description': descriptionController.text,
                  'servicename': serviceNameController.text,
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF345069),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NotificationPage();
                }));
              },
              icon: const Icon(Icons.notifications_active, color: Colors.white),
            ),
          ],
          backgroundColor: const Color(0xFF345069),
          title: const Center(
            child: Text(
              'Bookings',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 181, 185, 185).withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.bookmark,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'New Booking',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    data[index]["description"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: const Icon(Icons.person),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]["servicename"],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Booking App',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  showUpdateDialog(data[index].id);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteBooking(data[index].id);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
