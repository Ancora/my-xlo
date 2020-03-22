import 'package:flutter/material.dart';

class ImagesField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormField<List>(
      initialValue: [],
      builder: (state) {
        return Column(
          children: <Widget>[
            Container(
              color: Colors.blue[300],
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.value.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.value.length) {
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 16),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue[400],
                          radius: 54,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.camera_enhance,
                                size: 50,
                                color: Colors.white,
                              ),
                              /* Text(
                                '+ Inserir',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ), */
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
