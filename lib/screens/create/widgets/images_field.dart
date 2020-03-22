import 'package:flutter/material.dart';
import 'package:myxlo/screens/create/widgets/image_source_sheet.dart';

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
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ImageSourceSheet((image) {
                            if (image != null) {
                              state.didChange(state.value..add(image));
                            }
                            Navigator.of(context).pop();
                          }),
                        );
                      },
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
                                size: 52,
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
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.file(state.value[index]),
                              FlatButton(
                                onPressed: () {
                                  state.didChange(state.value..removeAt(index));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Excluir'),
                                textColor: Colors.white,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                      child: CircleAvatar(
                        backgroundImage: FileImage(state.value[index]),
                        radius: 54,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
