import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/login_button.dart';
import 'package:plant_it/features/cart/presentation/views/cart_view.dart';

class DescriptionView extends StatefulWidget {
  const DescriptionView({super.key});

  @override
  _DescriptionViewState createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  bool isStarFilled = false;
  int quantity = 0 ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF66BB6A),
                Color(0xFF43A047),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/image1.png',
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: IconButton(
                              icon: Icon(
                                isStarFilled ? Icons.star : Icons.star_border,
                                color: isStarFilled ? Colors.red : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  isStarFilled = !isStarFilled;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "50\$",
                              style: GoogleFonts.montserrat(
                                fontSize: getResponsiveFontSize(context,
                                    fontSize: 14),
                              ),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Shadow Category",
                              style: GoogleFonts.montserrat(
                                fontSize: getResponsiveFontSize(context,
                                    fontSize: 14),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text("Lotus Flower",style: GoogleFonts.montserrat(
                    fontSize: getResponsiveFontSize(context, fontSize: 25),
                    color: Colors.white
                  ),),
                  const SizedBox(height: 30,),
                  IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              style: GoogleFonts.montserrat(
                                fontSize: getResponsiveFontSize(context,
                                    fontSize: 14),
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          child:  Icon(Icons.add,size: getResponsiveFontSize(context, fontSize: 25),),
                      onTap: () {
                        quantity++;
                        setState(() {

                        });
                      },
                      ),
                       Text('$quantity',style: GoogleFonts.montserrat(
                         fontSize: getResponsiveFontSize(context, fontSize: 25)
                       ),),
                      InkWell(
                        child:  Icon(Icons.remove, size: getResponsiveFontSize(context, fontSize: 25),),
                        onTap: () {
                          if (quantity >0) {
                            quantity--;
                          }
                          setState(() {
                          });
                        },
                      ),                    ],
                  ),
                  const SizedBox(height: 20,),
                  CustButton(onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const CartView(),));
                  }, text: "Add to cart")

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
