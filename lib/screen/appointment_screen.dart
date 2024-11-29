import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget{
  @override
   List img=[
  "doctor1.jpg",
  "Doctors1.jpg",
  "Doctors3.jpg",
  "Doctors4.jpg",
  "Doctors5.jpg",
 ];

  AppointmentScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 63, 80, 193),
      body: SingleChildScrollView(
        child:Column(
          children: [
            const SizedBox(height: 50),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                     InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                  ],
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("images/Doctors1.jpg"),

                    ),
                    const SizedBox(height: 15),
                    const Text("Dr.Doctor Name",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    ),
                    const SizedBox(height: 5),
                    const Text("Therapist",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 162, 195, 222),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                        Icons.call,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 20),
                       Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 162, 195, 222),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                        CupertinoIcons.chat_bubble_text_fill,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),

                      ],
                    )
                  ],
                ),
                )
              ],
            ),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height/1.5,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: 15,
              ),

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("About Doctor",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Lorem Ipsum is simply dummy text of the printing and typeset ",
                  
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  ),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Text("Reviews",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.star,
                    color: Colors.yellow),
                    const Text("4.9",
                    style:TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    ),
                    const Text("(124)",
                    style:TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    ),

                    const Spacer(),
                    TextButton(onPressed:() {
                      
                    },
                     child: const Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromARGB(255, 79, 142, 193),

                      ),
                     ),
                     ),  
                  
                  ],
                  ),
                  SizedBox(height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder:(context,index){
                    return Container(
                         margin: const EdgeInsets.all(10),
                         padding: const EdgeInsets.symmetric(vertical: 5),
                         decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                         ),
                         child: SizedBox(
                          width:MediaQuery.of(context).size.width/1.4 ,
                          child: Column(children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage("images/${img[index]}"),
                            ),
                            title: const Text(
                              "Dr.Doctor Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            subtitle: const Text("1 day ago"),
                            trailing:const Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber),
                                  Text("4.9",
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),)
                              ],
                             
                            )
                            ),
                            const SizedBox(height: 5,),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                            
                            child: Text(" Many Thanks to Dr.Dear. He is great professional doctor",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:TextStyle(
                              color: Colors.black,

                            ),
                            ),
                            ),
                          ],
                          )
                          ,
                         ),
                         
                    );
                    },
                     ),
                     ),

                     const SizedBox(height: 10,),
                     const Text("Location",
                     style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                     ),
                     ),

                     ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          
                        ),
                        child: const Icon(Icons.location_on,
                        color: Color.fromARGB(255, 48, 114, 169),),
                      ),
                      title: const Text("New York Medical Center",
                      style: TextStyle(fontWeight: FontWeight.bold,
                      ),
                      ),
                      subtitle: const Text("address line of the medical center"),
                     ),



                ],
              ),
              
            )
          ],
        )
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        height: 150,
        decoration: const BoxDecoration(color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          spreadRadius: 2,
        ),
        ]
        ),
        child: Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Consulation Proce",
              style: TextStyle(
                color: Colors.black54,
              ),
              ),
              Text("\$100",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize:20,
              ),
              ),
            ],



          ),
          const SizedBox(height: 15,),
          InkWell(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text("Book Appointment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),),
              ),
            ),
          )
        ],),

      ),
    );
  }
}