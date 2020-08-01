import 'package:flutter/material.dart';
import 'class.dart' as classes;

main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateHome();
  }
}

class StateHome extends State<Home> {
  bool weAreReactiongNNaw = false;
  Offset pointerPos = Offset(0, 0);
  int reactId = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _posts(),
    );
  }

  _posts() {
    return ListView.builder(
      physics: weAreReactiongNNaw
          ? NeverScrollableScrollPhysics()
          : AlwaysScrollableScrollPhysics(),
      itemCount: classes.posts.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            // post
            Container(
              height: 450,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(blurRadius: 6, color: Colors.grey[400])
              ]),
              child: Column(
                children: [
                  // header
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 23,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("User Name"),
                        Expanded(
                          child: Center(),
                        ),
                        Icon(Icons.more_horiz),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),

                  // dividerv line
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                      height: 0,
                    ),
                  ),

                  //contnt
                  Expanded(
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 50),
                      ),
                    ),
                  ),

                  // dividerv line
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                      height: 0,
                    ),
                  ),

                  // like and comment btns
                  SizedBox(
                    height: 45,
                    child: Row(
                      children: [
                        //////// LIKE
                        Listener(
                          onPointerDown: (e) {
                            setState(() {
                              double dy = e.position.dy - 40;
                              pointerPos = new Offset(0, dy);

                              classes.posts[index].isReacting = true;
                              weAreReactiongNNaw = true;
                            });
                          },
                          onPointerUp: (e) {
                            setState(() {
                              classes.posts[index].isReacting = false;
                              weAreReactiongNNaw = false;

                              if (reactId != -1) {
                                classes.posts[index].reacted = true;
                                classes.posts[index].reactId = reactId;
                              }

                              reactId = -1;
                            });
                          },
                          onPointerMove: (e) {
                            setState(() {
                              updateReactId(e.position, pointerPos);
                              print(reactId);
                            });
                          },
                          child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width / 2,
                              height: 45,
                              onPressed: () {},
                              child: Row(
                                children: [
                                  classes.posts[index].reacted
                                      ? CircleAvatar(
                                        radius: 12,
                                          backgroundImage: AssetImage(classes
                                              .reacts[
                                                  classes.posts[index].reactId]
                                              .imageUrl),
                                        )
                                      : Center(),
                                      SizedBox(width: 5,),
                                  classes.posts[index].reacted
                                      ? Text(
                                          classes
                                              .reacts[
                                                  classes.posts[index].reactId]
                                              .name,
                                          style: TextStyle(
                                              color: updateColor(
                                                  classes.posts[index].reactId),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "Like",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                ],
                              )),
                        ),

                        // COmment
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 2,
                          height: 45,
                          onPressed: () {},
                          child: Text(
                            "Comment",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            /// reactions
            Container(
              height: 450,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Expanded(
                    child: Center(),
                  ),

                  // reactHolde
                  Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      // color: Colors.red.withOpacity(0.4),

                      //reactions
                      child: classes.posts[index].isReacting
                          ? Stack(
                              children: [
                                // reaction Container
                                Container(
                                  margin: EdgeInsets.only(top: 65),
                                  width: MediaQuery.of(context).size.width,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 12,
                                            color: Colors.grey[400])
                                      ]),
                                ),

                                // reactions
                                Container(
                                  padding: EdgeInsets.only(left: 8),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  child: ListView.builder(
                                    itemCount: classes.reacts.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return AnimatedContainer(
                                        duration: Duration(milliseconds: 100),
                                        margin: EdgeInsets.only(
                                            right: reactId == -1 ? 8 : 3,
                                            top: reactId == index
                                                ? 0
                                                : 120 -
                                                    ((MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            84) /
                                                        6) -
                                                    5),
                                        width: reactId == index
                                            ? (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    84) /
                                                4 *
                                                1.1
                                            : (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    84) /
                                                6,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(classes
                                                    .reacts[index].imageUrl))),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )
                          : Center()),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  updateReactId(Offset mOposition, Offset pointerposition) {
    double Screen = MediaQuery.of(context).size.width;
    double moX = mOposition.dx;

    Offset temp = Offset(0, mOposition.dy);

    if ((temp - pointerposition).distance < 50) {
      if (moX < (Screen / 6)) {
        reactId = 0;
      } else if (moX > Screen / 6 && moX < (Screen / 6) * 2) {
        reactId = 1;
      } else if (moX > (Screen / 6) * 2 && moX < (Screen / 6) * 3) {
        reactId = 2;
      } else if (moX > (Screen / 6) * 3 && moX < (Screen / 6) * 4) {
        reactId = 3;
      } else if (moX > (Screen / 6) * 4 && moX < (Screen / 6) * 5) {
        reactId = 4;
      } else if (moX > (Screen / 6) * 5 && moX < (Screen / 6) * 6) {
        reactId = 5;
      }
    } else {
      reactId = -1;
    }
  }

  updateColor(int index) {
    if (index == 0) {
      return Colors.blue;
    } else if (index == 1) {
      return Colors.red;
    } else if (index == 2) {
      return Colors.yellow;
    } else if (index == 3) {
      return Colors.yellow;
    } else if (index == 4) {
      return Colors.yellow;
    } else if (index == 5) {
      return Colors.orange;
    }
  }
}
